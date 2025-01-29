# Pizza-Insights-Report
Using SQL for generating Insights for Pizza Hut according to Stakeholders requirements.

# 🍕 Pizza Hut Sales Analysis  

This project provides an SQL-based analysis of Pizza Hut's sales data, addressing key business questions to assist stakeholders in decision-making.  

## 📂 Database Structure  

The database consists of four tables:  

1. **Orders**  
   - `order_id` (Primary Key)  
   - `order_date` (DateTime)  

2. **Order_Details**  
   - `order_id` (Foreign Key → Orders)  
   - `pizza_id` (Foreign Key → Pizzas)  
   - `qty_id` (Quantity of pizzas ordered)  

3. **Pizza_Type**  
   - `pizza_id` (Primary Key)  
   - `name` (Pizza name)  
   - `category` (e.g., Veg, Non-Veg, Specialty)  
   - `ingredients` (List of ingredients used)  

4. **Pizzas**  
   - `pizza_id` (Primary Key)  
   - `pizza_size` (Small, Medium, Large, etc.)  
   - `price` (Cost of the pizza)  

---

## 📊 Business Questions Addressed  

### **Basic Analysis**  
✅ Retrieve the total number of orders placed.  
✅ Calculate the total revenue generated from pizza sales.  
✅ Identify the highest-priced pizza.  
✅ Determine the most commonly ordered pizza size.  
✅ List the top five most-ordered pizza types along with their quantities.  

### **Intermediate Analysis**  
✅ Determine the total quantity of each pizza category ordered.  
✅ Analyze the distribution of orders by hour of the day.  
✅ Find the category-wise distribution of pizzas.  
✅ Group orders by date and calculate the average number of pizzas ordered per day.  
✅ Identify the top three most-ordered pizza types based on revenue.  

### **Advanced Analysis**  
✅ Calculate the percentage contribution of each pizza type to the total revenue.  
✅ Analyze the cumulative revenue generated over time.  
✅ Identify the top three most-ordered pizza types based on revenue for each pizza category.  

---

## 📜 Files Included  

- 📄 **SQL Queries** (`queries.sql`): Contains all SQL scripts used to generate insights.  
- 📊 **Analysis Report** (`Pizza_Hut_Analysis.pdf`): Includes SQL queries with corresponding outputs.  

---

## 🚀 How to Use  

1. Clone this repository:  
   ```sh
   git clone https://github.com/yourusername/pizza-hut-sales-analysis.git

