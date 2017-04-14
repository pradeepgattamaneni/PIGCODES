file = LOAD '$input' using PigStorage() as(word:chararray);
 token = foreach file generate FLATTEN(TOKENIZE(LOWER(word))) as word;
token = filter token by word== '$myword';
 groupbyword = group token by word;
 count = foreach groupbyword generate group,COUNT(token);
 count = order count by $1 desc;
dump count;