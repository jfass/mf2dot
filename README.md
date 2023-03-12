# mf2dot
Generate dot files from makefiles.

First generate a dot file:
```
./mf2dot.sh example.mk example.dot
```
  
Then edit if desired, and make a png:
```
dot -T png -o example.png example.dot
```


