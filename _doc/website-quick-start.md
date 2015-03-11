---
layout: page
title: Quick start to contribute to this website
---

### Get a local copy of the sources

#### Via the script in 'offlineimap.git' *(recommended)*

~~~ bash
$ ./get-website.sh
$ cd ./website
~~~

This will clone the repository of the sources and do a bit of extra
configuration.

#### Directly from the public repository

~~~ bash
$ git clone https://github.com/OfflineIMAP/offlineimap.github.io.git
~~~

#### What to do next

Make your changes, check [how it looks](#rendering-my-changes), and sumbit them to the maintainers, as for usual patches.


### Create a blog post

~~~ bash
$ cd \_posts
$ ls
$ cp YYYY-MM-DD-whatever.md YYY-MM-DD-my-post.md
<edit>
$ git add .
$ git commit
~~~

Then, [render it](#rendering-my-changes), check, push to your Github fork and make a pull request.

### Create a documentation page

~~~ bash
$ cd \_doc
$ ls
$ cp any.md new-doc.md
<edit>
$ git add .
$ git commit
~~~

Contrary to the blog posts, pages in `_doc` are not indexed automaticaly.  Edit `documentation.html` and add a new entry to your documentation page.

{: .warning}
Be care that you have to set the **URL** as a target which ends with `.html`. Not the source with the `.md` extension.

Then, [render it](#rendering-my-changes), check, push to your Github fork and make a pull request.


### Rendering my changes

There are two ways for rendering your changes before submitting them:

#### Via Github *(recommended)*

Using Github, via your public fork of the `offlineimap.git` project.

~~~ bash
$ ./render.sh
~~~

#### Locally

For rendering it locally, you must have [jekyll installed](#about-jekyll).

~~~ bash
$ ./run_server.sh
~~~


## About Jekyll

Check out the [Jekyll docs][jekyll] for more info on how to get the most out of Jekyll. Bug and feature requests for Jekyll are at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll’s dedicated Help repository][jekyll-help].

### The syntax

The source files use `.md` extension for the [kramdown syntax][kramdown] which is derivated from **mardkown**.


### The theme


The look is very important. Feel free to add your own touch! We started from the base Jekyll theme because it's clean and simple.

You can get inspiration from other's customized themes.


### Highlighting

Highlight is made by Jekyll with [pygments](http://pygments.org/docs/quickstart).


## Other ressources

* <http://jekyllrb.com/docs/structure/>
* <https://help.github.com/articles/repository-metadata-on-github-pages/>
* <https://gist.github.com/jedschneider/2890453>
* <https://help.github.com/articles/using-jekyll-with-pages/#configuring-jekyll>


[jekyll]:      http://jekyllrb.com
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-help]: https://github.com/jekyll/jekyll-help
[kramdown]:    http://kramdown.gettalong.org/syntax.html

<!--
vim: ts=2 expandtab :
-->
