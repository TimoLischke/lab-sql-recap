USE bank;
# 1. Basic Querying 
# 1.1 Retrieve the first 10 clients, displaying their `client_id`, `gender`, and `birth_date`.
SELECT * FROM client ORDER BY client_id ASC LIMIT 10;
# 1.2 Get a list of distinct transaction types from the `transactions` table.
SELECT DISTINCT type FROM trans;
# 1.3 Find all accounts opened after January 1, 1996.
SELECT account_id FROM trans WHERE date>960101;
# 1.4 Count the total number of transactions in the `transactions` table.
SELECT COUNT(trans_id) FROM trans;
# 1.5 Retrieve all loans where the amount is greater than 50,000 and sort by `loan_date` descending.
SELECT loan_id FROM loan WHERE amount>50000 ORDER BY date DESC;

# 2. Joins 
# 2.1 Retrieve a list of clients and their account numbers by joining `clients` and `accounts`.
SELECT client_id, account_id FROM client INNER JOIN disp USING(client_id) INNER JOIN account USING(account_id);
# 2.2 Show a list of transactions along with the corresponding account owner (join `transactions` with `accounts` and `clients`).
SELECT trans_id, client_id FROM trans INNER JOIN account USING(account_id) INNER JOIN client USING(district_id);
# 2.3 Find clients who have a classic card, showing their `client_id`, `account_id`, and `card_type`.
SELECT client_id FROM client INNER JOIN disp USING(client_id) INNER JOIN card USING(disp_id) WHERE card.type="classic";
# 2.4 Retrieve all loan details along with the respective account holder information.
SELECT * FROM loan LEFT JOIN account USING(account_id) INNER JOIN client USING(district_id);
# 2.5 Find the total number of transactions per account, ordered by the highest number of transactions first.
SELECT account_id, COUNT(trans_id) FROM trans GROUP BY account_id ORDER BY COUNT(trans_id) DESC;

# 3. Subqueries 
# 3.1 Find all clients who have taken loans of more than 100,000.
SELECT client_id FROM client WHERE client_id IN (
	SELECT disp.client_id FROM disp WHERE disp.account_id IN (
		SELECT loan.account_id FROM loan GROUP BY loan.account_id HAVING SUM(loan.amount)>100000));
# 3.2 Retrieve accounts that have more than 10 transactions.
SELECT account_id FROM account WHERE account_id IN (
	SELECT trans.account_id FROM trans GROUP BY trans.account_id HAVING SUM(trans.trans_id)>10);
# 3.3 Find clients who do NOT have a credit card.
SELECT client_id FROM client WHERE client_id IN (
	SELECT disp.client_id FROM disp WHERE disp.disp_id NOT IN (
		SELECT card.disp_id FROM card));
# 3.4 Show the account with the highest loan amount.
SELECT loan.account_id FROM loan ORDER BY loan.amount DESC LIMIT 1;
# 3.5 List all accounts where the total deposited amount is greater than 500,000.
SELECT trans.account_id FROM trans WHERE balance>500000;

# 4. CTEs & Window Functions 
# 4.1 Use a CTE to find the total number of transactions per account.
SELECT account_id, COUNT(trans_id) FROM trans GROUP BY account_id;
CREATE VIEW transactions_per_account AS
SELECT account_id, COUNT(trans_id) FROM trans GROUP BY account_id;
# 4.2 Use a window function to show each transaction along with the running total of transactions per account.
SELECT account_id, trans_id, date, amount,
	SUM(amount) OVER (PARTITION BY account_id ORDER BY date) AS running_total
FROM trans;
# 4.3 Rank accounts by loan amount using `RANK()`.
SELECT account_id, trans_id, amount,
       RANK() OVER (ORDER BY amount DESC) AS 'rank_trans' 
FROM trans;
SELECT account_id, loan_id, amount,
       DENSE_RANK() OVER (ORDER BY amount DESC) AS 'dense_rank_loans' 
FROM loan;
# 4.4 Find the oldest (account or) transaction per client using `ROW_NUMBER()`.
SELECT *
FROM (SELECT client_id, trans_id, trans.date,
             ROW_NUMBER() OVER (PARTITION BY client_id ORDER BY trans.date ASC) AS trans_order
		FROM client INNER JOIN disp USING(client_id) INNER JOIN trans USING(account_id)) AS ot
    WHERE trans_order = 1;
# 4.5 Find the 3 largest transactions for each account using `DENSE_RANK()`.
SELECT account_id, trans_id, amount,
       DENSE_RANK() OVER (ORDER BY amount DESC) AS dense_rank_trans 
FROM trans;

