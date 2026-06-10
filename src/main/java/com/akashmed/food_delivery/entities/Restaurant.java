package com.akashmed.food_delivery.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "restaurants")
public class Restaurant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "address")
    private String address;

    @Column(name = "rating")
    private BigDecimal rating;

    @Column(name = "is_open")
    private Boolean isOpen;

    @ManyToOne
    @JoinColumn(name = "owner_id")
    private User owner;

    @Column(name = "created_at")
    private Instant createdAt;

    @OneToMany(mappedBy = "restaurant")
    private Set<MenuItem> menuItems = new LinkedHashSet<>();

    @OneToMany(mappedBy = "restaurant")
    private Set<Order> orders = new LinkedHashSet<>();

}