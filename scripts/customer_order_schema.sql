-- CUSTOMER TABLE
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    first_name  VARCHAR2(50),
    last_name   VARCHAR2(50),
    email       VARCHAR2(100)
);

-- PRODUCTS TABLE
CREATE TABLE products (
    product_id   NUMBER PRIMARY KEY,
    product_name VARCHAR2(100),
    price        NUMBER
);

-- ORDERS TABLE
CREATE TABLE orders (
    order_id     NUMBER PRIMARY KEY,
    customer_id  NUMBER REFERENCES customers(customer_id),
    order_date   DATE,
    order_total  NUMBER
);

-- ORDER_ITEMS TABLE
CREATE TABLE order_items (
    order_item_id NUMBER PRIMARY KEY,
    order_id      NUMBER REFERENCES orders(order_id),
    product_id    NUMBER REFERENCES products(product_id),
    quantity      NUMBER,
    line_total    NUMBER
);

-- SAMPLE DATA
INSERT INTO customers VALUES (1, 'Alice', 'Johnson', 'alice@example.com');
INSERT INTO customers VALUES (2, 'Bob', 'Smith', 'bob@example.org');
INSERT INTO customers VALUES (3, 'Charlie', 'Davis', 'charlie@domain.com');
INSERT INTO customers VALUES (4, 'David', 'Lee', 'david@demo.com');
INSERT INTO customers VALUES (5, 'Emma', 'Brown', 'emma@test.com');

INSERT INTO products VALUES (1, 'Laptop', 1200);
INSERT INTO products VALUES (2, 'Phone', 800);
INSERT INTO products VALUES (3, 'Headphones', 150);

INSERT INTO orders VALUES (1, 1, SYSDATE - 20, 1200);
INSERT INTO orders VALUES (2, 2, SYSDATE - 10, 800);
INSERT INTO orders VALUES (3, 3, SYSDATE - 5, 300);

INSERT INTO order_items VALUES (1, 1, 1, 1, 1200);
INSERT INTO order_items VALUES (2, 2, 2, 1, 800);
INSERT INTO order_items VALUES (3, 3, 3, 2, 300);

COMMIT;
/
