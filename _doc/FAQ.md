---
layout: page
title: Frequently Asked Questions
date: 2006-12-02
author: John Goerzen
contributors: Nicolas Sebrecht, Sebastian Spaeth, Daniel Shahaf, Vladimir Marek, Eygene Ryabinkin
updated: 2016-07-06
---

{% assign links = site.data.links %}
{% assign icons = site.data.icons %}
{% assign no_maxconnections = site.baseurl | append: "/configuration/2016/01/29/why-i-m-not-using-maxconnctions.html" %}


<!--
NOTE TO CONTRIBUTORS: Please add new questions to the correct section.
-->

Most recent [FAQ]({{ site.baseurl }}/doc/FAQ.html).

If you don't get hints here, feel free to ask in our chat room, our [mailing
list]({{ links.mailing_list.address }}) or search in [the archives]({{
links.mailing_list.archives }}).


* junk
{:toc}

---


## General

### Where do I get offlineimap?

See the information at the [project homepage]({{ links.offlineimap.project }}).


### How fast is it?

Offlineimap has a multithreaded sync, so it should have very nice performance.

{:.warning}
{{ icons.warning }}{{ icons.end }}
The `maxsyncaccounts` and `maxconnections` options are deprecated. [Learn why](
{{ no_maxconnections }}).

A good way to experiment is by setting `maxsyncaccounts = 3` and `maxconnections
= 3` in each account clause.  This lets offlineimap open up multiple connections
simultaneously. That will let it process multiple folders and messages at once.
In most cases, this will increase performance of the sync.

Don’t set the number too high. If you do that, things might actually slow down
as your link gets saturated. Also, too many connections can cause mail servers
to have excessive load. Administrators might take unkindly to this, and the
server might bog down. There are many variables in the optimal setting;
experimentation may help.

See the `Synchronization Performance` section in the `offlineimap(1)` man page
for some tips.


### What platforms does offlineimap support?

It should run on most platforms supported by Python, with one exception: we do
not support Windows, but some have made it work there.

The following has been reported by offlineimap users. We do not test offlineimap
on Windows, so we can’t directly address their accuracy.

The basic answer is that it’s possible and doesn’t require hacking offlineimap
source code. However, it’s not necessarily trivial. The information below is
based in instructions submitted by *Chris Walker*:

