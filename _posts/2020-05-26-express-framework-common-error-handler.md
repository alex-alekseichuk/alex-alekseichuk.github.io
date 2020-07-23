---
layout: post
title: "Express framework: Common error handler"
description: Router object for correct registration of common error handler
summary: There is a workaround for the express framework to register common error handler before concrete routes handlers.
tags: javascript express nodejs
---

The Express framework doesn't allow us to set up a global error handler before assign route handlers.
It's not handy, because we do all common settings before all concrete application stuff, usually.

There is a workaround in the case of the express framework.
Create and assign `express.Router` on the root URL, then register a global error handler.

```javascript
const router = express.Router();
httpServer.use('/', router);
httpServer.use(errorHandler);
```

```javascript
function errorHandler(err, req, res, next) {
  _logger.error(err.stack);
  if (res.headersSent) {
    return next(err)
  }
  if (req.xhr || req.headers.accept.indexOf('json') > -1) {
    res.status(500).send({ error: err.message || 'Server error' })
  } else {
    res.status(500).send(err.message || 'Server Error')
  }
}
```

All following route handlers should be registered within the Router object instead of the main express instance.
Now it's ok to register route handlers after a common error handler.

```javascript
 router.get('/some/url', async (req, res, next) => {
  try {
  
    // ...

    next();
  } catch (err) {
    next(err);
  }
});
```
