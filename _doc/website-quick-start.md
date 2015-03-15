---
layout: page
title: Quick start to contribute to this website
date: 2015-03-15
author: Nicolas Sebrecht
---

{% assign links = site.data.links %}


{: .note}
**Note:**
The minimal required tool sets for the recommended way are **Git**, a **text editor**, a **Github account** *(free)*. Though, using **Git** is not required for quick fixes.


* junk
{:toc}

---


### Get a local copy of the sources

#### Via the script in 'offlineimap.git' *(recommended)*

If you don't have the offlineimap Git sources:

{% highlight bash %}
$ wget 'https://raw.githubusercontent.com/OfflineIMAP/offlineimap/next/scripts/get-repository.sh'-O get-repository.sh
{% endhighlight %}

{% highlight bash %}
$ ./get-repository.sh website
$ cd ./website
{% endhighlight %}

This will clone the repository of the sources and do a bit of extra configuration.

{: .note}
**Note:** If you downloaded the sources via **wget**, you have to configure the `username` variable in the renderer file `render.sh`.

#### Editing online

Login to Github, browse the sources online in your fork, pick up a file, edit and commit.


#### Directly from the public repository

{% highlight bash %}
$ git clone {{ links.website.repo.http }}
{% endhighlight %}

#### What to do next

Make your changes, check [how it looks](#rendering-my-changes), and sumbit them to the maintainers, as for usual patches.


### Create a blog post

{% highlight bash %}
$ cd \_posts
$ ls
$ cp YYYY-MM-DD-whatever.md YYY-MM-DD-my-post.md
<edit>
$ git add .
$ git commit
{% endhighlight %}

Then, [render it](#rendering-my-changes), check, push to your Github fork and make a pull request.

### Create a documentation page

{% highlight bash %}
$ cd \_doc
$ ls
$ cp any.md new-doc.md
<edit>
$ git add .
$ git commit
{% endhighlight %}

Contrary to the blog posts, pages in `_doc` are not indexed automaticaly.  Edit `documentation.html` and add a new entry to your documentation page.

{: .warning}
Be care that you have to set the **URL** as a target which ends with `.html`. Not the source with the `.md` extension.

Then, [render it](#rendering-my-changes), check, push to your Github fork and make a pull request.


### Rendering my changes

There are two ways for rendering your changes before submitting them:

#### Via Github *(recommended)*

Using Github, via your public fork of the `offlineimap.git` project.

{% highlight bash %}
$ ./render.sh
{% endhighlight %}

#### Locally

For rendering it locally, you must have [jekyll installed](#about-jekyll).

{% highlight bash %}
$ ./run_server.sh
{% endhighlight %}


## About Jekyll

Check out the [Jekyll docs]({{ links.others.jekyll.home }}) for more info on how to get the most out of Jekyll. Bug and feature requests for Jekyll are at [Jekyll’s GitHub repo]({{ links.others.jekyll.project }}). If you have questions, you can ask them on [Jekyll’s dedicated Help repository]({{ links.others.jekyll.help }}).

### The syntax

The source files use `.md` extension for the [kramdown syntax]({{ links.others.kramdown.syntax }}) which is derivated from **mardkown**.


### The theme


The look is very important. Feel free to add your own touch! We started from the base Jekyll theme because it's clean and simple.

You can get inspiration from other's customized themes.


### Highlighting

Highlight is made by Jekyll with [pygments]({{ links.others.pygments.quickstart }}).


## Other ressources

* <http://jekyllrb.com/docs/structure/>
* <https://help.github.com/articles/repository-metadata-on-github-pages/>
* <https://gist.github.com/jedschneider/2890453>
* <https://help.github.com/articles/using-jekyll-with-pages/#configuring-jekyll>



<!--
vim: ts=2 expandtab :
-->
