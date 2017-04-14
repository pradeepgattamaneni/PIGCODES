book = load '/home/hduser/book1.txt' using TextLoader() as (lines:chararray);
REGISTER /home/hduser/udfpig.jar;
DEFINE LowerToUpper pigudf.UPPER();
book2 = foreach book generate LowerToUpper(lines);
dump book2;