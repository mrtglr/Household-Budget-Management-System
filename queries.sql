-- In this query, we list which family lives in which location.
SELECT family.surname, house.location FROM family, house WHERE family.houseno = house.houseno;

--in this query, we can list the each user's name, surname, jobsand salary in the same table.
SELECT users.Name , users.Surname , users.job , income.TotalWorth FROM users INNER JOIN income ON income.UserID = users.UserID ;

-- In this query, we learn amount of house rent that each family pay.
SELECT family.surname, house.rent from house INNER JOIN family ON family.houseno = house.houseno order by surname asc;

-- In this query, we listed amount and features of the expenses and the house location of expender familes.
SELECT house.location , expense.expname , bill.cost from house INNER JOIN expense on house.houseno = expense.houseno INNER JOIN bill on expense.expid = bill.expid ;

-- In this query, we listed the final balance after computing total income, expenses and their amounts of each family.
SELECT family.surname, family.totalIncome, expense.expname , bill.cost, balance.total as "Balance Total" from family INNER JOIN expense ON expense.HouseNo = family.houseno INNER JOIN bill ON bill.expid = expense.expid FULL OUTER JOIN balance on family.houseno = balance.houseno order by balance.total desc;

-- In this query, we list average and max of all house rents.
SELECT (SELECT avg(rent)from house) as avg_rent, (SELECT max(rent)from house) as max_rent;

-- In this query, we list users who were over 25 and had no job.
SELECT * FROM users WHERE userid IN (SELECT userid FROM users WHERE age > 25 and hasincome = false);

-- In this query, we list the average balance.
SELECT AVG(balance.total) as "Balance Average" from balance ;

-- In this query, we list the average age of users.
SELECT AVG(users.age) as "Average age of users" from users ;

-- In this query, we list total number of users.
SELECT COUNT(users.userid) as "Total number of users" FROM users;

-- In this query, We list users between the ages of 18 and 25.
SELECT users.name, users.surname, users.age from users where age BETWEEN 18 AND 25 order by age asc;

-- In this query, We list the surnames of family paying rent between 1000 and 2000 Turkish lira and the rent they paid.
SELECT family.surname , house.rent from family, house where family.houseno = house.houseno and house.rent BETWEEN 1000 and 2000 order by house.rent desc;

-- In this query, we list the rents in the ankara location.
SELECT house.rent , house.location FROM house WHERE house.location LIKE '%Ankara%' order by rent asc;

-- In this query, we get all the expenses of family and list the total expenses of each family together with their surnames.
SELECT family.surname ,SUM(bill.cost) as totalexpense from family  INNER JOIN expense ON family.HouseNo = expense.houseno INNER JOIN bill ON bill.expid = expense.expid group by family.surname;

-- In this query we counted and grouped the users with the same surname which has income more than two person.
SELECT users.surname ,COUNT(users) FROM users GROUP BY surname HAVING COUNT(users.hasincome = true) > 2 order by users.surname asc;

-- In this query, we list people whose first name is "Alp".
SELECT * from users where users.name like 'Alp%';

-- In this query, we list unemployed people. 
SELECT users.name, users.surname from users where users.job IS NULL;

-- In this query, we list which bill is same with expense
SELECT billdate as "Bill Dates" FROM bill INTERSECT SELECT expdate FROM expense;

-- in this query, we list surname's and id's of users who has income except from all users.
SELECT surname, userid FROM users WHERE hasincome=true except select surname , userid FROM users WHERE hasincome=false order by surname;


-- SPECIAL QUERIES

-- in this query, we list the electricty bills of the ones saving money for the future use.
SELECT bill.billname, bill.billdate, bill.cost FROM expense,bill WHERE bill.expid = expense.expid and bill.billname = 'electricityBill' and expense.houseno = 2 order by cost asc;

-- in this query, the bill's cost belonging to the house are subtracted from the total income of the family living in each house and the result of this is an update of the balance cost .In the second special query, we have not yet been able to fully add the subtraction process according to the last 3  month to the structure we have created.
UPDATE balance set total = temp.inc - temp.total_cost from ( SELECT families.totalincome as inc, house.houseno as hno, SUM(bill.cost) as total_cost FROM house  INNER JOIN families ON families.houseno=house.houseno INNER JOIN expense ON expense.houseno = house.houseno INNER JOIN bill ON bill.expid = expense.expid GROUP BY house.houseno,families.totalincome) temp where balance.houseno = temp.hno;


