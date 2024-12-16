import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend2/dto/user_dto.dart';
import 'package:frontend2/repository/authentication_repository.dart';
import 'package:frontend2/viewmodel/localstorage_manager.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../../constants/urls.dart';
import '../../exceptions/field_validation_exception.dart';
import '../../model/user.dart';

class AuthenticationViewModel with ChangeNotifier {
  bool _isLoading;
  bool _isAuthenticated;
  AuthenticationRepository repository;
  late User _user;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  bool isWaitingAdmin = false;
  StompClient? _stompClient;

  // Ошибки валидации
  String? errorMessage;
  String? usernameError;
  String? passwordError;
  String? repeatPasswordError;

  bool get isLoading => _isLoading;

  bool get isAuthenticated => _isAuthenticated;

  User get user => _user;

  AuthenticationViewModel(this.repository)
      : _isLoading = true,
        _isAuthenticated = false;

  Future<void> checkAuthStatus() async {
    _isLoading = true;

    try {
      final token = await getToken();
      if (token != null) {
        final response = await repository.checkToken(token);
        _user = User.fromResponse(response);
        _isAuthenticated = true;
      } else {
        _isAuthenticated = false;
      }
    } catch (e) {
      _isAuthenticated = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signUp() async {
    dropInputErrors();
    if (passwordController.text != repeatPasswordController.text) {
      repeatPasswordError = 'Пароли не совпадают';
      notifyListeners();
      return false;
    }
    try {
      final request = SignUpRequest(
        username: usernameController.text,
        password: passwordController.text,
        isWaitingAdmin: isWaitingAdmin,
      );
      final response = await repository.signUp(request);
      // Если всё успешно, обновляем состояние
      _user = User.fromResponse(response);
      saveToken(response.token);
      if (_user.isWaitingAdmin) {
        initializeSetWaitingAdminStatus(_user.token);
      }
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      // Распределяем ошибки по полям
      if (e is FieldValidationException) {
        usernameError = e.errors['username'];
        passwordError = e.errors['password'];
      } else {
        errorMessage = e.toString(); // Общая ошибка, если структура другая
      }
      notifyListeners();
      return false;
    }
  }

  Future<bool> signIn() async {
    dropInputErrors();
    try {
      final userRequest = SignInRequest(
        username: usernameController.text,
        password: passwordController.text,
      );

      final response = await repository.signIn(userRequest);
      _user = User.fromResponse(response);
      saveToken(_user.token);
      if (_user.isWaitingAdmin) {
        initializeSetWaitingAdminStatus(_user.token);
      }
      _isAuthenticated = true;
      return true;
    } catch (e) {
      log(e.toString());
      // Показываем ошибку в интерфейсе
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    removeToken();
  }

  Future<void> setWaitingAdmin() async {
    _user.isWaitingAdmin = await repository.setWaitingAdmin(user);
    notifyListeners();
  }

  void dropInputErrors() {
    errorMessage = null;
    usernameError = null;
    passwordError = null;
    repeatPasswordError = null;
    notifyListeners();
  }

  void initializeSetWaitingAdminStatus(String token) {
    _stompClient = StompClient(
      config: StompConfig(
        url: ws, // Replace with your WebSocket endpoint
        onConnect: onSetWaitingAdminStatus,
        onStompError: (frame) {
          print('WebSocket STOMP error: ${frame.body}');
        },
        onWebSocketError: (dynamic error) {
          print('WebSocket connection error: ${error.toString()}');
        },
        stompConnectHeaders: {
          'Authorization': 'Bearer $token', // Add JWT token for authorization
        },
        webSocketConnectHeaders: {
          'Authorization': 'Bearer $token', // Add JWT token for WebSocket connection
        },
      ),
    );
    _stompClient?.activate();
  }

  void onSetWaitingAdminStatus(StompFrame frame) {
    _stompClient?.subscribe(
      destination: '/user/queue/updates',
      callback: (StompFrame frame) {
        final data = jsonDecode(frame.body!);
        _user.updateRoleStatus(data);
        notifyListeners();
      },
    );
  }
}
