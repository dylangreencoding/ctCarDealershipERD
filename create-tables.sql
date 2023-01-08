create table salespeople(
	salesperson_id SERIAL primary key
);

create table customers(
	customer_id SERIAL primary key
);

create table vehicles(
	vin_id VARCHAR(17) primary key,
	year_ INTEGER,
	make VARCHAR(10),
	model VARCHAR(10),
	customer_id INTEGER,
	foreign key(customer_id) references customers(customer_id)
);

--drop table vehicles;
--messed it up the first time

create table invoices(
	invoice_id SERIAL primary key,
	vin_id VARCHAR(17) not null,
	salesperson_id INTEGER not null,
	customer_id INTEGER not null,
	amount DECIMAL,
	foreign key(vin_id) references vehicles(vin_id),
	foreign key(salesperson_id) references salespeople(salesperson_id),
	foreign key(customer_id) references customers(customer_id)
);

create table mechanics(
	mechanic_id SERIAL primary key
);

create table parts_inventory(
	part_id SERIAL primary key,
	part_name VARCHAR(15),
	in_stock INTEGER
);

create table service_tickets(
	service_id SERIAL primary key,
	customer_id INTEGER not null,
	vin_id VARCHAR(17) not null,
	mechanic_id INTEGER not null,
	part_id INTEGER,
	notes VARCHAR(150),
	amount DECIMAL,
	foreign key(customer_id) references customers(customer_id),
	foreign key(vin_id) references vehicles(vin_id),
	foreign key(mechanic_id) references mechanics(mechanic_id),
	foreign key(part_id) references parts_inventory(part_id)
);