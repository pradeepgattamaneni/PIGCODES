REGISTER /home/hduser/Downloads/piggybank.jar;
DEFINE pigloader org.apache.pig.piggybank.storage.CSVExcelStorage();
data = load '/home/hduser/Downloads/h1b_kaggle.csv' using pigloader() as (f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12);
noheader = filter data by $0 > 1;
data = order noheader by $0;
data = foreach data generate $1,$2,$7;
data2011 = filter data by ($2 matches '2011');
data2012 = filter data by ($2 matches '2012');
data2013 = filter data by ($2 matches '2013');
data2014 = filter data by ($2 matches '2014');
data2015 = filter data by ($2 matches '2015');
data2016 = filter data by ($2 matches '2016');

groupdata2011 = group data2011 by ($1,$2);
groupdata2012 = group data2012 by ($1,$2);
groupdata2013 = group data2013 by ($1,$2);
groupdata2014 = group data2014 by ($1,$2);
groupdata2015 = group data2015 by ($1,$2);
groupdata2016 = group data2016 by ($1,$2);


data2011 = foreach groupdata2011 generate group,COUNT(data2011.$0);
data2012 = foreach groupdata2012 generate group,COUNT(data2012.$0);
data2013 = foreach groupdata2013 generate group,COUNT(data2013.$0);
data2014 = foreach groupdata2014 generate group,COUNT(data2014.$0);
data2015 = foreach groupdata2015 generate group,COUNT(data2015.$0);
data2016 = foreach groupdata2016 generate group,COUNT(data2016.$0);

dataorderd2011 = order data2011 by $1 desc;
dataorderd2012 = order data2012 by $1 desc;
dataorderd2013 = order data2013 by $1 desc;
dataorderd2014 = order data2014 by $1 desc;
dataorderd2015 = order data2015 by $1 desc;
dataorderd2016 = order data2016 by $1 desc;

top5_2011 = limit dataorderd2011 5;
top5_2012 = limit dataorderd2012 5;
top5_2013 = limit dataorderd2013 5;
top5_2014 = limit dataorderd2014 5;
top5_2015 = limit dataorderd2015 5;
top5_2016 = limit dataorderd2016 5;

uniondata = union top5_2011,top5_2012,top5_2013,top5_2014,top5_2015,top5_2016;
dump uniondata;
--dump top5_2011;





