---
layout: page
title: GSoC
permalink: /gsoc/
date: 2016-02-13
author: Nicolas Sebrecht
---

{% assign links = site.data.links %}

The [Google Summer of Code](https://developers.google.com/open-source/gsoc/) *(GSoC)* is a program made by Google **for student developpers to get paid to write open source code**.


* junk
{:toc}

---

## OfflineIMAP organization

[OfflineIMAP organization]({{ links.offlineimap.organization }}) is born years ago to support the development of the OfflineIMAP software. OfflineIMAP is a python program included in all major open source distributions *(Debian, Ubuntu, RedHat, Slackware, Gentoo, Archlinux, etc)*. Since [some months](http://offlineimap.org/development/2015/10/08/imapfw-is-made-public.html), the [imapfw project](https://github.com/OfflineIMAP/imapfw) was started to become the next generation tool with [a new approach](http://www.dailymotion.com/video/x3gpqqs_introduce-imapfw-syncaccounts_tech) and [extended features](https://gist.github.com/nicolas33/003f1b7184c7dfb26192).


## Project ideas 2016

There are various features that can be written for imapfw. Here are ideas but student-initiated proposals are welcome. **Share your ideas and [talk with us]({{ links.mailing_list.subscribe }})!** *We are open-minded people*. ,-)


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

> Students, this application is not yet accepted and might not be. Check the [official timeline](https://developers.google.com/open-source/gsoc/timeline) to know more.

As a mentor, my goal is to **make your GSoC student project successful**. By successful, I mean:

* your project should be **a good experience**: ideally, you'll *end the summer with the desire to be involved in this (or any other) open source project*;
* know/learn how to **efficiently work** with open source communities;
* know/learn that code is not everything: **tools and relationships matter**;
* know/learn how to **talk with code**;
* know/learn how to **get your code merged** into the official code because *it's most rewarding to know your work is actually used by others*;
* know/learn how to find the correct technical ressources you're missing;
* **earn technical knowledges** or how to request help while embarrased: **nobody knows everything**;
* you'll **make mistakes**, everybody do, that's not the end.

#### Why you should trust me

* Good experience with various open sources communities, for years.
* Started by tracking how things gets done, then sent patches and contributed, finally became a maintainer years ago.
* Made *big* mistakes myself.
* Applying common open source expectations.
* Keeping fun! ,-)
* Open minded. Well, I guess...

#### What I'll mostly expect from you

* Mistakes. Did I already say you'll do? :-)
* Keep alive :-D
* **Show** you're still alive
* Do your home-work
* Eat food
* Ask *very very weird* questions ,-)
* Sleep
* Contact me as soon as possible, you won't provide the perfect proposal at the first shot. That's fine.


<!--
vim: ts=2 expandtab :
-->
