package com.aliyun.nest.springbootdemo;

import java.util.Optional;

import com.aliyun.nest.springbootdemo.jpa.SpringbootDemoEntity;
import com.aliyun.nest.springbootdemo.jpa.SpringbootDemoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class SpringbootDemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootDemoApplication.class, args);
    }

    @Autowired
    private SpringbootDemoRepository springbootDemoRepository;

    @RequestMapping("/")
    public String home() {
        Optional<SpringbootDemoEntity> entity = springbootDemoRepository.findById(1L);
        return "Hello " + (entity.isPresent() ? entity.get().getName() : "");
    }

}
