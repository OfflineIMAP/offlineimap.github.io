---
layout: page
title: GSoC
permalink: /gsoc/
date: 2016-02-13
author: Nicolas Sebrecht
---

{% assign links = site.data.links %}

The [Google Summer of Code](https://developers.google.com/open-source/gsoc/) *(GSoC)* is a program made by Google **for student developpers to get paid to write open source code**.

## OfflineIMAP organization

[OfflineIMAP organization]({{ links.offlineimap.organization }}) is born years ago to support the development of the OfflineIMAP software. OfflineIMAP is a python program included in all major open source distributions *(Debian, Ubuntu, RedHat, Slackware, Gento, Archlinux, etc)*. Since [some months](http://offlineimap.org/development/2015/10/08/imapfw-is-made-public.html), the [imapfw project](https://github.com/OfflineIMAP/imapfw) was started to become the next generation tool with [a new approach](http://www.dailymotion.com/video/x3gpqqs_introduce-imapfw-syncaccounts_tech) and [extended features](https://gist.github.com/nicolas33/003f1b7184c7dfb26192).

## Project ideas 2016

There are various features that can be written for imapfw. Here are ideas but student-initiated proposals are welcome. **Share your ideas and [talk with us]({{ links.mailing_list.subscribe }})!** *We are open-minded people*. ,-)


#### Synchronization of mails

Enable syncing of mails between a local Maildir and a remote server. This includes starting a new 3-way merge engine, implement a Maildir driver, finishing high-level support of IMAP on top of the imaplib3 library and create a new backend for the cache.

{:.warning}
**Required skills:**
* Python
* Git
* Read and understand RFCs
* Not be afraid to write something new ,-p

{:.note}
**Would be a plus while not strictly required:**
* Basic notions of the IMAP protocol

#### Implement a fresh new legacy-compatible OfflineIMAP software with imapfw

With all backends (drivers) implemented, write a fresh new offlineimap command. This requires supporting the OfflineIMAP's configuration file and its local cache (sqlite3).

{:.warning}
**Required skills:**
* Python
* Git
* Read and understand RFCs
* Not be afraid to write something new ,-p

{:.note}
**Would be a plus while not strictly required:**
* Basic notions of the IMAP protocol

#### Create a partial IMAP library

Start a new IMAP library designed to imapfw's high-level objects. It aims at being KISS and low constrained. Full IMAP support is not expected, only a subset of the available commands.

{:.warning}
**Required skills:**
* Python
* Git
* Read and understand RFCs
* Good notions of the IMAP protocol

<!--
vim: ts=2 expandtab :
-->
