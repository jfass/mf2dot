#!/usr/bin/env bash

# Usage: ./mf2dot <in.file.mk> <out.file.dot>

# start graph in dot file, and set left to right ordering:
echo "digraph G { rankdir=\"LR\"; " > $2

# from each recipe with a process tag ("[...]  ## tool-or-process-name")
# make a (single) graph node:
cat $1 \
  | grep -v ^# \
  | perl -pe 's/\\\n/ /' \
  | tr "\t" ' ' \
  | tr -s ' ' \
  | grep ":.*##" \
  | perl -pe "s/&:/:/" \
  | while read line; do
    targets=`echo -n "${line}" | cut -f1 -d: | tr " " "\n" | grep -v ^$ | tr "/" "_" | tr "." "_" | tr "-" "_"`
    depends=`echo -n "${line}" | cut -f1 -d# | cut -f2 -d: | tr " " "\n" | grep -v ^$ | tr "/" "_" | tr "." "_" | tr "-" "_"`
    process=`echo "${line}" | cut -f3 -d# | tr -d " "`
    echo "${targets}" \
      | while read target; do
        echo "${depends}" \
          | while read depend; do
            # echo "$process makes $target out of $depend"
            echo -n "$target"
            echo -n ' [label='
            echo -n "\""
            echo -n "$target"
            echo "\"]"
        done
    done
done \
  | sort -u \
  >> $2

# ... and make graph edges for each of grouped target and dependency combinations:
cat $1 \
  | grep -v ^# \
  | perl -pe 's/\\\n/ /' \
  | tr "\t" ' ' \
  | tr -s ' ' \
  | grep ":.*##" \
  | perl -pe "s/&:/:/" \
  | while read line; do
    targets=`echo -n "${line}" | cut -f1 -d: | tr " " "\n" | grep -v ^$ | tr "/" "_" | tr "." "_" | tr "-" "_"`
    depends=`echo -n "${line}" | cut -f1 -d# | cut -f2 -d: | tr " " "\n" | grep -v ^$ | tr "/" "_" | tr "." "_" | tr "-" "_"`
    process=`echo "${line}" | cut -f3 -d# | tr -d " "`
    echo "${targets}" \
      | while read target; do
        echo "${depends}" \
          | while read depend; do
            # echo "$process makes $target out of $depend"
            echo -n "$depend"
            echo -n ' -> '
            echo -n "$target"
            echo -n ' [label='
            echo -n "\""
            echo -n "$process"
            echo "\"]"
        done
    done
done \
  | grep -v "^ ->" \
  >> $2  # last grep omits empty root node

# end graph
echo "}" >> $2  # close graph specification
