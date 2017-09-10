---
layout: page
title: Making backups with ZFS snapshots
author: Nicolas Sebrecht
date: 2015-03-15
updated: 2017-02-15
---
{% assign icons = site.data.icons %}
Optional:
Generate a *zfs* mountpoint dedicated to your Mails:

{% highlight bash %}
$ zfs create zroot/usr/home/$USER/Mail
{% endhighlight %}

To create a snapshot (with a date as the seed) you can run:

{% highlight bash %}
$ zfs snapshot zroot/usr/home/$USER/Mail@$(date +%Y%m%d%H%M%S)offlineimap
{% endhighlight %}

Of course you need to point your 'localfolders' to a subdirectory of the zfs
mountpoint you are generating a snapshot of.

Now you can easily wrap your offlineimap command with a failsafe like that:

{% highlight bash %}
#!/bin/sh
zfs snapshot zroot/usr/home/$USER/Mail@$(date +%Y%m%d%H%M%S)offlineimap
# append your commandline options as needed to the script
offlineimap $\*
{% endhighlight %}

*TODO*:
 Implement as offlineimap hook