> First, you must run offlineimap in the Cygwin environment. The Windows
> filesystem is not powerful enough to accomodate Maildir by itself.
>
> Next, you’ll need to mount your Maildir directory in a special way. There is
> information for doing that at [barnson.org](http://barnson.org/node/295). That site gives this example:
>
    mount -f -s -b -o managed "d:/tmp/mail" "/home/of/mail"
>
> That URL also has more details on making offlineimap work with Windows.


### Does offlineimap supports XDG Base Directory specification?

Yes. We are trying to use `$XDG_CONFIG_HOME/offlineimap/config` as the primary
configuration file, falling back to `~/.offlineimaprc` if configuration file
location was not explicitely specified at the command line.


### Does offlineimap support mbox, mh, or anything else other than Maildir?

Not directly. Maildir was the easiest to implement. We are not planning to write
an mbox-backend, though if someone sends well-written mbox support and pledged
to support it, it would be committed it to the tree.

However, offlineimap can directly sync accounts on two different IMAP servers
together. So you could install an IMAP server on your local machine that
supports mbox, sync to it, and then instruct your mail readers to use the
mboxes.

Or you could install whatever IMAP server you like on the local machine, and
point your mail readers to that IMAP server on localhost.


### What is the UID validity problem for folder?

IMAP servers use a folder UIDVALIDITY value in combination with a unique ID
(UID) to refer to a specific message.  This is guaranteed to be unique to a
particular message forever.  No other message in the same folder will ever get
the same UID as long as UIDVALIDITY remains unchanged.  UIDs are an integral
part of offlineimap's synchronization scheme; they are used to match up messages
on your computer to messages on the server.

Sometimes, the UIDs on the server might get reset.  Usually this will happen if
you delete and then recreate a folder.  When you create a folder, the server
will often start the UID back from 1.  But offlineimap might still have the UIDs
from the previous folder by the same name stored. Offlineimap will detect this
condition because of the changed UIDVALIDITY value and skip the folder.  This is
GOOD, because it prevents data loss.

In the *IMAP/Maildir* case, you can fix it by removing your local folder and
cache data.  For instance, if your folders are in the metadata path `~/Mail` and
the folder with the problem is `INBOX`, you'd type this:

{% highlight bash %}
$ mkdir ~/archives
$ mv ~/Mail/INBOX ~/archives
$ mv ~/.offlineimap/Account-AccountName/LocalStatus-sqlite/INBOX ~/archives/LocalStatus-sqlite-INBOX
$ mv ~/.offlineimap/Repository-RemoteRepositoryName/FolderValidity/INBOX ~/archives/FolderValidity-INBOX
{% endhighlight %}

{:.note}
If you're using the plain text backend, change the above `LocalStatus-sqlite` to
`LocalStatus-`.
 
Of course, replace `AccountName` and `RemoteRepositoryName` with the names as
specified in `~/.offlineimaprc`.

{:.warning}
{{ icons.warning }} Do move the directory {{ icons.end }}
from the metadata path (`~/Mail` in this sample). **There
should be NO MORE `INBOX` directory in it.**
 
The reason is that moving it like this means like *"I've never synced this
folder before, download it on next sync"*.

Next time you run offlineimap, it will re-download the folder with the new UIDs.

Some IMAP servers are broken and do not support UIDs properly.  If you continue
to get this error for all your folders even after performing the above
procedure, it is likely that your IMAP server falls into this category.

Offlineimap is incompatible with such servers.  It will not destroy any mail,
but at the same time, it won't actually synchronize it either. Offlineimap will
detect this condition and abort prior to synchronization.

{:.note}
This question comes up frequently. See the [mailing list archive]({{
links.mailing_list.archives }}).  You can find a [detailed discussion of the
problem](http://lists.complete.org/offlineimap@complete.org/2003/04/msg00012.html.gz).


### How do I automatically delete a folder?

Offlineimap does not currently provide this feature. You will have to delete
folders manually. See next entry too.


### May I delete local folders?

#### Prior to v7.0.0

Offlineimap does a two-way synchronization.  That is, if you make a change to
the mail on the server, it will be propagated to your local copy, and
vise-versa.

Some people might think that it would be wise to just delete all their local
mail folders periodically. Offlineimap will take this as an intentional
deletion of many messages and will interpret your action as requesting them to
be deleted from the server as well.  (If you don't understand this, don't worry;
you probably won't encounter this situation.)

#### After v7.0.0

Starting with v7.0.0, offlineimap won't delete emails if the **directory** is
removed. Instead, it will re-download the folder. In order to remove all the
emails of a folder, it is necessary to remove all the **files *inside* **the
maildir.

To prevent from any deletion, it's possible to set the `sync_deletes = no`
configuration option. See details in `offlineimap.conf`.


### Can I run multiple instances?

Yes. Offlineimap prevents any attempt to sync the same account over different
instances.

Actually, this is the prefered way for syncing more than one account
concurrently. Learn more [in this blog post]({{ no_maxconnections }}).


### Can I copy messages between folders?

Normally, when you copy a message between folders or add a new message to a
folder locally, offlineimap will just do the right thing.  However, sometimes
this can be tricky ― if your IMAP server does not provide the SEARCH command, or
does not return something useful, offlineimap cannot determine the new UID of
the message.  So, in these rare instances, offlineimap will upload the message
to the IMAP server and delete it from your local folder.  Then, on your next
sync, the message will be re-downloaded with the proper UID.  Offlineimap makes
sure that the message was properly uploaded before deleting it, so there should
be no risk of data loss.

But if you try to sync between two IMAP servers, where both are unable to
provide you with UID of the new message, then this will lead to infinite loop.
Offlineimap will upload the message to one server and delete on second. On next
run it will upload the message to second server and delete on first, etc.


### Does offlineimap support POP?

No.


### How is offlineimap conformance?

* Internet Message Access Protocol version 4rev1 (IMAP 4rev1) as specified in [RFC 3501](https://www.ietf.org/rfc/rfc3501.txt).
* CRAM-MD5 as specified in [RFC 2195](https://www.ietf.org/rfc/rfc2195.txt).
* Maildir as specified in the Maildir manpage and the qmail website.
* Standard Python 2.7+ as implemented on POSIX-compliant systems.


### Can I force offlineimap to sync a folder right now?

Yes:

1) if you use the `Blinkenlights` UI.  That UI shows the active accounts as
follows::

    4: [active]      *Control: .
    3: [  4:36]      personal:
    2: [  3:37]          work: .
    1: [  6:28]           uni:

Simply press the appropriate digit (`3` for `personal`, etc.) to resync that
account immediately.  This will be ignored if a resync is already in progress
for that account.

2) While in sleep mode, you can also send a `SIGUSR1`. See the `UNIX signals`
section in the `offlineimap(1)` man page for details.


### I get a "Mailbox already exists" error

**Q:** When synchronizing, I receive errors such as:

     Folder 'sent'[main-remote] could not be created. Server responded:
     ('NO', ['Mailbox already exists.'])

**A:** IMAP folders are usually case sensitive. But some IMAP servers seem to
treat "special" folders as case insensitive (e.g. the initial `INBOX.` part, or
folders such as `Sent` or `Trash`). If you happen to have a folder `sent` on one
side of things and a folder called `Sent` on the other side, offlineimap will
try to create those folders on both sides. If you server happens to treat those
folders as case-insensitive you can then see this warning.

You can solve this by excluding the `sent` folder by filtering it from the
repository settings:

{% highlight ini %}
folderfilter = lambda f: f not in ['sent']
{% endhighlight %}


## Configuration Questions

### Can I synchronize multiple accounts with offlineimap?

Of course!

Just name them all in the accounts line in the general section of the
configuration file, and add a per-account section for each one.

You can also optionally use the `-a` option when you run offlineimap to request
that it only operate upon a subset of the accounts for a particular run.


### How do I specify the names of folders?

You do not need to. Offlineimap is smart enough to automatically figure out what
folders are present on the IMAP server and synchronize them. You can use the
folderfilter and nametrans configuration file options to request only certain
folders and rename them as they come in if you like.

Also you can configure offlineImap to only synchronize "subscribed" folders.


### How do I prevent certain folders from being synced?

Use the folderfilter option. See `offlineimap.conf` for details.


### What is the mailbox name recorder (mbnames) for?

Some mail readers, such as mutt, are not capable of automatically determining
the names of your mailboxes. Offlineimap can help these programs by writing the
names of the folders in a format you specify. See `offlineimap.conf` for
details.


### Does offlineimap verify SSL certificates?

You can verify an imapserver's certificate by specifying the CA certificate on a
per-repository basis by setting the `sslcacertfile` option in the config file.
(See the example `offlineimap.conf` for details.) If you do not specify any CA
certificate, you will be presented with the server's certificate fingerprint and
add that to the configuration file, to make sure it remains unchanged.  No
verification happens if connecting via STARTTLS.


### How do I generate an `sslcacertfile` file?

The `sslcacertfile` file must contain an SSL certificate (or a concatenated
certificates chain) in PEM format.  (See the documentation of
[ssl.wrap_socket](http://docs.python.org/library/ssl.html#ssl.wrap_socket)'s
`certfile` parameter for the gory details.)  You can use either openssl or
gnutls to create a certificate file in the required format.

#### via openssl:

{% highlight bash %}
$ openssl s_client -CApath /etc/ssl/certs -connect ${hostname}:imaps -showcerts | perl -ne 'print if /BEGIN/../END/; print STDERR if /return/' > $sslcacertfile
^D
{% endhighlight %}

#### via gnutls:

    {% highlight bash %}
    $ gnutls-cli --print-cert -p imaps ${host} </dev/null | sed -n '/^-----BEGIN CERT/,/^-----END CERT/p' > $sslcacertfile
    {% endhighlight %}

The path `/etc/ssl/certs` is not standardized; your system may store SSL
certificates elsewhere.  (On some systems it may be in
`/usr/local/share/certs/`.)

Before using the resulting file, ensure that openssl verified the certificate
successfully. In case of problems, you can test the certificate using a command
such as (credits to *Daniel Shahaf* for this) to verify the certificate:

    {% highlight bash %}
    $ openssl s_client -CAfile $sslcacertfile -connect ${hostname}:imaps 2>&1 </dev/null
    {% endhighlight %}

If the server uses STARTTLS, pass the `-starttls` option and the 'imap' port.

Also, you can test using gnutls:

{% highlight bash %}
$ gnutls-cli --x509cafile certs/mail.mydomain.eu.cert -p 993 mail.mydomain.eu
{% endhighlight %}


### IMAP Server Notes

In general, offlineimap works with any IMAP server that provides compatibility
with the IMAP RFCs. Some servers provide imperfect compatibility that may be
good enough for general clients. Offlineimap needs more features, specifically
support for UIDs, in order to do its job accurately and completely.


### Client Notes

#### What clients does offlineimap work with?

Any client that supports Maildir. Popular ones include mutt, Evolution and
KMail. Thunderbird does not have maildir suppport.

With offlineimap’s IMAP-to-IMAP syncing, this can be even wider; see the next
question.

#### Evolution

Offlineimap can work with Evolution. To do so, first configure your offlineimap
account to have `sep = /` in its configuration. Then, configure Evolution with
the “Maildir-format mail directories” server type. For the path, you will need
to specify the name of the top-level folder inside your offlineimap storage
location. You’re now set!

#### KMail

At this time, I believe that offlineimap with Maildirs is not compatible with
KMail. KMail cannot work in any mode other than to move all messages out of all
folders immediately, which (besides being annoying and fundamentally broken) is
incompatible with offlineimap.

However, I have made KMail version 3 work well with offlineimap by installing an
IMAP server on my local machine, having offlineimap sync to that, and pointing
KMail at the same server.

Another way to see mails downloaded with offlineimap in KMail (KDE4) is to
create a local folder (e.g. Backup) and then use `ln -s
localfolders_in_offlineimaprc ~/.kde/share/apps/kmail/mail/.Backup.directory`.
Maybe you have to rebuild the index of the new folder. Works well with KMail
1.11.4 (KDE4.x), offlineimap 6.1.2 and ArchLinux and `sep = /` in
`.offlineimaprc`.

#### Mutt

##### Do I need to use "set maildir_trash"?

Other IMAP sync programs require you to do this. Offlineimap does not. You’ll
get the best results without it, in fact, though turning it on won’t hurt
anything.

##### How do I set up mbnames with mutt?

The example offlineimap.conf file has this example. In your `offlineimap.conf`,
you’ll list this:

{% highlight ini %}
[mbnames]
enabled = yes
filename = ~/Mutt/muttrc.mailboxes
header = "mailboxes "
peritem = "+%(accountname)s/%(foldername)s"
sep = " "
footer = "\n"
#incremental = no
{% endhighlight %}

Then in your `.muttrc`:

{% highlight ini %}
source ~/Mutt/muttrc.mailboxes
{% endhighlight %}


You might also want to set:

{% highlight ini %}
set mbox_type=Maildir
set folder=$HOME/Maildirpath
{% endhighlight %}


## Advanced questions

### How to migrate of IMAP server?

The procedure is quite the same as [making a backup]({{ site.base
}}/doc/backups.html) and [restore it]({{ site.base }}/doc/backups-restore.html).


## Miscellaneous Questions

### I'm using git to install offlineimap and found these branches called "master", "maint", "next" and "pu". What are they?

To be brief:

* **master**: classical mainline branch.
* **next**: this is the branch for recent merged patches. Used for testing offlineimap.
* **pu** ("proposed updates"): patches not ready for inclusion. This should **never** be checkouted!
* **maint**: our long-living maintenance branch. We maintain this branch (security and bugfixes) for users who don't want or can't upgrade to the latest release.

For more information about the branching model and workflow, see [Git
Advanced]({{ site.base }}/doc/GitAdvanced.html#git-branching-model).


### Why are your Maildir message filenames so long?

Offlineimap has two relevant principles:

1. Never modifying your messages in any way.
2. Ensure 100% reliable synchronizations.

In order to do a reliable sync, offlineimap must have a way to uniquely identify
each e-mail.  Three pieces of information are required to do this: your account
name, the folder name, and the message UID. The account name can be calculated
from the path in which your messages are. The folder name can usually be as
well, BUT some mail clients move messages between folders by simply moving the
file, leaving the name intact.

So, offlineimap must store both a message UID and a folder ID. The folder ID is
necessary so offlineimap can detect a message being moved to a different folder.
Offlineimap stores the UID (U= number) and an md5sum of the foldername (FMD5=
number) to facilitate this.


### What can I do to ensure offlineimap is still running and hasn’t crashed?

This shell script will restart offlineimap if it has crashed. Sorry, its written
in Korn, so you’ll need ksh, pdksh, or mksh to run it:

{% highlight bash %}
#!/bin/ksh
# remove any old instances of this shell script or offlineimap
for pid in $(pgrep offlineimap)
do
  if  $pid -ne $$
  then
    kill $pid
  fi
done

# wait for compiz (or whatever) to start and setup wifi
sleep 20
# If offlineimap exits, restart it
while true
do
  ( exec /usr/bin/offlineimap -u Noninteractive.Quiet )
  sleep 60 # prevents extended failure condition
{% endhighlight %}


## Contributing

### How to test offlineimap?

We don't have well testing tool, for now. As an IMAP client, we need an
available IMAP server for that purpose. But it doesn't mean you can do anything.

Recent patches are merged in the `next` branch before being in the mainline.
Once you have your own copy of the official repository, track this `next`
branch:

{% highlight bash %}
$ git checkout -t origin/next
{% endhighlight %}

Update this branch in a regular basis with:

{% highlight bash %}
$ git checkout next
$ git pull
{% endhighlight %}

Notice you're not supposed to install offlineimap each time. You may simply run
it like this:

{% highlight bash %}
$ ./offlineimap.py
{% endhighlight %}

The choice is up to you. :-)


### How to submit a patch?

Read the [documentation for contributors](/documentation.html#documentation-for-contributors).

<!--
vim : ts=2 expandtab :
-->
