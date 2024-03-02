|Task|Signed Magnitude Representation|1'scomplement|2'scomplement|
|----|------|--------|-------|
|process|MSB is 1 for negative number and 0 for positive number and remaining bits represent magnitude |Replace 1with0 and vice-versa  for positive Signed Magnitude number|Replace 1 with0 and vice-versa  for positive signed magnitude number and add1 to the LSB of obtained number|
|Range|-((2^(N-1))-1) to (2^(N-1)-1)|-(2^(N-1)-1) to (2^(N-1)-1)|-2^(N-1) to2^(N-1)|
|+52|00110100|11001011|11001100|
|-64|11000000|10111111|1100000|
|+31|011111|100000|100001|
|-129|1100000001|1011111110|101111111|
