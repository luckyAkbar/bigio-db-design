CREATE TABLE stores (
    id BIGINT PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE employees (
    id BIGINT PRIMARY KEY,
    store_id BIGINT not null,
    name TEXT NOT NULL
);

CREATE TABLE products (
    id BIGINT PRIMARY KEY,
    store_id BIGINT not null,
    name TEXT NOT NULL,
    price INT NOT NULL
);

CREATE TABLE shifts (
    id BIGINT PRIMARY KEY,
    store_id BIGINT not null,
    members BIGINT [] NOT NULL,
    start_at TIMESTAMP NOT NULL,
    finish_at TIMESTAMP NOT NULL
);

CREATE TABLE transactions (
    id BIGINT PRIMARY KEY,
    shift_id BIGINT not null,
    store_id BIGINT not null,
    product_id BIGINT not null,
    created_by BIGINT not null,
    created_at TIMESTAMP DEFAULT NOW(),
    quantity INT NOT NULL,
    price INT NOT NULL,
    total INT NOT NULL
);

ALTER TABLE employees ADD FOREIGN KEY ("store_id") REFERENCES stores("id");

ALTER TABLE products ADD FOREIGN KEY ("store_id") REFERENCES stores("id");

ALTER TABLE shifts ADD FOREIGN KEY ("store_id") REFERENCES stores("id");

ALTER TABLE transactions ADD FOREIGN KEY ("shift_id") REFERENCES shifts("id");
ALTER TABLE transactions ADD FOREIGN KEY ("store_id") REFERENCES stores("id");
ALTER TABLE transactions ADD FOREIGN KEY ("product_id") REFERENCES products("id");
ALTER TABLE transactions ADD FOREIGN KEY ("created_by") REFERENCES employees("id");

alter table transactions add constraint price_check CHECK(
	quantity > 0
	and quantity * price = total
);