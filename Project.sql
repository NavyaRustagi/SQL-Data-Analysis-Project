USE ONLINE_BOOK_STORE;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT);
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150));
    CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2));
    
    SELECT * FROM Books;
    select * from customers;
    select * from orders; 

-- Normal Questions
    
   -- 1) Retrieve all books in fiction genre
   Select * 
   from Books
   where Genre = 'Fiction';
   
   -- 2) Find books published after the year 1950:
   Select *
   from Books
   where Published_Year > '1950';
   
   -- 3) List all customers from the Canada:
   select * 
   from Customers
   where Country = 'Canada';
   
   -- 4) Show orders placed in November 2023:
   select * 
   from Orders
   where Order_Date between '2023-11-01' and '2023-11-30';
   
   -- 5) Retrieve the total stock of books available:
   Select sum(Stock) Total_Stock
   from books;

-- 6) Find the details of the most expensive book:
Select *
from books
order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select c.* , o.quantity
from orders o
join customers c on o.customer_id = c.customer_id
where o.quantity >1;


-- 8) Retrieve all orders where the total amount exceeds $20:
select *
from orders
where total_amount > 20;

-- 9) List all genres available in the Books table:
select distinct genre
from books;   


-- 10) Find the book with the lowest stock:
select *
from books 
order by stock limit 1;


-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) Total_Revenue
from orders;
    
-- Advance Questions
    
-- 1) Retrieve the total number of books sold for each genre:
select b.genre, sum(o.total_amount) Total_Revenue
from orders o
join books b on o.book_id = b.book_id
group by b.genre;    


-- 2) Find the average price of books in the "Fantasy" genre:
select genre, avg(price) Average_price
from books
where genre = 'fantasy';      


-- 3) List customers who have placed at least 2 orders:
select customer_id, count(customer_id) orders_placed
from orders
group by customer_id
having count(customer_id)>1;


-- 4) Find the most frequently ordered book:
select b.title, b.book_id, count(o.book_id) Books_ordered
from orders
join books b on o.book_id = b.book_id
group by b.book_id
order by Books_ordered desc
limit 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select *
from books
where genre = 'fantasy'
order by price desc
limit 3;


-- 6) Retrieve the total quantity of books sold by each author:
select distinct b.author, sum(o.quantity) quantity
from orders o
join books b on o.book_id = b.book_id
group by b.author;


-- 7) List the cities where customers who spent over $30 are located:
select distinct c.city, sum(o.total_amount) Revenue
from customers c
join orders o on c.customer_id = o.customer_id
where o.total_amount > 30
group by c.city;


-- 8) Find the customer who spent the most on orders:
select c.*, o.total_amount
from orders o
join customers c on o.customer_id = c.customer_id
order by o.total_amount desc
limit 1;


-- 9) Calculate the stock remaining after fulfilling all orders:
select b.book_id, coalesce(sum(b.stock),0) - coalesce(sum(o.quantity),0) as stock_remaining
from books b
left join orders o on b.book_id = o.book_id
group by b.book_id;
