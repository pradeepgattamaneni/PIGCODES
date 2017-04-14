purchase= load '/home/hduser/purchasa.txt' using PigStorage(',') as (id:int,purchase:int);
sales= load '/home/hduser/sales.txt' using PigStorage(',') as (id:int,sales:int);
groups1 = group purchase by $0;
purchase1= foreach groups1 generate group,SUM(purchase.$1);
groups2 = group sales by $0;

sales1 = foreach groups2 generate group,SUM(sales.$1);

joins = join purchase1 by $0,sales1 by $0;
joins1= foreach joins generate $0,$1,$3;
profit = foreach joins1 generate $0,$1,$2,$2-$1;
percentage = foreach profit generate $0,$1,$2,$3,CONCAT((chararray)ROUND_TO((float)($3*100)/$1,2),'%') as percentage;
dump percentage;
