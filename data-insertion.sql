-- function to add vehicles:
create or replace function add_vehicle(
	_vin_id VARCHAR(17),
	_year_ INTEGER,
	_make VARCHAR(10),
	_model VARCHAR(10)
)
returns void
as $MAIN$
begin
	insert into vehicles (
		vin_id,
		year_,
		make,
		model
	) values (
		_vin_id,
		_year_,
		_make,
		_model
	);
end;
$MAIN$
language plpgsql;

-- add a few vehicles for sale: this function leaves vehicles.customer_id null, meaning the vehicle is for sale by the dealership
select add_vehicle('..wxyz', 1994, 'Toyota', 'Corolla');
select add_vehicle('..wxya', 2000, 'Chevy', 'Impala');
select add_vehicle('..wxyb', 1957, 'Ford', 'F-150');
select add_vehicle('..wxyc', 2022, 'Toyota', 'Prius');
select * from vehicles;

-- drop
drop function add_vehicle;

--function to add salespeople
create or replace function add_salesperson(_salesperson_id INTEGER)
returns void
as $MAIN$
begin 
	insert into salespeople (salesperson_id) values (_salesperson_id);
end;
$MAIN$
language plpgsql;

-- add some salespeople:
select add_salesperson(1);
select add_salesperson(2);
select add_salesperson(3);
select add_salesperson(4);
select * from salespeople;

-- drop
drop function add_salesperson;

--function to add customer
create or replace function add_customer(_customer_id INTEGER)
returns void
as $MAIN$
begin 
	insert into customers (customer_id) values (_customer_id);
end;
$MAIN$
language plpgsql;

-- add some customers
select add_customer(1);
select add_customer(2);
select add_customer(3);
select add_customer(4);
select * from customers;

--drop 
drop function add_customer();

-- make an invoice/sell a car
create or replace function invoice(
	_invoice_id INTEGER,
	_salesperson_id INTEGER,
	_customer_id INTEGER,
	_vin_id VARCHAR(17),
	_amount DECIMAL
)
returns void
as $MAIN$
begin 
	insert into invoices (
		invoice_id,
		salesperson_id,
		customer_id,
		vin_id,
		amount
	) values (
		_invoice_id,
		_salesperson_id,
		_customer_id,
		_vin_id,
		_amount
	);

	-- this assigns the customer id to the car that just got sold, meaning it is no longer for sale
	update vehicles
	set customer_id = _customer_id
	where vin_id = _vin_id;
end;
$MAIN$
language plpgsql;

-- this will create invoice 1 for salesperson 1 and customer 1, and set the customer_id of the car sold (..wxyz) to customer 1
select invoice(1, 1, 1, '..wxyz', 20000.00);

-- check it out
select * 
from vehicles
full join invoices
on vehicles.customer_id = invoices.customer_id
where invoices is not null;

-- drop 
drop function invoice;

-- add a column to service tickets table to accomodate more than one mechanic, could do the same for parts
alter table service_tickets 
add mechanic2_id INTEGER;

select * from service_tickets;

