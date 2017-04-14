txn = LOAD  '/home/hduser/niit/txns1.txt' using PigStorage(',') AS ( txnid,date,custid,amount:double,category,product,city,state,type);
--dump txn;
groupbytype = group txn by $8;
--describe groupbytype
--dump groupbytype;
totalpaymentbytype = foreach groupbytype generate group as type,ROUND_TO(SUM (txn.$3 ),2) as totalsales; 
--dump totalpaymentbytype;
groupall = group totalpaymentbytype all ;
--describe groupall;
totalsale = foreach groupall generate ROUND_TO(SUM (totalpaymentbytype.$1 ),2) as totalsales;
--dump totalsale
percentage_step1= foreach totalpaymentbytype generate $0,$1,totalsale.$0 as percentage;
percentage_final= foreach percentage_step1 generate $0,ROUND_TO((($1*100)/$2),2);
dump percentage_final;