package com.lab1.backend.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory;
import com.lab1.backend.dto.MovieDto;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class FileParserService {

    private final ObjectMapper jsonMapper;
    private final ObjectMapper yamlMapper;
    private final Validator validator;

    public FileParserService() {
        this.jsonMapper = new ObjectMapper();
        this.yamlMapper = new ObjectMapper(new YAMLFactory());
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        this.validator = factory.getValidator();
    }

    public List<MovieDto> parseFile(InputStream fileStream, String filename) throws Exception {
        final var filenameArray = filename.split("\\.");
        final var extension = filenameArray[filenameArray .length - 1].toLowerCase();
        if (isJson(extension)) {
            return parseJson(fileStream);
        } else if (isYaml(extension)) {
            return parseYaml(fileStream);
        } else {
            throw new IllegalArgumentException("Unsupported content type: " + extension);
        }
    }

    private boolean isJson(String contentType) {
        return contentType != null && contentType.contains("json");
    }

    private boolean isYaml(String contentType) {
        return contentType != null && (contentType.contains("yaml"));
    }

    private List<MovieDto> parseJson(InputStream fileStream) throws Exception {
        return jsonMapper.readValue(fileStream,
                jsonMapper.getTypeFactory().constructCollectionType(List.class, MovieDto.class));
    }

    private List<MovieDto> parseYaml(InputStream fileStream) throws Exception {
        return yamlMapper.readValue(fileStream,
                yamlMapper.getTypeFactory().constructCollectionType(List.class, MovieDto.class));
    }

    private void validateMovies(List<MovieDto> movies) {
        for (MovieDto movie : movies) {
            Set<ConstraintViolation<MovieDto>> violations = validator.validate(movie);
            if (!violations.isEmpty()) {
                String errors = violations.stream()
                        .map(violation -> violation.getPropertyPath() + " " + violation.getMessage())
                        .collect(Collectors.joining(", "));
                throw new IllegalArgumentException("Validation failed: " + errors);
            }
        }
    }
}
