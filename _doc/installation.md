---
layout: page
title: Installation
date: 2011-01-15
author: Nicolas Sebrecht
contributors: Sebastian Spaeth
updated: 2015-03-15
---
{% assign links = site.data.links %}


* junk
{:toc}

---


## Prerequisites

In order to use [OfflineIMAP]({{ links.offlineimap.project }}), you need to have these conditions satisfied:

1. Your mail server must support **IMAP**. Mail access via POP is not supported. A special Gmail mailbox type is available to interface with Gmail's IMAP front-end, although Gmail has a very peculiar and non-standard implementation of its IMAP interface.

2. You must have **Python version 2.7 or above** installed.  If you are running on Debian GNU/Linux, this requirement will automatically be taken care of for you.  If you intend to use the SSL interface, your Python must have been built with SSL support.

3. If you use OfflineIMAP as an IMAP <-> Maildir synchronizer, you will obviously need to have a mail reader that supports the Maildir mailbox format.  Most modern mail readers have this support built-in, so you can choose from a wide variety of mail servers.  This format is also known as the "qmail" format, so any mail reader compatible with it will work with OfflineIMAP.


## Installation

Installing OfflineIMAP should usually be quite easy, as you can simply unpack and run OfflineIMAP in place if you wish to do so. There are a number of options though:

- [installation via your distribution package manager](#distribution)
- [installation from a tarball or zipball](#ball)
- [installation with git](#git)


{: #distribution}
### System-Wide installation via distribution

The easiest way to install OfflineIMAP is via your distribution's package manager. OfflineIMAP is available under the name `offlineimap` in most Linux and BSD distributions.


{: #ball}
### Installation from tarball or zipball

Download the latest archive from the [download page]({{ links.offlineimap.downloads }}).

Unpack and continue with the [system-wide](#system-wide) or [single-user](#single-user) installation.


{: #git}
### Installation with git

Get your own copy of the [official git repository]({{ links.offlineimap.repository }}).

{% highlight bash %}
$ git clone {{ links.repository }}
{% endhighlight %}

This will download the source with history. By default, git sets up the `master` branch up, which is most likely what you want. If not, you can checkout a particular release like this:

{% highlight bash %}
$ cd offlineimap
$ git checkout v6.5.6
{% endhighlight %}

You have now a source tree available. Proceed with either the [system-wide](#system-wide) or [single user](#single-user) installation.


### System wide and single user installation

{: #system-wide}
#### System-wide installation

Then run these commands, to build the python package:

{% highlight bash %}
$ make clean
$ make
{% endhighlight %}

Finally, install the program (as root):

{% highlight bash %}
$ python setup.py install
{% endhighlight %}

Next, proceed to below.  Type `offlineimap` to invoke the program.


{: #single-user}
#### Single-user installation

Download the git repository as described above. Instead of installing the program as root, you type `./offlineimap.py`; there is no installation step necessary.

> That's it. Have fun without OfflineIMAP!


## Uninstall

If you installed a system-wide installation via `python setup.py install`, there are a few files to purge to cleanly uninstall OfflineIMAP again. Assuming that `/usr/local` is the standard prefix of your system and that you use python 2.7, you need to:

### Delete the OfflineIMAP installation itself:

{% highlight bash %}
/usr/local/lib/python2.7/dist-packages/offlineimap-6.4.4.egg-info
/usr/local/lib/python2.7/dist-packages/offlineimap
{% endhighlight %}

In case, you did the single-user installation, simply delete your offlineimap directory.

### Delete all files that OfflineIMAP creates during its operation.

- The cache at `~/.offlineimap` (default)
- The configuration file `~/.offlineimaprc` (default)

It is possible that you created those in different spots.


<!--
vim: ts=2 expandtab
-->
