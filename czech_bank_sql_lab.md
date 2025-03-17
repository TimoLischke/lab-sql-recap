# Czech Bank SQL Lab


## 1️⃣ Basic Querying 

**1.1** Retrieve the **first 10 clients**, displaying their `client_id`, `gender`, and `birth_date`.

**1.2** Get a **list of distinct transaction types** from the `transactions` table.

**1.3** Find all accounts opened **after January 1, 1996**.

**1.4** Count the **total number of transactions** in the `transactions` table.

**1.5** Retrieve all loans where the amount is **greater than 50,000** and sort by `loan_date` **descending**.



## 2️⃣ Joins 

**2.1** Retrieve a list of **clients and their account numbers** by joining `clients` and `accounts`.

**2.2** Show a list of **transactions along with the corresponding account owner** (join `transactions` with `accounts` and `clients`).

**2.3** Find **clients who have a classic card**, showing their `client_id`, `account_id`, and `card_type`.

**2.4** Retrieve **all loan details along with the respective account holder information**.

**2.5** Find the **total number of transactions per account**, ordered by the highest number of transactions first.



## 3️⃣ Subqueries 

**3.1** Find all clients who **have taken loans of more than 100,000**.

**3.2** Retrieve accounts that **have more than 10 transactions**.

**3.3** Find clients **who do NOT have a credit card**.

**3.4** Show the **account with the highest loan amount**.

**3.5** List all accounts where the **total deposited amount is greater than 500,000**.



## 4️⃣ CTEs & Window Functions 

**4.1** Use a **CTE** to find the **total number of transactions per account**.

**4.2** Use a **window function** to show each transaction along with the **running total of transactions** per account.

**4.3** Rank accounts by **loan amount** using `RANK()`.

**4.4** Find the **oldest account per client** using `ROW_NUMBER()`.

**4.5** Find the **3 largest transactions for each account** using `DENSE_RANK()`.


