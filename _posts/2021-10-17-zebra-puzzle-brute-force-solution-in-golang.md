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

func addIndexRecursive(indexes []int, ch chan []int, n int) {
  if len(indexes) == 5 {
    ch <- indexes
    return
  }
  for i := 0; i < n ; i++ {
    if contains(indexes, i) {
      continue
    }
    indexes = append(indexes, i)
    addIndexRecursive(indexes, ch, n)
    indexes = indexes[:len(indexes)-1]
  }
}

func allCombinations(n int) chan []int {
  ch := make(chan []int)
  go func(ch chan []int) {
    indexes := []int {}
    addIndexRecursive(indexes, ch, n)
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

const (
  englishman = iota
  ukrainian
  norwegian
  japanese
  spaniard
)

const (
  red = iota
  green
  ivory
  blue
  yellow
)

const (
  milk = iota
  orange
  water
  tea
  coffee
)

const (
  oldGold = iota
  kools
  chesterfields
  luckyStrike
  parliaments
)

const (
  dog = iota
  snails
  horse
  zebra
  fox
)

func main() {
  nationsTitles := [5]string {"Englishman", "Ukrainian", "Norwegian", "Japanese", "Spaniard"}

  for iNations := range allCombinations(5) {
    if !(iNations[0] == norwegian) {
      continue
    }
    for iSmokes := range allCombinations(5) {
      if !match(iNations, japanese, iSmokes, parliaments) {
        continue
      }
      for iColors := range allCombinations(5) {
        if !match(iNations, englishman, iColors, red) ||
          !match(iSmokes, kools, iColors, yellow) ||
          !rightOf(iColors, green, iColors, ivory) ||
          !nextTo(iNations, norwegian, iColors, blue) {
          continue
        }
        for iDrinks := range allCombinations(5) {
          if !(iDrinks[2] == 0) ||
            !match(iDrinks, coffee, iColors, green) ||
            !match(iNations, ukrainian, iDrinks, tea) ||
            !match(iSmokes, luckyStrike, iDrinks, orange) {
            continue
          }
          for iPets := range allCombinations(5) {
            if !match(iNations, spaniard, iPets, dog) ||
              !match(iSmokes, oldGold, iPets, snails) ||
              !nextTo(iSmokes, chesterfields, iPets, fox) ||
              !nextTo(iSmokes, kools, iPets, horse) {
              continue
            }

            for i, iDrink := range iDrinks {
              if iDrink == water {
                fmt.Println(nationsTitles[iNations[i]], "from", i + 1, "house drinks water.")
              }
            }
            for i, iPet := range iPets {
              if iPet == zebra {
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
