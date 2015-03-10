---
layout: page
title: Some real use cases
---


# Sync from GMail to another IMAP server

This is an example of a setup where "TheOtherImap" requires all folders to be under INBOX:

{% highlight ini %}
[Repository Gmailserver-foo]
#This is the remote repository
type = Gmail
remotepass = XXX
remoteuser = XXX
# The below will put all GMAIL folders as sub-folders of the 'local' INBOX,
# assuming that your path separator on 'local' is a dot.
nametrans = lambda x: 'INBOX.' + x

[Repository TheOtherImap]
#This is the 'local' repository
type = IMAP
remotehost = XXX
remotepass = XXX
remoteuser = XXX
#Do not use nametrans here.
{% endhighlight %}


# Sync from Gmail to a local Maildir with labels

This is an example of a setup where GMail gets synced with a local Maildir.  It also keeps track of GMail labels, that get embedded into the messages under the header configured in the labelsheader setting, and syncs them back and forth the same way as flags. This is particularly useful with an email client that indexes your email and recognizes the labels header, so that you can sync a single "All Mail" folder, and navigate your email via searches.

The header used to store the labels depends on the email client you plan to use.  Some choices that may be recognized by email clients are X-Keywords (the default) or X-Labels. Note that if you need to change the label header after the labels have already been synced, you will have to change the header manually on all messages, otherwise offlineimap will not pick up the labels under the old header.

The first time OfflineIMAP runs with synclabels enabled on a large repository it may take some time as the labels are read / embedded on every message.  Afterwards local label changes are detected using modification times, which is much faster:

{% highlight ini %}
[Account Gmail-mine]
localrepository = Gmaillocal-mine
remoterepository = Gmailserver-mine
synclabels = yes
# This header is where labels go.  Usually you will be fine
# with default value (X-Keywords), but in case you want it
# different, here we go:
labelsheader = X-Keywords

[Repository Gmailserver-mine]
#This is the remote repository
type = Gmail
remotepass = XXX
remoteuser = XXX

[Repository Gmaillocal-mine]
#This is the 'local' repository
type = GmailMaildir
{% endhighlight %}

There are some labels, that gmail treats in a special way. All internal gmail labels start with "\\". Those labels include:

- \\Drafts
- \\Important
- \\Inbox
- \\Sent
- \\Junk
- \\Flagged
- \\Trash

You can add and remove those labels locally, and when synced, will have special actions on the gmail side. For instance, adding the label `\Trash` to an email will move it to the trash, and be permanantly deleted after some time. This is relevant, since gmail's IMAP prevents from removing messages from the "All Mail" folder the usual way.


# Selecting only a few folders to sync

Add this to the remote gmail repository section to only sync mails which are in
a certain folder:
{% highlight python %}
folderfilter = lambda folder: folder.startswith('MyLabel')
{% endhighlight %}

To only get the All Mail folder from a Gmail account, you would e.g. do:

{% highlight python %}
folderfilter = lambda folder: folder.startswith('[Gmail]/All Mail')
{% endhighlight %}


# Another nametrans transpose example

Put everything in a GMX. subfolder except for the boxes INBOX, Draft,
and Sent which should keep the same name:

{% highlight python %}
nametrans: lambda folder: folder if folder in ['INBOX', 'Drafts', 'Sent'] \
                          else re.sub(r'^', r'GMX.', folder)
{% endhighlight %}

# 2 IMAP using name translations

Synchronizing 2 IMAP accounts to local Maildirs that are "next to each other", so that mutt can work on both. Full email setup described by Thomas Kahle at <http://dev.gentoo.org/~tomka/mail.html>.

`offlineimap.conf`:

{% highlight ini %}
[general]
accounts = acc1, acc2
maxsyncaccounts = 2
ui = ttyui
pythonfile = ~/bin/offlineimap-helpers.py
socktimeout = 90

[Account acc1]
localrepository = acc1local
remoterepository = acc1remote
autorefresh = 2

[Account acc2]
localrepository = acc2local
remoterepository = acc2remote
autorefresh = 4

[Repository acc1local]
type = Maildir
localfolders = ~/Mail/acc1

[Repository acc2local]
type = Maildir
localfolders = ~/Mail/acc2

[Repository acc1remote]
type = IMAP
remotehost = imap.acc1.com
remoteusereval = get_username("imap.acc1.net")
remotepasseval = get_password("imap.acc1.net")
nametrans = oimaptransfolder_acc1
ssl = yes
maxconnections = 2

# Folders to get:
folderfilter = lambda foldername: foldername in [
             'INBOX', 'Drafts', 'Sent', 'archiv']

[Repository acc2remote]
type = IMAP
remotehost = imap.acc2.net
remoteusereval = get_username("imap.acc2.net")
remotepasseval = get_password("imap.acc2.net")
nametrans = oimaptransfolder_acc2
ssl = yes
maxconnections = 2
{% endhighlight %}

One of the coolest things about OfflineIMAP is that you can call arbitrary python code from your configuration.  To do this, specify a pythonfile with:

{% highlight python %}
pythonfile = ~/bin/offlineimap-helpers.py
{% endhighlight %}

Here is a basic content sample:

{% highlight python %}
import commands

def get_password(account_name):
  cmd = "security find-internet-password -w -a '%s'"% account_name
  (status, output) = commands.getstatusoutput(cmd)
  return output
{% endhighlight %}

From this sample, replace the cmd line with whatever can retrieve your password.  Your pythonfile needs to contain implementations for the functions that you want to use in offflineimaprc.  The example uses it for two purposes: Fetching passwords from the gnome-keyring and translating folder names on the server to local foldernames.

An example implementation of get_username and get_password showing how to query gnome-keyring is contained in <http://dev.gentoo.org/~tomka/mail-setup.tar.bz2>.

The folderfilter is a lambda term that, well, filters which folders to get. The function `oimaptransfolder_acc2` translates remote folders into local folders with a very simple logic. The `INBOX` folder will have the same name as the account while any other folder will have the account name and a dot as a prefix. This is useful for hierarchichal display in mutt.

Offlineimap handles the renaming correctly in both directions:

{% highlight python %}
import re
def oimaptransfolder_acc1(foldername):
    if(foldername == "INBOX"):
        retval = "acc1"
    else:
        retval = "acc1." + foldername
    retval = re.sub("/", ".", retval)
    return retval

def oimaptransfolder_acc2(foldername):
    if(foldername == "INBOX"):
        retval = "acc2"
    else:
        retval = "acc2." + foldername
    retval = re.sub("/", ".", retval)
    return retval
{% endhighlight %}

<!--
vim: ts=2 expandtab :
-->
