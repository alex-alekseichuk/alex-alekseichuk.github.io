---
layout: post
title: Vim mode in VS Code
description: Use Vim/Vi modes and keys in VS Code.
summary: Vim modes and keys are effective at line of plain text editing. Use Vim extension in VS Code to edit in the same way.
tags: vscode vim
---

I use the vim/vi editor in the Linux terminal.
But Vim is not a single plain text editor.
VS Code is widely used as an ID.
Working with text is absolutely different in these 2 editors.
To switch from one editor to another, it needs to rearrange the brain.
To avoid such frustration, it's better to use a special Vim extension in VS Code,
to use the same normal/insert/visual modes and the same keys as in vim.

```
Vim emulation for Visual Studio Code 
```

Add in VS Code Settings (JSON):

```json
{
    "vim.easymotion": true,
    "vim.incsearch": true,
    "vim.useSystemClipboard": true,
    "vim.useCtrlKeys": true,
    "vim.hlsearch": true,
    "vim.insertModeKeyBindings": [
        {
            "before": ["j", "j"],
            "after": ["<Esc>"]
        }
    ],
    "vim.normalModeKeyBindingsNonRecursive": [
        {
            "before": ["<leader>", "d"],
            "after": ["d", "d"]
        },
        {
            "before": ["<C-n>"],
            "commands": [":nohl"]
        },
        {
            "before": ["K"],
            "commands": ["lineBreakInsert"],
            "silent": true
        },
        {
            "before": ["u"],
            "commands": ["undo"]
        },
        {
            "before": ["<C-r>"],
            "commands": ["redo"]
        }
    ],
    "vim.leader": "<space>",
    "vim.handleKeys": {
        "<C-a>": false,
        "<C-w>": false,
        "<C-o>": false,
        "<C-f>": false
    }
}
```

Features:

- double `jj` to switch to normal mode from insert, as Esc.
- leader key is `space` instead of default one
- ^n new file/tab
- ^a select all
- ^w close tab
- ^o open file
- ^f find via VS Code find interface
- ^s save


