---
layout: post
title: ".nojekyll file to host Nuxt project on GitHub"
description: There is a handy tip for serving Nuxt project on GitHub pages hosting
summary: I'm hosting SPA demo application based on Nuxt on GitHub. But Jekyll engine ignores _nuxt/ dir because of leading underscore. There is the best workaround.
tags: jekyll github nuxt
---

I was taking part in the awesome hackathon last weekend.
For demonstration the SPA web UI, I've done, I used GitHub.io pages free hosting.
I used Vue, Vuex, Vuetify, and Nuxt to implement the application.
But nuxt places some files into `_nuxt/` directory,
which is ignored by Jekyll engine on GitHub.io side.

To avoid such a conflict, it's enough to place `.nojekyll` empty file in the root of the repo.
So, Jekyll engine would be turned off, and you can host your Nuxt based solution.

Happy hosting!