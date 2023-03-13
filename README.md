# mf2dot
Generate dot files from makefiles. Requires edge (process to create target(s) from dependency(ies) annotations using '##' on 1st line of rule (see example.mk).

First generate a dot file:
```
./mf2dot.sh example.mk example.dot
```
  
Then edit if desired, and make a png:
```
dot -T png -o example.png example.dot
```


