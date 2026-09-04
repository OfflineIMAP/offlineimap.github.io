---
layout: page
title: Quick start to contribute to this website
date: 2015-03-15
author: Nicolas Sebrecht
updated: 2015-04-08
---
{% assign links = site.data.links %}


There are basically 3 steps:

* get a local copy of the sources;
* make you changes, render and check;
* once ready, submit to the maintainers.


{:.note}
**Note:**
The minimal required tool sets for the *recommended way* are **Git**, a **text editor**, a **Github account** *(free)*. However, only a **text editor** is strictly required. ,-)


* junk
{:toc}

---


### Get a local copy of the sources

#### Cloning via the script in 'offlineimap.git'

##### From OfflineIMAP's Git repository *(recommended)*

This will clone the repository of the sources and do a bit of extra configuration.

{% highlight bash %}
$ ./scripts/get-repository.sh website
$ cd ./website
{% endhighlight %}

##### Without OfflineIMAP's Git repository

If you don't have the offlineimap Git sources, you can download the script:

{% highlight bash %}
$ wget 'https://raw.githubusercontent.com/OfflineIMAP/offlineimap3/next/scripts/get-repository.sh' -O get-repository.sh
$ ./scripts/get-repository.sh website
{% endhighlight %}

{: .note}
**Note:** If you downloaded the script via **wget**, you'll have to configure the `username` variable in the renderer file `./run_server.sh`.

#### Cloning with Git

{% highlight bash %}
$ git clone {{ links.website.repo.http }}
{% endhighlight %}

#### From zip source

{% highlight bash %}
$ wget '{{ links.website.download.master_zip }}' -O offlineimap-website.zip
$ unzip offlineimap-website.zip
{% endhighlight %}


#### Editing online

Login to Github, browse the sources online in your fork, pick up a file, edit and commit.


### What to do next

Make your changes, check [how it looks](#rendering-my-changes), and submit them to the maintainers, as for usual patches.


### Create a blog post

{% highlight bash %}
$ cd \_posts
$ ls
$ cp YYYY-MM-DD-whatever.md YYY-MM-DD-my-post.md
<edit>
$ git add .
$ git commit
{% endhighlight %}

Then, [render it](#rendering-my-changes), check, push to your Github fork and make a pull request. If you don't have a public Git repository, you can send the file of your post to the maintainers.

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

Then, [render it](#rendering-my-changes), check and [submit](#submit).


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


### Submit to the maintainers

#### With Git

Push your changes to your public fork and request a pull.

#### Without Git

Put the files you changed as a [Gist](https://gist.github.com) and request the maintainers. Gists are usefull but not required, if you don't like it use something else.

Requesting the maintainers the way you'd like:
* open an [issue]({{ links.website.project }}/issues);
* send a mail.


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
