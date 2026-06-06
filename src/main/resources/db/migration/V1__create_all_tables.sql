create table users
(
    id         BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name       varchar(100) not null,
    email      varchar(255) not null,
    password   varchar(255) not null,
    phone      varchar(20) null,
    role       ENUM('ADMIN','CUSTOMER','RESTAURANT_OWNER','RIDER') NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    constraint users_email_unique unique (email),
    constraint users_phone_unique unique (phone)
);

create table restaurants
(
    id         BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name       varchar(150) null,
    address    varchar(255) NOT NULL,
    rating     DECIMAL(2,1) NULL DEFAULT 0,
    is_open    BOOLEAN NULL DEFAULT TRUE,
    owner_id   BIGINT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    constraint restaurants_users_id_fk
        foreign key (owner_id) references users (id)
);

create table categories
(
    id   BIGINT       AUTO_INCREMENT NOT NULL
        PRIMARY KEY,
    name varchar(100) NOT NULL,
    constraint categories_uk_1
        unique (name)
);

create table menu_items
(
    id            BIGINT AUTO_INCREMENT NOT NULL
        PRIMARY KEY,
    name          varchar(150) NOT NULL,
    description   text NULL,
    price         DECIMAL(10,2) NOT NULL,
    available     BOOLEAN NULL DEFAULT TRUE,
    category_id   BIGINT NULL,
    restaurant_id BIGINT NULL,
    created_at    TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    constraint menu_items_category__fk
        foreign key (category_id) references categories (id),
    constraint menu_items_restaurant__fk
        foreign key (restaurant_id) references restaurants (id)
);

create table carts
(
    id          BIGINT AUTO_INCREMENT NOT NULL
        PRIMARY KEY,
    customer_id BIGINT NULL,
    created_at  TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    constraint carts_uk
        unique (customer_id),
    constraint carts_users_id_fk
        foreign key (customer_id) references users (id)
);

create table cart_items
(
    id           BIGINT AUTO_INCREMENT NOT NULL
        PRIMARY KEY,
    cart_id      BIGINT NULL,
    menu_item_id BIGINT NULL,
    quantity     INT NOT NULL,
    constraint cart_items_cart__fk
        foreign key (cart_id) references carts (id),
    constraint cart_items_menu_item__fk
        foreign key (menu_item_id) references menu_items (id)
);

create table orders
(
    id               BIGINT AUTO_INCREMENT NOT NULL
        PRIMARY KEY,
    customer_id      BIGINT NULL,
    restaurant_id    BIGINT NULL,
    status           ENUM('PENDING','ACCEPTED','PREPARING','OUT_FOR_DELIVERY','DELIVERED','CANCELLED') NOT NULL DEFAULT 'PENDING',
    total_price      DECIMAL(10,2) NOT NULL,
    delivery_address VARCHAR(255) NOT NULL,
    created_at       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    constraint orders_customer__fk
        foreign key (customer_id) references users (id),
    constraint orders_restaurant__fk
        foreign key (restaurant_id) references restaurants (id)
);

create table order_items
(
    id           BIGINT AUTO_INCREMENT NOT NULL
        PRIMARY KEY,
    order_id     BIGINT NULL,
    menu_item_id BIGINT NULL,
    quantity     INT NOT NULL,
    price        DECIMAL(10,2) NOT NULL,
    constraint order_items_menu_items__fk
        foreign key (menu_item_id) references menu_items (id),
    constraint order_items_orders__fk
        foreign key (order_id) references orders (id)
);

create table deliveries
(
    id            BIGINT AUTO_INCREMENT NOT NULL
        PRIMARY KEY,
    order_id      BIGINT NULL,
    rider_id      BIGINT NULL,
    status        ENUM('ASSIGNED','PICKED_UP','DELIVERED') NOT NULL DEFAULT 'ASSIGNED',
    pickup_time   DATETIME NULL,
    delivery_time DATETIME NULL,
    constraint deliveries_uk
        unique (order_id),
    constraint deliveries_orders__fk
        foreign key (order_id) references orders (id),
    constraint deliveries_users__fk
        foreign key (rider_id) references users (id)
);
