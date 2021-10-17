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

```go
// Brute-force solution of the Zebra Puzzle
// https://code.energy/solving-zebra-puzzle/
//
// Result:
// Norwegian from 1 house drinks water.
// Japanese from 5 house owns zebra.

package main

import (
	"fmt"
)

func contains(values []int, value int) bool {
	for _, n := range values {
		if n == value {
			return true
		}
	}
	return false
}

func addIndex(indexes []int, ch chan []int, n int) {
	if len(indexes) == 5 {
		ch <- indexes
		return
	}
	for i := 0; i < n ; i++ {
		if contains(indexes, i) {
			continue
		}
		indexes = append(indexes, i)
		addIndex(indexes, ch, n)
		indexes = indexes[:len(indexes)-1]
	}
}

func allSets(n int) chan []int {
	ch := make(chan []int)
	go func(ch chan []int) {
		indexes := []int {}
		addIndex(indexes, ch, n)
		close(ch)
	}(ch)
	return ch
}

func match(indexes1 []int, value1 int, indexes2[]int, value2 int) bool {
	if (indexes1[0] != value1 || indexes2[0] != value2) &&
		(indexes1[1] != value1 || indexes2[1] != value2) &&
		(indexes1[2] != value1 || indexes2[2] != value2) &&
		(indexes1[3] != value1 || indexes2[3] != value2) &&
		(indexes1[4] != value1 || indexes2[4] != value2) {
		return false
	}
	return true
}

func rightOf(indexes1 []int, value1 int, indexes2[]int, value2 int) bool {
	if (indexes1[1] != value1 || indexes2[0] != value2) &&
		(indexes1[2] != value1 || indexes2[1] != value2) &&
		(indexes1[3] != value1 || indexes2[2] != value2) &&
		(indexes1[4] != value1 || indexes2[3] != value2) {
		return false
	}
	return true
}

func nextTo(indexes1 []int, value1 int, indexes2[]int, value2 int) bool {
	if (indexes1[0] != value1 || indexes2[1] != value2) &&
		(indexes1[1] != value1 || indexes2[0] != value2 && indexes2[2] != value2) &&
		(indexes1[2] != value1 || indexes2[1] != value2 && indexes2[3] != value2) &&
		(indexes1[3] != value1 || indexes2[2] != value2 && indexes2[4] != value2) &&
		(indexes1[4] != value1 || indexes2[3] != value2) {
		return false
	}
	return true
}

func main() {
	// colorsTitles := [5]string {"red", "green", "ivory", "blue", "yellow"}
	// drinksTitles := [5]string {"milk", "orange", "water", "tea", "coffee"}
	nationsTitles := [5]string {"Englishman", "Ukrainian", "Norwegian", "Japanese", "Spaniard"}
	// smokesTitles := [5]string {"olg-gold", "kools", "chesterfields", "lucky-strike", "parliaments"}
	// petsTitles := [5]string {"dog", "snails", "horse", "zebra", "fox"}

	for iNations := range allSets(5) {
		if !(iNations[0] == 2) {
			continue
		}
		for iSmokes := range allSets(5) {
			if !match(iNations, 3, iSmokes, 4) {
				continue
			}
			for iColors := range allSets(5) {
				if !match(iNations, 0, iColors, 0) ||
					!match(iSmokes, 1, iColors, 4) ||
					!rightOf(iColors, 1, iColors, 2) ||
					!nextTo(iNations, 2, iColors, 3) {
					continue
				}
				for iDrinks := range allSets(5) {
					if !(iDrinks[2] == 0) ||
						!match(iDrinks, 4, iColors, 1) ||
						!match(iNations, 1, iDrinks, 3) ||
						!match(iSmokes, 3, iDrinks, 1) {
						continue
					}
					for iPets := range allSets(5) {
						if !match(iNations, 4, iPets, 0) ||
							!match(iSmokes, 0, iPets, 1) ||
							!nextTo(iSmokes, 2, iPets, 4) ||
							!nextTo(iSmokes, 1, iPets, 2) {
							continue
						}

						for i, iDrink := range iDrinks {
							if iDrink == 2 {
								fmt.Println(nationsTitles[iNations[i]], "from", i + 1, "house drinks water.")
							}
						}
						for i, iPet := range iPets {
							if iPet == 3 {
								fmt.Println(nationsTitles[iNations[i]], "from", i + 1, "house owns zebra.")
							}
						}
					}
				}
			}
		}
	}
}
```
