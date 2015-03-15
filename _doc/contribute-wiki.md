---
layout: page
title: How to contribute to the wiki
author: Nicolas Sebrecht
date: 2015-03-15
---
{% assign icons = site.data.icons %}
{% assign wiki = site.data.links.wiki %}


* junk
{:toc}

---

{% include_relative wiki-intro.md wiki=wiki %}


## Making changes

### Online

Github users can edit pages online.

### Via Git

#### With the script *(recommended)*

If you already have a local copy of the offlineimap repository, run the dedicated script.

{% highlight bash %}
$ ./scripts/get-repository.sh wiki
{% endhighlight %}

You'll have a local copy of the sources. From there, make a fork of [the mirror]({{ wiki.copy.project }}) and add a reference to it like this:

{% highlight bash %}
$ cd wiki
$ git remote add myfork <repo-URL-to-the-fork>
{% endhighlight %}


#### Manually

{% highlight bash %}
$ git clone {{ wiki.base }} offlineimap.wiki
$ cd offlineimap.wiki
$ git remote add myfork <repo-URL-to-the-fork>
{% endhighlight %}


#### What to do next

Push your changes to the last, make pull requests against the mirror.

- **origin** is the upstream you can fetch from
- **myfork** is where you push your change to make them public

<!--
vim: expandtab ts=2 :
-->
