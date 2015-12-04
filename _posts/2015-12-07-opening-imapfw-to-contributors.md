---
layout: post
title: imapfw is now open to contributions
date: 2015-12-07
updated: 2015-12-07
author: Nicolas Sebrecht
categories: imapfw development
---
{% assign icons = site.data.icons %}


imapfw is reaching an interesting stage for the developers. Also, I made a screencast for starting with imapfw.

<!--more-->

While [imapfw](https://github.com/OfflineIMAP/imapfw) won't still synchronize your accounts, the framework is reaching an insteresting stage for developers.

To know more about imapfw usage and internals, screencasts are available in [this channel](http://www.dailymotion.com/offlineimap-project).


## Current state

Since the publication (2 months ago), the main internals and features have been started or done:

##### The features

* enable the rascal, allows key frame redefinitions.
* support both multiprocessing and threading via unified internal interfaces.
* asynchronous and synchronous communication between workers.
* started the syncing engines, repositories, drivers and controllers.

##### Actions

Actions are real softwares packaged within the framework, actually.

* `unitTests`.
* `syncAccounts`.
* `shell`: run code with predefined contexts, optionally in interactive mode.

##### Internals

* wrapper on top of the IMAP library to work with high-level objects.
* supporting python 3 hints/annotations is partially done. Will be expanded everywhere with code stabilization.
* architect modules to set up the running code with workers.


## What next?

I expect to write code more slowly. This should benefit both myself to get more free time and contributors to not be disturbed by code changing too fast.

I'm planning to start writing a `offlineimap` action to allow imapfw to become an alternative to the current offlineimap software in a legacy compatible way.

{:.note}
This suppose supporting both the configuration file and the cache. Full compatibility is not a goal. For example, using the sqlite cache format will be a pre-requisite.

A website, like the one used for OfflineIMAP (from where you're reading this page). :-)

## What you can do

#### Developers

There are things that are more time consuming than hard to realize, actually. Involve yourself would greatly help to get the first stable release out. E.g.:

* Complete the internal APIs.
* Write drivers, controllers, engines.
* Write tests.

For more details, the [TODO list](https://gist.github.com/nicolas33/003f1b7184c7dfb26192) is online.

#### Users

* Try features out.
* Run the tests from time to time.


## The sceencasts

First, **screencasts won't ever replace documentation**. However, there are some cases where they can be usefull like introducing features or concepts. That's why I've started to make some. I intend to make more with time and code advance.

#### Dailymotion vs Youtube

There might be other media out there but I've only looked at the most well-known (to me, at least). I've started by creating an acount for Youtube and tried to publish my first video on it. Up to my surprise, **the video has been refused**.

In order to post videos longer than 15 minutes, [I have to give my phone number to Google](https://support.google.com/accounts/answer/114129?hl=en). The reason given is that **it effectively [avoids spams](https://support.google.com/youtube/answer/171664?hl=en) and abuses**. *It's obviously well-known that robots and spammers are only uploading videos longer than 15 minutes*...

{:.note}
I consider that my phone number is private data and I don't want to offer it to Google, the NSA or whatever. They might already have it via other ways but that's not the point. **I'm strongly against such practices**.

Hence, I've decided to use Dailymotion only. The latter doesn't requires me to expose them anything other than a mail address while they have much less ressources than Google to make war against spammers.

#### Monetization

Be aware that I've activated monetization on some videos. **I hate having to watch ads myself** and I intend to limit such practice to **some** of the available contents only. I don't want this to become generalized everywhere.

<!--
vim: ts=2 expandtab spelllang=en :
-->
