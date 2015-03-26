---
layout: page
title: Factorize settings in the configuration file
date: 2015-03-26
author: Nicolas Sebrecht
---


* junk
{:toc}

---


## The DEFAULT section

If you have redondant settings accross a lot of accounts, it's possible to set a section named `DEFAULT`.

Here, the `Example` account has `postsynchook = notifysync`.

{% highlight ini %}
[DEFAULT]
postsynchook = notifysync.sh

[Account Example]
localrepository = LocalExample
remoterepository = RemoteExample
autorefresh = 5
{% endhighlight %}

{:.warning}
Be care that all the undefined options will make use of the `DEFAULT` section.


## Using interpolation

It's possible to combine values from others.

{% highlight ini %}

[Account Example]
localrepository = LocalExample
remoterepository = RemoteExample

mailfilter = imapfilter -c
presynchook = %(mailfilter) someconfig.lua
{% endhighlight %}

> Yes, I know this is not a very compelling sample. :-)

{:.warning}
Be care to not introduce recursive references or an exception will be raised.


## Mixing DEFAULT and interpolation

{% highlight ini %}
[DEFAULT]
mailfilter = imapfilter -c

[Account Example]
localrepository = LocalExample
remoterepository = RemoteExample

presynchook = %(mailfilter) someconfig.lua
{% endhighlight %}

<!--
vim: expandtab ts=2 :
-->
