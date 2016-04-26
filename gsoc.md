---
layout: page
title: GSoC
permalink: /gsoc/
date: 2016-02-13
updated: 2016-04-26
author: Nicolas Sebrecht & Abdó Roig-Maranges
---

{% assign links = site.data.links %}
{% assign icons = site.data.icons %}
{% assign helpers = "/gsoc/helpers.html" %}
{% assign experience = "/gsoc2016/2016/04/23/GSoC2016-with-Gentoo.html" %}


Learn about [our experience with Gentoo]({{ site.base }}{{ experience }}).

{:.note}
While the application time for the GSoC is over, ***we are still welcoming new comers!***

---

The [Google Summer of Code](https://developers.google.com/open-source/gsoc/) *(GSoC)* is a program made by Google **for student developpers to get paid to write open source code**.


* junk
{:toc}


## OfflineIMAP organization

[OfflineIMAP organization]({{ links.offlineimap.organization }}) is born years ago to support the development of the OfflineIMAP software. OfflineIMAP is a python program included in all major open source distributions *(Debian, Ubuntu, RedHat, Slackware, Gentoo, Archlinux, etc)*. Since [some months]({{ site.base }}/development/2015/10/08/imapfw-is-made-public.html), the [imapfw project](https://github.com/OfflineIMAP/imapfw) was started to become the next generation tool with [a new approach](http://www.dailymotion.com/video/x3gpqqs_introduce-imapfw-syncaccounts_tech) and [extended features](https://gist.github.com/nicolas33/003f1b7184c7dfb26192).


## Project ideas 2016

There are various features that can be written. Here are some ideas but your own proposals for imapfw are welcome.

{:.note}
{{ icons.note }} Tip: {{ icons.end }}
**Share your ideas (if any) and [talk with us]({{ site.base }}{{ helpers }})!** *(sooner is better)*


#### Synchronization of mails

Enable syncing of mails between a local Maildir and a remote server. This includes starting a new 3-way merge engine, implement a Maildir driver, finishing high-level support of IMAP on top of the imaplib3 library and create a new backend for the cache.

##### Difficulty level:

{: .DarkRed}
medium

##### Required skills:

{: .DarkRed}
* Python
* Git
* Read and understand RFCs
* Not be afraid to write something new ,-p

##### Would be a plus while not strictly required:

{: .DarkBlue}
* Basic notions of the IMAP protocol


#### Implement a fresh new legacy-compatible OfflineIMAP software with imapfw

With all backends (drivers) implemented, write a fresh new offlineimap command. This requires supporting the OfflineIMAP's configuration file and its local cache (sqlite3).

##### Difficulty level:

{: .DarkRed}
medium

##### Required skills:

{: .DarkRed}
* Python
* Git
* Read and understand RFCs
* Not be afraid to write something new ,-p

##### Would be a plus while not strictly required:

{: .DarkBlue}
* Basic notions of the IMAP protocol


#### Create a partial IMAP library

Start a new IMAP library designed to imapfw's high-level objects. It aims at being KISS and low constrained. Full IMAP support is not expected, only a subset of the available commands.

##### Difficulty level:

{: .DarkRed}
hard

##### Required skills:

{: .DarkRed}
* Python
* Git
* Read and understand RFCs
* Good notions of the IMAP protocol


## Mentoring approach

{:.note}
{{ icons.note }} Note: {{ icons.end}}
The following statements are intentionally general. If you're already used to open source, some to most of them might be irrevelant.
We highly encourage you to early expose **your own expectations** for this GSoC.

As mentors, our goal is to **make your GSoC project successful**. By successful, we mean:

* your project should be **a good experience**: ideally, you'll *end the summer with the desire to be involved in this (or any other) open source project*;
* know/learn how to **efficiently work** with open source communities;
* know/learn that code is not everything: **tools and relationships matter**;
* know/learn how to **talk with code**;
* know/learn how to **get your code merged** into the official code because *it's most rewarding to know your work is accepted and actually used by others*;
* know/learn how to get the correct technical ressources and knowledges;
* **earn technical knowledges** or how to request help while embarrased: **nobody knows everything**;
* you'll **make mistakes**, everybody do, that's not the end;
* **become self-sufficient**: you should end the course understanding *how to make a kick-ass start-up in almost any open source project: what communities expect towards to new-comers (open source can be brutal)*;
* ...and yes, we aim your GSoC project at being tagged *"**success**"*.


#### Why you should trust Nicolas

* Good experience with various open sources communities, for years.
* Started by tracking how things gets done, then sent patches and contributed, finally became a maintainer years ago.
* Made *big* mistakes.
* Applying common open source expectations.
* Keeping fun!
* Open minded. ,-)
* Teaching experience.
* Confidenciality of all our private exchanges.
* Intend to reply to each request. The response might not always be what you expect but you won't be left at the side.

#### What we'll mostly expect from you

* Mistakes. Did we already say you'll make mistakes? *:-)*
* Keep alive :-D
* **Show** you're still alive
* Do your home-work
* Eat food
* Ask *very very weird* questions ,-)
* Sleep


## Helpers

{{ icons.note }} Interrested? Want to know more? {{ icons.end }}
Read [our helpers]({{ site.base }}{{ helpers }}).


<!--
vim: ts=2 expandtab :
-->
