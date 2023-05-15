package com.aliyun.nest.springbootdemo.jpa;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

/**
 * @author diyu.gyc
 * @date 2022/12/04
 */
@Entity
@Table(name = "springboot_demo")
@Data
public class SpringbootDemoEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String name;
}
