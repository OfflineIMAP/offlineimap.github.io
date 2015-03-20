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


## The releases conventions

There are 3 kind of releases we do:

- **stable**: `vX.Y.Z`
  - `X`: Major release number, currently 6 which didn't change since May, 2008 (it's good like that).
  - `Y`: Big release number, used for big code changes, API changing, backard compatibily issues.
  - `Z`: Minor release number, any other changes.
- **release candidate**: `vX.Y.Z-rcN`
  - Before releasing a stable version, we publish candidates to avoid intoducing too many bugs.
  - Make as many candidates as you think it worth.
- **maintenance**: vX.Y.Z.K
  - Should be avoided; it's only usefull for backporting big bug fixes and strong security issues.
  - Should be based on the previous stable branch (current stable `Y` - 1).
  - They are released only in the `maint` branch.


## With the release script *(highly recommended)*

The `release.sh` will do all the boring job for you. Il will prompt you to edit the version in the code, write the Changelog from the git history, prepare the announce, etc.

{% highlight bash %}
$ ./contrib/release.sh
{% endhighlight %}

Once done, [publish everything](#push-the-changes).


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
$ git add \_doc/versions
$ git commit -a -s -m'import offlineimap API <vX.Y.Z[-rcN]>'
$ git checkout master
$ git merge next
{% endhighlight %}


## Push the changes

{: .note}
{{ icons.note }} Make your checks! {{ icons.end }}
Before publishing anything, ensure things are correct:
* The `Changelog.md` is fine
* the `tag` of the release is set correctly
* the `next` history looks good
* the `master` branch is updated


{% highlight bash %}
$ git push OfflineIMAP master:master
$ git push OfflineIMAP next:next
$ git push OfflineIMAP <tag>:<tag>
{% endhighlight %}

Finally, push the changes of the updated website.

{% highlight bash %}
$ cd website
$ git push website master:master
{% endhighlight %}


{: .warning}
{{ icons.warning }} **DO NOT use fancy shortened command** {{ icons.end }}
Shortened commands like `git push`, `git push --all` or `git push --tags` tend to push way too much things by default. **Keep control of what make public!**

{: .note}
{{ icons.note }} Hint: {{ icons.end }}
If despite the BIG warning you've push too much, delete the offender branches/tags with
`git push OfflineIMAP :<offender>`


## Send the announce

Finally, send the announce to the mailing list. If you used the `release.sh` script, one was prepared for you in `.git/offlineimap-release/announce.txt`.

> You're done!

<!--
vim: expandtab ts=2 :
-->
