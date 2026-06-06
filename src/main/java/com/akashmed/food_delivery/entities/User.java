package com.akashmed.food_delivery.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;
import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "phone")
    private String phone;

    @Column(name = "role")
    @Enumerated(EnumType.STRING)
    private Role role;

    @Column(name = "created_at", insertable = false, updatable = false)
    private LocalDate createdAt;

    @Column(name = "updated_at", insertable = false, updatable = false)
    private LocalDate updatedAt;

    @OneToOne(mappedBy = "customer")
    private Cart cart;

    @OneToMany(mappedBy = "rider")
    private Set<Delivery> deliveries = new LinkedHashSet<>();

    @OneToMany(mappedBy = "customer")
    private Set<Order> orders = new LinkedHashSet<>();

    @OneToMany(mappedBy = "owner")
    private Set<Restaurant> restaurants = new LinkedHashSet<>();

}