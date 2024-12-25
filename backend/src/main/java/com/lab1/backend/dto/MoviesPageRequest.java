package com.lab1.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MoviesPageRequest {
    Integer size;
    Integer page;
    String namePrefix;
    Integer minGoldenPalmCount;
    Boolean isUsaBoxOfficeUnique;
}
