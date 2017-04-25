REGISTER /home/hduser/Downloads/piggybank.jar;
DEFINE pigloader org.apache.pig.piggybank.storage.CSVExcelStorage();
data = load '/home/hduser/Downloads/h1b_kaggle.csv' using pigloader() as (f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12);
noheader = filter data by $0 >= 1;
data = order noheader by $0;
data = foreach data generate $1,$7;
data2011 = filter data by ($1 matches '2011');
data2012 = filter data by ($1 matches '2012');
data2013 = filter data by ($1 matches '2013');
data2014 = filter data by ($1 matches '2014');
data2015 = filter data by ($1 matches '2015');
data2016 = filter data by ($1 matches '2016');

group2011 = group data2011 by $1;
group2012 = group data2012 by $1;
group2013 = group data2013 by $1;
group2014 = group data2014 by $1;
group2015 = group data2015 by $1;
group2016 = group data2016 by $1;

count2011 = foreach group2011 generate COUNT(data2011.$0);
count2012 = foreach group2012 generate COUNT(data2011.$0);
count2013 = foreach group2013 generate COUNT(data2011.$0);
count2014 = foreach group2014 generate COUNT(data2011.$0);
count2015 = foreach group2015 generate COUNT(data2011.$0);
count2016 = foreach group2016 generate COUNT(data2011.$0);


groupdata2011 = group data2011 by ($1,$0);
groupdata2012 = group data2012 by ($1,$0);
groupdata2013 = group data2013 by ($1,$0);
groupdata2014 = group data2014 by ($1,$0);
groupdata2015 = group data2015 by ($1,$0);
groupdata2016 = group data2016 by ($1,$0);

data2011 = foreach groupdata2011 generate group,COUNT(data2011.$0);
data2012 = foreach groupdata2012 generate group,COUNT(data2012.$0);
data2013 = foreach groupdata2013 generate group,COUNT(data2013.$0) ;
data2014 = foreach groupdata2014 generate group,COUNT(data2014.$0) ;
data2015 = foreach groupdata2015 generate group,COUNT(data2015.$0) ;
data2016 = foreach groupdata2016 generate group,COUNT(data2016.$0) ;



percentage2011 = foreach data2011 generate $0,CONCAT((chararray)ROUND_TO((float)((($1)*100)/count2011.$0),2),'%'),$1;
percentage2012 = foreach data2012 generate $0,CONCAT((chararray)ROUND_TO((float)((($1)*100)/count2012.$0),2),'%'),$1;
percentage2013 = foreach data2013 generate $0,CONCAT((chararray)ROUND_TO((float)((($1)*100)/count2013.$0),2),'%'),$1;
percentage2014 = foreach data2014 generate $0,CONCAT((chararray)ROUND_TO((float)((($1)*100)/count2014.$0),2),'%'),$1;
percentage2015 = foreach data2015 generate $0,CONCAT((chararray)ROUND_TO((float)((($1)*100)/count2015.$0),2),'%'),$1;
percentage2016 = foreach data2016 generate $0,CONCAT((chararray)ROUND_TO((float)((($1)*100)/count2016.$0),2),'%'),$1;

dump percentage2011
--dump percentage2012
--dump percentage2013
--dump percentage2014
--dump percentage2015
--dump percentage2016