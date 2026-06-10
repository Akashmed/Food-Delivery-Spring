package com.akashmed.food_delivery.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "deliveries")
public class Delivery {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "rider_id")
    private User rider;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private String status;

    @Column(name = "pickup_time")
    private Instant pickupTime;

    @Column(name = "delivery_time")
    private Instant deliveryTime;

}