---
layout: post
title: Neovim by kickstart.nvim on WSL2 Ubuntu
description: How to install best Neovim configuration by kickstart.nvim on WSL2 Ubuntu system.
summary: Neovim is a modern vi editor, the best one. The kickstart.nvim is the best approach to start use it at full capacity.
tags: neovim wsl2 linux
---

I've been using `vi` for decades, since I first touched UNIX 30 years ago.
For now, [neovim](https://neovim.io/) is the best modern reincarnation of it.

There is very popular approach to start with it.
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
Actually, there is just a configuration file with settings and the set of the plugins to install on first run.

Neovim version from the package manager is outdated.
kickstart.nvim doesn't support it.
You better install latest neovim version from unstable PPA, as it's described in [README](https://github.com/nvim-lua/kickstart.nvim/blob/master/README.md).

The problem is that it doesn't work in case of WSL2 on Windows.
One more problem with Windows.
On first run, [lazy](https://github.com/folke/lazy.nvim) plugin manager can't install and build all the plugins.
To pass it, I just built neovim from [sources](https://github.com/neovim/neovim).

![about](/assets/images/2024-06-08-neovim.png)
