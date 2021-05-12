use classicmodels;

show databases;
show tables;

-- ** 단축키
-- 주석 처리 : 주석처리하고 자하는 위치 커서에서 command(ctrl) + /
-- 한줄 수행 command(ctrl) + enter 

# 2장의 6 : JOIN
# 1) left join(outer join) 

select orders.orderNumber, customers.country
from orders left outer join customers
on orders.customerNumber = customers.customerNumber;

-- 테이블명을 a와 b로 별칭을 사용하여 조인한다. 
-- left outer join 과 left join은 동일한 예약어이다. 
select a.orderNumber, b.country
from orders as a left join customers as b
on a.customerNumber = b.customerNumber;

select a.orderNumber, b.country
from orders a left join customers b
on a.customerNumber = b.customerNumber
where b.country = 'USA';


# 2) inner join 
-- inner join은 두 테이블에 공통으로 존재하는 정보만 출력한다. 
select a.orderNumber, b.country
from orders a inner join customers b
on a.customerNumber = b.customerNumber
where b.country = 'USA';
-- 두 테이블에 키 값이 모두 존재한다면 outter join과 동일한 결과가 나온다. 

# 3) full join
select *
from orders full join customers
on orders.customerNumber = customers.customerNumber;


# 2장의 7
-- 조건마다 다른 결과를 출력할 수 있음. 
-- 조건에 만족하는 결과가 없을 경우 null값 출력
select country,
case when country in ('USA', 'Canada') then 'North America' else
'Others' end as region
from customers;

select country,
case when country in ('USA', 'Canada') then 'North America' else
'Others' end from customers;

select case when country in ('USA', 'Canada') then 'North America' 
else 'Others' end as 'region', 
count(customerNumber) n_customers
from customers
group by when country in ('USA', 'Canada') then 'North America'
else 'Others' end;

select case when country in ('USA', 'Canada') then 'North America'
else 'Others' end as region, count(customerNumber) N_customers
from customers
group by 1;

# 2장의 8 : rank, dense_rank, row_number
-- 데이터의 순위를 매기는 함수
-- 1) row_number: 동점인 경우 서로 다른 동수로 계산
-- 2) dense_rank : 동점의 바로 다음 순위로 다음 등수 계산
-- 3) rank : 동점인 경우 동점 데이터의 수를 건너뛰고 다음 등수 계산

select row_number() over(order by buyPrice)
from products; 

select buyPrice,
row_number() over(order by buyPrice) rowNumber,
rank() over(order by buyPrice) RNK,
dense_rank() over(order by buyPrice) denseRank
from products;

select buyPrice, productLine, 
row_number() over(partition by productLine order by buyPrice) RowNumber,
rank() over(partition by productLine order by buyPrice) RNK,
dense_rank() over(partition by productLine order by buyPrice) DenseRank
from products;

# 2장의 9 : subquery
select orderNumber
from orders
where customerNumber in (select customerNumber from customers where country='USA');