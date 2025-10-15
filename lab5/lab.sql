CREATE TABLE employees (
    employee_id INTEGER,
    first_name TEXT,
    last_name TEXT,
    age INTEGER CHECK (age BETWEEN 18 AND 65),
    salary NUMERIC CHECK (salary > 0)
);

INSERT INTO employees VALUES (1, 'John', 'Doe', 30, 50000);
INSERT INTO employees VALUES (2, 'Jane', 'Smith', 45, 70000);

CREATE TABLE products_catalog (
    product_id INTEGER,
    product_name TEXT,
    regular_price NUMERIC,
    discount_price NUMERIC,
    CONSTRAINT valid_discount CHECK (
        regular_price > 0 AND discount_price > 0 AND discount_price < regular_price
    )
);

INSERT INTO products_catalog VALUES (1, 'Laptop', 1000, 900);
INSERT INTO products_catalog VALUES (2, 'Phone', 500, 400);

CREATE TABLE bookings (
    booking_id INTEGER,
    check_in_date DATE,
    check_out_date DATE,
    num_guests INTEGER CHECK (num_guests BETWEEN 1 AND 10),
    CHECK (check_out_date > check_in_date)
);

INSERT INTO bookings VALUES (1, '2025-10-10', '2025-10-15', 2);
INSERT INTO bookings VALUES (2, '2025-11-01', '2025-11-05', 4);


CREATE TABLE customers (
    customer_id INTEGER NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    registration_date DATE NOT NULL
);

CREATE TABLE inventory (
    item_id INTEGER NOT NULL,
    item_name TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity >= 0),
    unit_price NUMERIC NOT NULL CHECK (unit_price > 0),
    last_updated TIMESTAMP NOT NULL
);

INSERT INTO customers VALUES (1, 'john@example.com', '1234567890', '2025-01-01');
INSERT INTO inventory VALUES (1, 'Mouse', 10, 20.5, NOW());


CREATE TABLE users (
    user_id INTEGER,
    username TEXT,
    email TEXT,
    created_at TIMESTAMP,
    CONSTRAINT unique_username UNIQUE (username),
    CONSTRAINT unique_email UNIQUE (email)
);

INSERT INTO users VALUES (1, 'user1', 'u1@mail.com', NOW());
INSERT INTO users VALUES (2, 'user2', 'u2@mail.com', NOW());


CREATE TABLE course_enrollments (
    enrollment_id INTEGER,
    student_id INTEGER,
    course_code TEXT,
    semester TEXT,
    CONSTRAINT unique_enrollment UNIQUE (student_id, course_code, semester)
);


CREATE TABLE departments (
    dept_id INTEGER PRIMARY KEY,
    dept_name TEXT NOT NULL,
    location TEXT
);

INSERT INTO departments VALUES (1, 'HR', 'New York');
INSERT INTO departments VALUES (2, 'IT', 'Chicago');
INSERT INTO departments VALUES (3, 'Finance', 'Boston');


CREATE TABLE student_courses (
    student_id INTEGER,
    course_id INTEGER,
    enrollment_date DATE,
    grade TEXT,
    PRIMARY KEY (student_id, course_id)
);


CREATE TABLE employees_dept (
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT NOT NULL,
    dept_id INTEGER REFERENCES departments(dept_id),
    hire_date DATE
);

INSERT INTO employees_dept VALUES (1, 'Tom', 1, '2025-05-01');

CREATE TABLE authors (
    author_id INTEGER PRIMARY KEY,
    author_name TEXT NOT NULL,
    country TEXT
);

CREATE TABLE publishers (
    publisher_id INTEGER PRIMARY KEY,
    publisher_name TEXT NOT NULL,
    city TEXT
);

CREATE TABLE books (
    book_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    author_id INTEGER REFERENCES authors(author_id),
    publisher_id INTEGER REFERENCES publishers(publisher_id),
    publication_year INTEGER,
    isbn TEXT UNIQUE
);


CREATE TABLE ecommerce_customers (
    customer_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    registration_date DATE NOT NULL
);

CREATE TABLE ecommerce_products (
    product_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    price NUMERIC CHECK (price >= 0),
    stock_quantity INTEGER CHECK (stock_quantity >= 0)
);

CREATE TABLE ecommerce_orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES ecommerce_customers(customer_id) ON DELETE CASCADE,
    order_date DATE NOT NULL,
    total_amount NUMERIC CHECK (total_amount >= 0),
    status TEXT CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled'))
);

CREATE TABLE ecommerce_order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES ecommerce_orders(order_id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES ecommerce_products(product_id),
    quantity INTEGER CHECK (quantity > 0),
    unit_price NUMERIC CHECK (unit_price > 0)
);

INSERT INTO ecommerce_customers (name, email, phone, registration_date)
VALUES ('Alice', 'alice@mail.com', '111-222-3333', '2025-01-01'),
       ('Bob', 'bob@mail.com', '222-333-4444', '2025-02-15'),
       ('Charlie', 'charlie@mail.com', '333-444-5555', '2025-03-20');

INSERT INTO ecommerce_products (name, description, price, stock_quantity)
VALUES ('Laptop', 'Gaming laptop', 1200, 5),
       ('Mouse', 'Wireless mouse', 25, 100),
       ('Keyboard', 'Mechanical keyboard', 75, 50);

INSERT INTO ecommerce_orders (customer_id, order_date, total_amount, status)
VALUES (1, '2025-10-10', 1250, 'pending'),
       (2, '2025-10-12', 100, 'processing');

INSERT INTO ecommerce_order_details (order_id, product_id, quantity, unit_price)
VALUES (1, 1, 1, 1200),
       (1, 2, 2, 25),
       (2, 2, 4, 25);
