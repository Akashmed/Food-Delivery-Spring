package com.akashmed.food_delivery.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class Test {

    @RequestMapping("/")
    public String index(){
        return "index.html"; //instead of the file the string was sent with @RestController annotation
    }
}
