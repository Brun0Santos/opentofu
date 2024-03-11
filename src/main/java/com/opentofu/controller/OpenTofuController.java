package com.opentofu.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/message")
public class OpenTofuController {
    private static Integer requestCount = 0;

    @GetMapping
    public String message() {
        requestCount += 1;
        return "Server is running.., number of requests: " + requestCount;
    }
}
