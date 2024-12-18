import 'dart:convert';

import 'package:frontend2/dto/user_dto.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../constants/urls.dart';

class NotificationsRepository {
  void Function(UpdatedRoleResponse response) onUpdatedStatus;
  late StompClient _stompClient;

  NotificationsRepository(this.onUpdatedStatus);

  void updateStatus(String token) {
    _stompClient = StompClient(
      config: StompConfig(
        url: '$ws?token=$token',
        onConnect: (StompFrame frame) => _onUpdateStatusConnectCallback(frame),
      ),
    );

    _stompClient.activate();
  }

  void _onUpdateStatusConnectCallback(StompFrame frame) {
    _stompClient.subscribe(
      destination: '/user/queue/private',
      callback: (frame) {
        var updatedRole = UpdatedRoleResponse.fromJson(json.decode(frame.body!));
        onUpdatedStatus(updatedRole);
        deactivateStompClient();
      },
    );
  }

  void deactivateStompClient() {
    _stompClient.deactivate();
  }
}
