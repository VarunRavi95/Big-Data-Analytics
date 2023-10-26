-- Question 1
select *
from jbemployee;

-- Question 2
select distinct name
from jbdept
order by name asc;

-- Question 3
select *
from jbparts
where qoh = 0;

-- Question 4
select *
from jbemployee
where salary between 9000 and 10000;

-- Question 5
select name, birthyear, startyear, (startyear-birthyear) as age
from jbemployee;

-- Question 6
select name
from jbemployee
where substring_index(name, ', ', 1) like '%son%';

-- Question 7
select *
from jbitem
where supplier in (select id
				   from jbsupplier
                   where name = 'Fisher-Price');

-- Question 8
select *
from jbitem, jbsupplier
where jbsupplier.name = 'Fisher-Price' and jbitem.supplier = jbsupplier.id;

-- Question 9
select *
from jbcity
where id in (select city
			 from jbsupplier
             where jbcity.id = city);

-- Question 10
select name, color
from jbparts
where weight > (select weight
	  from jbparts
	  where name = 'card reader');

-- Question 11
select p2.name, p2.color
from jbparts p1, jbparts p2
where p1.name = 'card reader' and p2.weight > p1.weight;

-- Question 12
select color, avg(weight) as avg_wt
from jbparts
where color = 'black';

-- Question 13
select id, name, sum(tot_wt) as sum_tot_wt from 
(select suplr.id, suplr.name, sup.quan*parts.weight as tot_wt
from jbsupplier as suplr, jbcity as city, 
jbsupply as sup, jbparts as parts
where suplr.city = city.id and city.state = 'Mass' 
and sup.part = parts.id and suplr.id = sup.supplier) as tot_wt_tbl
group by name;

-- Question 14
create table jblowprice (
	id INT NOT NULL,
    name varchar(20),
    dept INT NOT NULL,
    price INT UNSIGNED,
    qoh INT UNSIGNED,
    supplier INT NOT NULL,
    primary key(id),
    foreign key (dept) references jbdept(id),
    foreign key (supplier) references jbsupplier(id));
describe jblowprice;

insert into jblowprice
select * from jbitem
where price < (select avg(price) from jbitem);