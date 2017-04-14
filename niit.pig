nysedata = load '/home/hduser/niit/NYSE.csv' using PigStorage(',') as (city:chararray,stock:chararray,date:chararray,a:double,b:double,c:double,d:double,stkvolume:long,e:double);
