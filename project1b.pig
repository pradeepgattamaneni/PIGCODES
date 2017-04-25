REGISTER /home/hduser/Downloads/piggybank.jar;
DEFINE pigloader org.apache.pig.piggybank.storage.CSVExcelStorage();
data = load '/home/hduser/Downloads/h1b_kaggle.csv' using pigloader() as (f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12);
noheader = filter data by $0 > 1;
data = order noheader by $0;
data2011 = filter data by ($7 matches '2011');
data2012 = filter data by ($7 matches '2012');
data2013 = filter data by ($7 matches '2013');
data2014 = filter data by ($7 matches '2014');
data2015 = filter data by ($7 matches '2015');
data2016 = filter data by ($7 matches '2016');
group2011 = group data2011 by $4;
count2011 = foreach group2011 generate group,COUNT(data2011.$1);
--dump count2011;
group2012 = group data2012 by $4;
count2012 = foreach group2012 generate group,COUNT(data2012.$1);
group2013 = group data2013 by $4;
count2013 = foreach group2013 generate group,COUNT(data2013.$1);
group2014 = group data2014 by $4;
count2014 = foreach group2014 generate group,COUNT(data2014.$1);
group2015 = group data2015 by $4;
count2015 = foreach group2015 generate group,COUNT(data2015.$1);
group2016 = group data2016 by $4;
count2016 = foreach group2016 generate group,COUNT(data2016.$1);


joindata = join count2011 by $0,count2012 by $0,count2013 by $0,count2014 by $0,count2015 by $0,count2016 by $0;

l1 = limit joindata 5;
--dump l1;
--dataclear = foreach joindata generate $0,$1,$11;
dataclear = foreach joindata generate $0,$1,$3,$5,$7,$9,$11;
percentage = foreach dataclear generate $0,ROUND_TO((float)((($2-$1)*100)/$1),2),ROUND_TO((float)((($3-$2)*100)/$2),2),ROUND_TO((float)((($4-$3)*100)/$3),2),ROUND_TO((float)((($5-$4)*100)/$4),2),ROUND_TO((float)((($6-$5)*100)/$5),2);

top = foreach percentage generate $0,($1+$2+$3+$4+$5)/5;
top = order top by $1 desc;
top5 = limit top 5;
top5 = foreach top5 generate $0,CONCAT((chararray) $1,'%');
dump top5; 








