---
layout: post
title: "sqlite becomes the default"
date: 2016-04-23
updated: 2016-04-26
author: Nicolas Sebrecht
categories: configuration
---

{% assign links = site.data.links %}
{% assign icons = site.data.icons %}


<!--more-->

* junk
{:toc}


### The change

After years of development and improvements, the sqlite database becomes the
default with v7.0.0-rc1. The database is used for offlineimap to track what was
already synced in the cache.


### Prevent from errors

This change means that downgrading from `v7.*` to any previous release might be
prone to errors. While the migration from the (legacy) plain text database to
sqlite is seemingly handled, it is not the case the other way around. In other
words, this might lead to emails re-downloads and duplications.

{:.warning}

Before downgrading from `v7.*` to any version `6.*`, users must make sure to
have the sqlite backend enabled in the configuration file.

### Other considerations

1. While sticking to the plain text database is still possible as for now, users
	 should expect this backend to become *deprecated and removed* in the future.

2. Once switched of backend from plain to sqlite, you may want to manually
	 delete the old cache directory in `<metadata
	 directory>/Account-<account>/LocalStatus` . The sqlite cache stands in the
	 `LocalStatus-sqlite` folder.
