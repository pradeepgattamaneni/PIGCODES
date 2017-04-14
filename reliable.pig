usrdata = load '/home/hduser/Downloads/weblog' using PigStorage() as (name:chararray,bank:chararray,logtime:float);
bankdata = load '/home/hduser/Downloads/gateway' using PigStorage() as (bank:chararray,sucrate:float);
joindata = join usrdata by $1,bankdata by $0;
data1 = foreach joindata generate $0,$1,$4;
groupdata1 = group data1 by $0;
avg = foreach groupdata1 generate $0,AVG(data1.$2);
dump avg;
final = filter avg by $1 >90;
dump final;
