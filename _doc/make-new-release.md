---
layout: page
title: Making a new release
date: 2015-03-15
author: Nicolas Sebrecht
---
{% assign icons = site.data.icons %}


{: .DarkBlue}
*You decided it's time for a new release... **Good!***

{: .warning}
Before doing anything, ensure all the changes are mades and committed.

{: .warning}
Think twice at each step.

{: .note}
{{ icons.note }} Hint {{ icons.end }}
If it's a first experience for you, try doing the process against your own public fork. ,-)

{: .note}
{{ icons.note }} Request for advices {{ icons.end }}
If you're in doubt, *request help to a more experienced maintainer*. We are here to help and blaming is not our way of working with each other. **We ALL did crap** at some point in time.



* junk
{:toc}

---


## With the release script *(highly recommended)*

*TODO*

## Doing the job manually

### Prepare the Changelog

First, edit `Changelog.md` to reflect the release. Add a new entry on top of it and **don't change anything else**.

{: .note}
{{ icons.note }} Hint: {{ icons.end }}
The shortlog is a good start. Use `git shortlog $(./offlineimap.py --version)..`.

### Update the version

Edit `offlineimap/__init__.py` and update the version.

### Commit and release

{% highlight bash %}
$ git commit -a -s -m<vX.Y.Z[-rcN]>
$ git tag -a -s -m<vX.Y.Z[-rcN]> <vX.Y.Z[-rcN]>
{% endhighlight %}

Check the changes:

{% highlight bash %}
$ git log -p
{% endhighlight %}


### Merge into the mainline

{% highlight bash %}
$ git checkout master
$ git merge next
{% endhighlight %}


### Push the changes

{% highlight bash %}
$ git push OfflineIMAP master:master
$ git push OfflineIMAP next:next
$ git push OfflineIMAP <tag>:<tag>
{% endhighlight %}

{: .warning}
{{ icons.warning }} **DO NOT use fancy shortened command** {{ icons.end }}
Shortened commands like `git push`, `git push --all` or `git push --tags` tend to push way too much things by default. **Keep control of what make public!**

{: .note}
{{ icons.note }} Hint: {{ icons.end }}
If despite the BIG warning you've push too much, delete the offender branches/tags with
`git push OfflineIMAP :<offender>`

### Update the APIs on the website

{: .note}
{{ icons.note }} Use the Makefile! {{ icons.end }}
Amongs the APIs, other files might be updated as *the Changelogs*, for example.


{: .warning}
{{ icons.warning }} Pre-requisite {{ icons.end }}
You must have sphinx installed and the `sphinx-build` in your `$PATH`.

{% highlight bash %}
$ cd docs
$ make websitedoc
$ cd ../website
$ git checkout -b next master
$ git add _doc/versions
$ git commit -a -s -m'import offlineimap API <vX.Y.Z[-rcN]>'
$ git checkout master
$ git merge next
$ git push website master:master
{% endhighlight %}







<!--
vim: expandtab ts=2 :
-->
