---
layout: post
title: Text Editor
description: I implemented a simple text editor in pure C.
summary: I implemented a very simple text editor application in pure C.
tags: c ncurses terminal ascii
---

Several years ago, I came across an article listing cool projects to implement — one of them was a text editor.
This weekend, I built my own:

[https://github.com/alex-alekseichuk/text-editor](https://github.com/alex-alekseichuk/text-editor)

I don’t see much practical value in building another text editor, but it’s great as a fun project or a step in the learning process.

It felt very similar to a game development project: you maintain state in memory, render part of the world on the screen, accept user input and commands, and then apply them according to a set of rules. It almost feels like building a game.

The model is called a buffer, as in vi/vim.
The buffer is simply a dynamic array of lines, and each line is a dynamic array of characters.
For simplicity, the editor supports only ASCII.
There are two basic operations for persistence:
  - read text from a file into the buffer
  - write the buffer back to the file.


In the presentation layer, it’s a pure terminal application (TUI) built with the ncurses library. The screen displays text line by line, without wrapping or horizontal scrolling. Cursor navigation supports standard movements, home/end within a line, and page up/down scrolling.

There is only an insert mode. The editor supports splitting and inserting lines, deleting characters with delete/backspace, and joining lines.

Although it’s written in pure C, both the model (buffer) and the view components encapsulate their internal data structures and expose a clean, minimal API.
The model layer is independent of other layers and external libraries, while the view layer depends only on ncurses—following a classic MVC design.
The README lists features, but mostly by omission: the editor is intentionally minimal.
Even so, achieving stability wasn’t easy—edge cases like empty or missing files, newline handling, and memory leaks took time to get right.

