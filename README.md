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

### Local generation and preview

It's useful to generate and view content locally before pushing to github.

```
jekyll serve --watch --config _config.yml,_config.local.yml
```

There are pages:

- Home (default)
- About (page)
- Post* (post
- 404 (page)
- tag* (tagpage)

There are layouts:

- default
- page
- post
- tagepage

