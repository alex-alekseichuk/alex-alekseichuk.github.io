---
layout: post
title: Brieif descriptions of the tools by parsing their man pages
description: Brieif descriptions of the tools by parsing their man pages
summary: I've done simple bash script to get the titles of the man pages of a set of unix/linux CLI tools.
tags: linux bash cli
---

I found nice series of lectures online.
[One of them](https://www.youtube.com/watch?v=sz_dsktIjt4)
 is about unix/linux CLI tools to process files.

I wrote simple [bash script](https://gist.github.com/alex-alekseichuk/68f8565d65c61d5260ac22cd0b3e8005):

```
#!/bin/bash
cmds=(cat tac head tail tee more less echo wc grep find sort comm tr cut split sed awk seq)
for cmd in $cmds; do
  man $cmd|sed -n '4p'|sed -E 's/^\s+//;s/ - /\n  /'
done
```

It gets 4-th line of the man page of each tool and compose the list of tools and their brief descriptions.

```
cat
  concatenate files and print on the standard output
tac
  concatenate and print files in reverse
head
  output the first part of files
tail
  output the last part of files
tee
  read from standard input and write to standard output and files
more
  file perusal filter for crt viewing
less
  opposite of more
echo
  display a line of text
wc
  print newline, word, and byte counts for each file
grep, egrep, fgrep, rgrep
  print lines that match patterns
find
  search for files in a directory hierarchy
sort
  sort lines of text files
uniq
  report or omit repeated lines
comm
  compare two sorted files line by line
tr
  translate or delete characters
cut
  remove sections from each line of files
split
  split a file into pieces
sed
  stream editor for filtering and transforming text
gawk
  pattern scanning and processing language
seq
  print a sequence of numbers
```

Happy hacking!
