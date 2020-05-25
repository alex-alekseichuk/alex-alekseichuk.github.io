---
layout: post
title: "Enums in JavaScript"
description: There is the best approach to define and use enums in JavaScript.
summary: There is built-in enums in JavaScript. There is the best approach to define and use enums in JavaScript.
tags: JavaScript
---

In multi-layer application it needs to pass error/result codes from provider to the service, or from the service to upper layer.
The best approach to deal with error codes are enums. But there are no enums in JavaScript.

I use such utility function to create an object which provides the set of constants like enum does:

```javascript
function createEnum(labels, startIndex = 0) {
  return Object.freeze(labels.reduce((enu, label, i) => {enu[label] = i + startIndex; return enu;}, {}));
}
```

Define enum in the service to be called:

```javascript
const ERRORS = util.createEnum(['OK', 'UNKNOWN_ERROR', 'SERVER_ERROR']);
```

Then use those codes on both sides the client and the service:

```javascript
const result = await someApi.method();
if (result === someApi.ERRORS.OK)
  ...
```
