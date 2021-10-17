---
layout: post
title: The Zebra Puzzle brute force solution in golang
description: The Zebra Puzzle brute force solution in golang
summary: I found the Zebra Puzzle task. I implemented golang brute force program instead of truth table approach.
tags: golang, brute-force, zebra-puzzle
---

In CS theory book I found the link on interesting Boolean Algebra task.
[The Zebra Puzzle](https://code.energy/solving-zebra-puzzle/)
It's a sort of Boolean Algebra exercise.

I wrote simple [golang program](https://gist.github.com/alex-alekseichuk/8baa02973787db972c35cd8777ac6e3d?ts=4) to solve the puzzle.

It's a kind of pure brute force iterator of all possible combinations.
Generator pattern is used to provide the combinations and implemented by goroutine and channel. It looks like standard approach in golang.
It's optimized to cut false combinations as soon as possible.
There is also a DSL to describe a set of rules.