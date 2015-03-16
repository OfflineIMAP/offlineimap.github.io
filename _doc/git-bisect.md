---
layout: page
title: git bisect
date: 2015-03-16
author: Nicolas Sebrecht
---

{% assign offlineimap = site.data.links.offlineimap %}
{% assign icons = site.data.icons %}

{: .note}
There are already a lot of documentation about `git bisect`, already. Sadly, few explain HOW to do it properly when you're not used to development.


* junk
{:toc}

---

## Pre-requisite

You'll need `git` and the git repository of OfflineIMAP, of course... ;-)

Clone the repository:

{% highlight bash %}
$ git clone {{ offlineimap.repository }}
{% endhighlight %}

## The commands

There are few simple commands to know.

* Start a session
{% highlight bash %}
$ git bisect start
{% endhighlight %}

* Mark as good
{% highlight bash %}
$ git bisect good
{% endhighlight %}

* Mark as bad
{% highlight bash %}
$ git bisect bad
{% endhighlight %}

* Ignore a step
{% highlight bash %}
$ git bisect skip
{% endhighlight %}

* Stop a session
{% highlight bash %}
$ git bisect reset
{% endhighlight %}

## Effective session

Before starting, you should know what version works and what version does not.  This is required to start the process.

{% highlight bash %}
$ git bisect start
$ git bisect good v6.5.6
$ git bisect bad v6.5.7-rc2
{% endhighlight %}

From there, it's you're job to define if OfflineIMAP has the **same issue** or not.

{% highlight bash %}
$ ./offlineimap.py [THE USUAL OPTIONS]
{% endhighlight %}

{: .warning}
{{ icons.warning }} Warning {{ icons.end }}
  Be care to mark the checkouted version as `good` or `bad` **ONLY** if you're sure about that.
 
  *A wrong declaration will put you in the wrong direction.*

When in doubt, you must input the `git bisect skip` command.

{: .warning}
{{ icons.warning }} Warning {{ icons.end }}
**A failing run does NOT necessary mean you should declare it `bad`.**
 
In such case, you must check what's the error and if it's the one you are bisecting. Otherwise, you must input `git bisect skip` command, too.

## Understanding what is done

The process is fairly simple to understand. It just start in the middle of the patch series between the one marked as `good` and the one marked as `bad`. When a new `good`/`bad` is declared, it take the new middle between both and continue.

{: .note}
It's a bit more complex if the *git history* is not linear but we don't have to care about the internals.

<!--
vim: expandtab ts=2 :
-->
