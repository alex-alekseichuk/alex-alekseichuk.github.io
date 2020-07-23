---
layout: post
title: "Exclude in Babel"
description: Exclude third party libraries in babel webpack loader
summary: I build complicated application by webpack+babel. It's important to exclude third party libraries loaded from node_modules.
tags: webpack babel javascript
---

I build complicated application by webpack+babel.
Obviously, it uses some well-known libraries as dependencies.
Usually, those libraries are already packed, so we don't need to process them,
just import/require and use.

That's why it's handy to exclude such a dependency from processing by babel.
See a rule below. We just exclude all files from `node_modules`.

```javascript
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        loaders: [
          'babel-loader'
        ]
      }
```

There would be more complicated configuration. E.g., we use our own common library as dependency.
In this case we need to include files from such a source into loader.
One of approaches is to add exception for the module into regexp.

```javascript
  {
    test: /\.jsx?$/,
    exclude: /node_modules[\\\/](?!common[\\\/])/,
    loaders: [
      'babel-loader',
    ]
  }
```

It looks too messy and weired. Regexp becomes unreadable.
There is better approach below.

```javascript
  exclude: {
    test: path.resolve(__dirname, "node_modules"),
    exclude: path.resolve(__dirname, "node_modules/common")
  },
```

Happy building!