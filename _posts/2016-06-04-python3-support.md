---
layout: post
title: "offlineimap learns Python 3 support"
date: 2016-06-04
author: Nicolas Sebrecht
categories: development
---

{% assign links = site.data.links %}
{% assign icons = site.data.icons %}


<!--more-->

* junk
{:toc}


With the great work done by [Łukasz Żarnowiecki](https://github.com/dolohow),
offlineimap starting from v7.0.0-rc2 can run with Python 3.

This feature is marked *EXPERIMENTAL* for now because it's still very new.

{:.note}

You're very welcome to test this feature and report bugs in [our issues
tracker]({{ links.offlineimap.issues }}) and the [mailing list]({{
links.mailing_list.address }}).

{:.DarkBlue}
**Thank you Łukasz!**

### What to expect

With Python 3, some bugs gets fixed. The ones that come to my mind are:

* [lots of CPU wakeups](https://github.com/OfflineIMAP/offlineimap/issues/81)
* [Py2 ConfigParser doesn't raise errors on multiple same-named sections](https://github.com/OfflineIMAP/offlineimap/issues/143)


### What NOT to expect

Improved encodings support. It is true that Python 3 has much better support for
Unicode than Python 2. However (you likely already know it), supporting
encodings other than UTF-7 with offlineimap is hard, very hard. So, I don't
expect this feature to come while Python 2 is supported.
