# alex-alekseichuk.github.io

my personal blog

Technically, it's a jekyll web project.

It's hosted on github as github.pages repo.

### Theme

I use simple theme https://github.com/bradleytaunt/taunt-jekyll

- Updates to site title, description etc. --> _config.yml
- Updates to the main navigation --> navigation.html
- Updates to the footer --> footer.html
- Updates to about page --> about.md

### Update the set of tags

There are tags listed in each post. To update the set of tags in the system and generate each tag page
```
python scripts/tag_generator.py
```

### Local generation and preview

It's useful to generate and view content locally before pushing to github:

```
jekyll serve --watch --config _config.yml,_config.local.yml
```


To update ruby gems, if it needs:

```
bundle update
```


To write about:

- Debug js code: nodejs, mocha test, in browser, vscode
- console tools: k9s
- modules and dependencies, DI, IoC via context

