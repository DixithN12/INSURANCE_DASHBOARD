create database insurance;

use insurance;
create table invo(
select sum(amount) as 'Amount',income_class from invoice group by income_class);

-- 1. invoice by Class 
select sum(amount) as 'Amount',income_class from invoice group by income_class;

-- 2. fees by Class
select sum(amount),income_class from fees group by income_class;

-- 3. brokarage by Class
select sum(amount),income_class from brokarage group by income_class;

/*select sum(brokarage.amount)+sum(fees.amount) As "Amount", brokarage.income_class + fees.income_class
 from brokarage join fees group by brokarage.income_class + fees.income_class*/
 
 -- 4. Target Table
create table Target(
select sum(New_Budget) 'New_Budget',
sum(Cross_sell_bugdet) 'Cross_sell_bugdet',sum(Renewal_Budget) 'Renewal_Budget'from budget);

-- 5. Percentage of Achievement invoice 
(select Amount /(select New_Budget/100 from Target) as 'New_invoice ach%'
from invo where income_class= 'New') ;

(select Amount /(select Cross_sell_bugdet/100 from Target) as 'Cross_sell_invoice ach%' from 
invo where income_class= 'Cross Sell') ;

(select Amount /(select Renewal_Budget/100 from Target) as 'Renewal_invoice ach%' from 
invo where income_class= 'Renewal') ;

-- 6. placed Achieved
create table achive(income_class varchar(225), amount double);
insert into achive(select income_class, amount from fees);
insert into achive(select income_class, amount from brokarage);

select income_class, sum(amount) from achive group by income_class;

-- 7. placedAchive Table
create table placeAchive(select income_class, sum(amount) as 'Amount' from achive group by income_class);

-- 8. Percentage of Achievement PlacedAchive 
(select Amount /(select New_Budget/100 from Target) as 'New_Placed_ach%'
from placeAchive where income_class= 'New') ;

(select Amount /(select Cross_sell_bugdet/100 from Target) as 'Cross_Placed_ach%'
from 
placeAchive where income_class= 'Cross Sell') ;

(select Amount /(select Renewal_Budget /100 from Target) as 'Renewal_Placed_ach%' 
from 
placeAchive where income_class= 'Renewal') ;

-- 9. meeting
 select count(meeting_date) from meeting;
 
-- 10. No of Invoice by Accnt Exec
select Account_Executive,income_class, count(income_class) from 
invoice group by income_class, Account_Executive order by  count(income_class) desc;

-- 11. Stage => New
select income_class, amount from invo having income_class= 'New';
select New_Budget from target;
select income_class, amount from placeachive having income_class= 'New';

-- 12. Stage => Cross Sell
select income_class, amount from invo having income_class= 'Cross Sell';
select Cross_sell_bugdet from target;
select income_class, amount from placeachive having income_class= 'Cross Sell';

-- 13. Stage => Renewal
select income_class, amount from invo having income_class= 'Renewal';
select Renewal_Budget from target;
select income_class, amount from placeachive having income_class= 'Renewal';

-- 14. stage by revenue
select stage, sum(revenue_amount) from opportunity group by stage;

-- 15. No of meeting By Account Exe
 select Account_Executive,count(meeting_date) from meeting group by Account_Executive;

 -- select meeting_date,count(meeting_date) from meeting group by meeting_date
 
 -- 16. Top -4 opportunity by revenue 
 select opportunity_name, stage, revenue_amount 
 from opportunity order by revenue_amount desc limit 4;

-- 17 Open Opportunity by revenue
 select opportunity_name, stage, revenue_amount 
 from opportunity where stage <> 'Negotiate' order by revenue_amount desc limit 5;
 