---
layout: page
title: Configuration examples
contributors: Nicolas Sebrecht
updated: 2015-04-07
---


Here are some example configurations for various situations.

* junk
{:toc}

---

## Multiple Accounts with Mutt

This example shows you how to set up OfflineIMAP to synchronize multiple accounts with the mutt mail reader.

Start by creating a directory to hold your folders by running `mkdir ~/Mail`.
Then, in your `~/.offlineimaprc`, specify:

{% highlight ini %}
accounts = Personal, Work
{% endhighlight %}


Make sure that you have both an `[Account Personal]` and an `[Account Work]` section. The local repository for each account must have different `localfolder` path names. Also, make sure to enable `[mbnames]`.

In each local repository section, write something like this:

{% highlight ini %}
localfolders = ~/Mail/Personal
{% endhighlight %}


Finally, add these lines to your `~/.muttrc`:

{% highlight ini %}
source ~/path-to-mbnames-muttrc-mailboxes
folder-hook Personal set from="youremail@personal.com"
folder-hook Work set from="youremail@work.com"
set mbox_type=Maildir
set folder=$HOME/Mail
spoolfile=+Personal/INBOX
{% endhighlight %}


> That's it!


## UW-IMAPD and References

Some users with a UW-IMAPD server need to use OfflineIMAP's "reference" feature to get at their mailboxes, specifying a reference of `~/Mail` or `#mh/` depending on the configuration.  The below configuration (originally from *docwhat@gerf.org*) shows using a reference of Mail, a `nametrans` that strips the leading `Mail/` off incoming folder names, and a `folderfilter` that limits the folders synced to just three:

{% highlight ini %}
[Account Gerf]
localrepository = GerfLocal
remoterepository = GerfRemote

[Repository GerfLocal]
type = Maildir
localfolders = ~/Mail

[Repository GerfRemote]
type = IMAP
remotehost = gerf.org
ssl = yes
remoteuser = docwhat
reference = Mail
# Trims off the preceeding Mail on all the folder names.
nametrans = lambda foldername: \
re.sub('^Mail/', '', foldername)
# Yeah, you have to mention the Mail dir, even though it
# would seem intuitive that reference would trim it.
folderfilter = lambda foldername: foldername in [
    'Mail/INBOX',
    'Mail/list/zaurus-general',
    'Mail/list/zaurus-dev',
    ]
maxconnections = 1
holdconnectionopen = no
{% endhighlight %}


## pythonfile Configuration File Option

You can have OfflineIMAP load up a Python file before evaluating the configuration file options that are Python expressions.  This example is based on one supplied by Tommi Virtanen for this feature.


In `~/.offlineimaprc`, he adds these options:

{% highlight ini %}
[general]
pythonfile=~/.offlineimap.py
[Repository foo]
foldersort=mycmp
{% endhighlight %}

Then, the `~/.offlineimap.py` file will contain:

{% highlight python %}
prioritized = ['INBOX', 'personal', 'announce', 'list']

def mycmp(x, y):
    for prefix in prioritized:
        xsw = x.startswith(prefix)
        ysw = y.startswith(prefix)
        if xsw and ysw:
            return cmp(x, y)
        elif xsw:
            return -1
        elif ysw:
            return +1
    return cmp(x, y)

def test_mycmp():
    import os, os.path
    folders=os.listdir(os.path.expanduser('~/data/mail/tv@hq.yok.utu.fi'))
    folders.sort(mycmp)
    print folders
{% endhighlight %}


This code snippet illustrates how the `foldersort` option can be customized with a Python function from the `pythonfile` to always synchronize certain folders first.

<!--
vim: ts=2 expandtab :
-->
