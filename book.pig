book1 = load '/home/hduser/book1.txt' using PigStorage() as (lines:chararray);
book2 = load '/home/hduser/book2.txt' using PigStorage() as (lines:chararray);
bookcombined = union book1,book2;
--dump bookcombined
split bookcombined into book3 if SUBSTRING(lines,5,7) == 'is',book4 if SUBSTRING (lines,19,24) == 'three',book5 if SUBSTRING (lines,0,4) == 'this';
--dump book3
--dump book4
--dump book5