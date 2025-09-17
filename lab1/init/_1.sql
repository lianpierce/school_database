CREATE DATABASE myDb1;


CREATE TABLE clients (
    clientid SERIAL PRIMARY KEY,
    firstname VARCHAR(60),
    lastname VARCHAR(60),
    email VARCHAR(100),
    date_joined TIMESTAMP,
    status BOOLEAN DEFAULT FALSE
);

CREATE TABLE orders (
    orderid SERIAL PRIMARY KEY,
    ordername VARCHAR(100),
    clientid INTEGER,
    FOREIGN KEY (clientid) REFERENCES clients(clientid)
);


DROP TABLE orders;
DROP TABLE clients;

DROP DATABASE myDb1;
