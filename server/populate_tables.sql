-- Table: public.customer_companies

DROP TABLE IF EXISTS public.customer_companies;

CREATE TABLE IF NOT EXISTS public.customer_companies
(
    company_id integer NOT NULL,
    company_name text COLLATE pg_catalog."default",
    CONSTRAINT customer_companies_pkey PRIMARY KEY (company_id)
)

TABLESPACE pg_default;



-- Table: public.customers

DROP TABLE IF EXISTS public.customers;

CREATE TABLE IF NOT EXISTS public.customers
(
    id integer NOT NULL,
    login text COLLATE pg_catalog."default",
    password text COLLATE pg_catalog."default",
    name text COLLATE pg_catalog."default",
    company_id integer,
    credit_cards text[] COLLATE pg_catalog."default",
    user_id text COLLATE pg_catalog."default",
    CONSTRAINT customers_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;


-- Table: public.deliveries

DROP TABLE IF EXISTS public.deliveries;

CREATE TABLE IF NOT EXISTS public.deliveries
(
    id numeric NOT NULL,
    order_item_id numeric,
    delivered_quantity numeric,
    CONSTRAINT deliveries_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;



-- Table: public.order_items

DROP TABLE IF EXISTS public.order_items;

CREATE TABLE IF NOT EXISTS public.order_items
(
    id numeric NOT NULL,
    order_id numeric,
    price_per_unit real,
    quantity numeric,
    product text COLLATE pg_catalog."default",
    CONSTRAINT order_items_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;


-- Table: public.orders

DROP TABLE IF EXISTS public.orders;

CREATE TABLE IF NOT EXISTS public.orders
(
    id integer NOT NULL,
    created_at timestamp with time zone,
    order_name text COLLATE pg_catalog."default",
    customer_id text COLLATE pg_catalog."default",
    CONSTRAINT orders_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;


insert into customer_companies (company_id,company_name) values 
(1,'Roga & Kopyta'),
(2,'Pupkin & Co');

insert into customers (id,user_id,login,password,name,company_id,credit_cards) values
(1,'ivan','ivan','12345','Ivan Ivanovich',1,Array['"*****-1234"', '"*****-5678"']),
(2,'petr','petr','54321','Petr Petrovich',2,Array['"*****-4321"', '"*****-8765"']);

insert into deliveries (id,order_item_id,delivered_quantity) values
(2,2,11),
(1,1,5),
(3,3,12),
(4,4,3),
(5,6,15),
(6,7,8),
(7,8,3),
(8,16,25),
(9,17,26),
(10,18,27),
(11,19,28),
(12,20,29),
(13,4,5),
(14,8,8),
(15,8,6);

insert into order_items (id,order_id,price_per_unit,quantity,product) values 
(1,1,1.3454,10,'Corrugated Box'),
(2,2,23.14,11,'Corrugated Box'),
(3,3,123.0345,12,'Corrugated Box'),


(5,5,100,14,'Corrugated Box'),
(6,6,1.5454,15,'Corrugated Box'),
(7,7,25.14,16,'Corrugated Box'),
(8,8,133.0345,17,'Corrugated Box'),
(9,9,13.456,18,'Corrugated Box'),
(10,10,110,19,'Corrugated Box'),
(11,1,45.2334,20,'Hand sanitizer'),


(13,3,273.1234,22,'Hand sanitizer'),
(14,4,11.45,23,'Hand sanitizer'),
(15,5,12.467,24,'Hand sanitizer'),
(16,6,11,25,'Hand sanitizer'),
(17,7,123,26,'Hand sanitizer'),
(18,8,173.1234,27,'Hand sanitizer'),
(19,9,23.876,28,'Hand sanitizer'),
(20,10,120,29,'Hand sanitizer');


insert into orders (id, created_at, order_name, customer_id) values 

    
(2,'2020-01-15T17:34:12Z','PO #002-I','ivan'),
(3,'2020-01-05T05:34:12Z','PO #003-I','ivan'),
(4,'2020-02-02T15:34:12Z','PO #004-I','ivan'),
(5,'2020-01-03T10:34:12Z','PO #005-I','ivan'),
(6,'2020-01-02T15:34:12Z','PO #001-P','petr'),
(7,'2020-01-15T17:34:12Z','PO #002-P','petr'),
(8,'2020-01-05T05:34:12Z','PO #003-P','petr'),
(9,'2020-02-02T15:34:12Z','PO #004-P','petr'),
(10,'2020-01-03T10:34:12Z','PO #005-P','petr');

