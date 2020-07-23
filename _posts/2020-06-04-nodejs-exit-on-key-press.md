---
layout: post
title: "Non-blocking node.js exit on key press"
description: There is the approach to wait for any key press, then exit the process.
summary: From time to time it needs to implement some CLI tool. There is the approach to wait for any key press, then exit the process.
tags: nodejs console javascript
---

From time to time it needs to implement some CLI tool.
There is the approach to wait for any key press, then exit the process.
The feature doesn't block your process.
So, there is some listener or other useful logic can still be in progress.

```javascript
process.stdin.setRawMode(true);
process.stdin.resume();
process.stdin.on('data', process.exit.bind(process, 0));
```

Happy coding!