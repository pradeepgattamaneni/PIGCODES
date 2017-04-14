data2000 = LOAD  '/home/hduser/Downloads/2000.txt' using PigStorage(',') AS ( id:int, product, janprice:double,febprice:double,marprice:double,aprprice:double,mayprice:double,junprice:double,julprice:double,augprice:double,septprice:double,octprice:double,novprice:double,decprice:double);

data2001 = LOAD  '/home/hduser/Downloads/2001.txt' using PigStorage(',') AS ( id:int, product, janprice:double,febprice:double,marprice:double,aprprice:double,mayprice:double,junprice:double,julprice:double,augprice:double,septprice:double,octprice:double,novprice:double,decprice:double);

data2002 = LOAD  '/home/hduser/Downloads/2002.txt' using PigStorage(',') AS ( id:int, product, janprice:double,febprice:double,marprice:double,aprprice:double,mayprice:double,junprice:double,julprice:double,augprice:double,septprice:double,octprice:double,novprice:double,decprice:double);

groupall2000 = group data2000 all;
groupall2001 = group data2001 all;
groupall2002 = group data2002 all;

monthly2000 = foreach groupall2000 generate SUM(data2000.$2),SUM(data2000.$3),SUM(data2000.$4),SUM(data2000.$5),SUM(data2000.$6),SUM(data2000.$7),SUM(data2000.$8),SUM(data2000.$9),SUM(data2000.$10),SUM(data2000.$11),SUM(data2000.$12),SUM(data2000.$13);

monthly2001 = foreach groupall2001 generate SUM(data2001.$2),SUM(data2001.$3),SUM(data2001.$4),SUM(data2001.$5),SUM(data2001.$6),SUM(data2001.$7),SUM(data2001.$8),SUM(data2001.$9),SUM(data2001.$10),SUM(data2001.$11),SUM(data2001.$12),SUM(data2001.$13);

monthly2002 = foreach groupall2002 generate SUM(data2002.$2),SUM(data2002.$3),SUM(data2002.$4),SUM(data2002.$5),SUM(data2002.$6),SUM(data2002.$7),SUM(data2002.$8),SUM(data2002.$9),SUM(data2002.$10),SUM(data2002.$11),SUM(data2002.$12),SUM(data2002.$13);

monthly_2000 = foreach monthly2000 generate FLATTEN(TOBAG(*));

monthly_2001 = foreach monthly2001 generate FLATTEN(TOBAG(*));

monthly_2002 = foreach monthly2002 generate FLATTEN(TOBAG(*));

rank2000 = rank monthly_2000;
rank2001 = rank monthly_2001;
rank2002 = rank monthly_2002;
joinbymonths = join rank2000 by $0,rank2001 by $0,rank2002 by $0;
joinbymonths = foreach joinbymonths generate $0,$1,$3,$5;
per1 = foreach joinbymonths generate $0,$1,$2,$3,$2-$1 as p1,$3-$2 as p2;
per2 = foreach per1 generate $0,ROUND_TO(($4*100)/$1,2) as p1,ROUND_TO(($5*100)/$2,2) as p2;
per3 = foreach per2 generate $0,ROUND_TO(($1+$2)/2,2) as avgper;

dump per3;

final = order per3 by $1 desc;

dump final;