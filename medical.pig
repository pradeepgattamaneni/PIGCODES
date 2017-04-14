data = load '/home/hduser/Downloads/medical' using PigStorage() as (name:chararray,dept:chararray,claim:float);

groupdata = group data by $0;

dump groupdata;

describe groupdata;

countdata = foreach groupdata generate $0,$1,SUM(data.$2) as totalclaim,COUNT(data.$2);


avgdata = foreach countdata generate $0,$2/$3 as avgclaim;

dump avgdata;

