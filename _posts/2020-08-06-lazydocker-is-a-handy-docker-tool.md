---
layout: post
title: "Lazydocker is a handy Docker tool"
description: Lazydocker is a handy console Docker tool
summary: In Linux I use ZSH + plugins. There are cool aliases for handling Docker images and containers. Try Lazydocker console tool for new experience.
tags: linux docker console
---

Just try [lazydocker](https://github.com/jesseduffield/lazydocker).
It's a handy console tool for both the speedup your regular docker routines in command line
and the visual picture of your images and containers.

### To Install

1. make sure you have `go` environment installed
2. run
```
go get github.com/jesseduffield/lazydocker
```

In ``~/.zshrc`
```
PATH=$PATH:$HOME/go/bin
alias lzd='lazydocker'
```

Some hot-keys:
```
[] - prev/next tab
x  - menu

PgUp/PgDown - scroll

d remove
s stop
r restart
a attach
D prune existed containers
m view logs
```

Happy hacking!