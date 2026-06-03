create table users
(
    id         BIGINT auto_increment primary key,
    name       varchar(100) not null,
    email      varchar(255) not null,
    password   varchar(255) not null,
    phone      varchar(20) null,
    role       ENUM('ADMIN','CUSTOMER','RESTAURANT_OWNER','RIDER') NOT NULL,
    created_at timestamp default current_timestamp null,
    updated_at timestamp default current_timestamp null on update current_timestamp,
    constraint users_email_unique unique (email),
    constraint users_phone_unique unique (phone)
);

create table restaurants
(
    id         bigint                                  null
        primary key,
    name       varchar(150),
    address    varchar(255)                            not null,
    rating     decimal(2, 1) default 0                 null,
    is_open    boolean       default true              null,
    owner_id   bigint                                  null,
    created_at timestamp     default current_timestamp null,
    constraint restaurants_users_id_fk
        foreign key (owner_id) references users (id)
);

alter table restaurants
    modify name varchar(150) auto_increment;

create table categories
(
    id   bigint       null
        primary key,
    name varchar(100) null,
    constraint categories_uk_1
        unique (name)
);

create table menu_items
(
    id            bigint                              null
        primary key,
    name          varchar(150)                        not null,
    description   text                                null,
    price         decimal(10, 2)                      not null,
    available     boolean   default true              null,
    category_id   bigint                              null,
    restaurant_id bigint                              null,
    created_at    timestamp default current_timestamp null,
    constraint menu_items_category__fk
        foreign key (category_id) references categories (id),
    constraint menu_items_restaurant__fk
        foreign key (restaurant_id) references restaurants (id)
);

create table carts
(
    id          bigint                              null
        primary key,
    customer_id bigint                              null,
    created_at  timestamp default current_timestamp null,
    constraint carts_uk
        unique (customer_id),
    constraint carts_users_id_fk
        foreign key (customer_id) references users (id)
);

