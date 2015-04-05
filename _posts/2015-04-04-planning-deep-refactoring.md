---
layout: post
title: Planning a deep refactoring
date: 2015-04-04
author: Nicolas Sebrecht
categories: development
---
{% assign icons = site.data.icons %}


I'm planning a deep refactoring.

<!--more-->

The more I read the codebase the mode it's obvious it requires a deep refactoring. I won't elaborate on the reasons. I've already talked enough about why for weeks in the mailing list.

{:.note}
This will happen as soon as the next stable v6.5.7 will be out.

{:.warning}
I won't merge anymore features during the coming cycle. If you intend to implement one, it's not the good time to start it now.

As far as I can tell today, here are some of the planned tasks:

* better names for variables, objects, etc;
* improve comments, especially about the logic;
* better policy on objects;
* revamp inheritance of objects;
* revamp the factorization accross objects;
* better namespacing;
* don't blindly inherit from library objects;
* usual patterns more strictly applied;
* seriously improve our debugging/hacking sessions.

For details, see `TODO.rst` in the source tree.

{:.note}
Anyone interested might like to follow the work in progress with git.


<!--
vim: ts=2 expandtab spelllang=en :
-->
