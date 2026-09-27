proc import datafile="/home/u64600679/lung.csv" out=lung dbms=csv replace;
    getnames=yes;
run;

proc contents data=lung; run;

proc lifetest data=lung plots=survival(atrisk);
    time time*status(0);
    strata sex;
run;

proc phreg data=lung;
    model time*status(0) = age sex 'ph.ecog'n;
run;
