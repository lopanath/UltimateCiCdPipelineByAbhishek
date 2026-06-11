package com.example.Ultimate_CI_CD_Pipeline_By_Abhishek.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController 
{
    @GetMapping("/")
    public String get()
    {
        return "Hello Lopa";
    }
}

