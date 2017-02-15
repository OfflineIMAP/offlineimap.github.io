---
layout: page
title: Making backups
author: Nicolas Sebrecht
date: 2015-03-15
updated: 2016-12-11
---
{% assign icons = site.data.icons %}


{: .note}
{{ icons.note }} Don't trust your Mail provider? Don't trust yourself? {{ icons.end }}
  Whatever's the reason, you're right at wanting backups for your own mails.

{: .note}
{: .DarkBlue}
  This is a common use case of OfflineIMAP but it's too often badly done. *So, here is how to do it properly.*


{: .warning}
If you're already comfortable with OfflineIMAP, there is one last thing your must really understand.
 
Syncing your mail with OfflineIMAP and having a local copy is not enough. The reason is that you'll have to start a sync each time you want to update the backups. The trick is that **this operation might erase EVERYTHING that has already been synced.**
 
*For example, if the IMAP server respond that your mailbox is empty, OfflineIMAP will have no clue to know if it's right or wrong. It will propagate the changes to your local copy so that you get an empty Maildir. What you thought was a "backup" has vanished, you're stuck.*


* junk
{:toc}

---

## Atomic backups

Offlineimap relies on a local cache. It is expected to keep track of the cache
alongside the maildir to have good backups.

Depending on the backup backend, it might be required to move the cache to
another path (e.g.: to store both the cache and the maildir in the same
filesystem).


## Setting up a backend

There are many ways to set up a backend that will serve at providing a history of backups. Chose your own, but take one at least.

The idea is just about having an history available in case of damage. It's then your job to make a little script that will make a new history. We will see how to integrate it with OfflineIMAP so that it's done on each sync.

* **Filesystem snapshots**

  Snapshoting at filesystem level is the best because the Maildir format allows really fast snapshots (< 1s) with very few disk usage overhead.
  If you don't have a free partition on a hard drive, create a new file to write the filesystem. In this case the performance is not the best.

  > This is the recommended method.

* **Content trackers**

  Content trackers are not as effective as filesystems. They have a bigger disk usage overhead because they will save the files in their own database.
  Though, it's a good alternative if you don't have a free partition and want the best performance while working on your mails. The time of the "snapshot" should be quite equivalent in most cases.

* **Network archiver**

  Not the easiest way but probably the more secure. In fact, it will mean you have 3 copy: one hosted by the provider, one in your local system, last on the remote system.

  {: .warning}
  Be care though to **ALWAYS keep an history**. Syncing first with OfflineIMAP and then blindly syncing with rsync, for example, is still **wrong**.

* **Archives**

  Finally, there's always the possiblity to save the Maildir in archives. It's slow and has the biggest disk usage overhead, but it still works.


## Snapshots

### Filesystems

#### Create a new filesystem in a file

*TODO*

#### LVM

*TODO*

#### BTRFS

*TODO*

#### ZFS

  Optional:
  Generate a *zfs* mountpoint dedicated to your Mails:
  {% highlight bash %}
  $ zfs create zroot/usr/home/$USER/Mail 
  {% endhighligt %}

  To create a snapshot (with a date as the seed) you can run:
  {% highlight bash %}
  $ zfs snapshot zroot/usr/home/$USER/Mail@$(date +%Y%m%d%H%M%S)offlineimap
  {% endhighligt %}

  Of course you need to point your 'localfolders' to a subdirectory of the zfs mountpoint you are generating a snapshot of. 

  Now you can easily wrap your offlineimap command with a failsafe like that:
  {% highlight bash %}
  #!/bin/sh
  zfs snapshot zroot/usr/home/$USER/Mail@$(date +%Y%m%d%H%M%S)offlineimap
  # append your commandline options as needed to the script
  offlineimap $\*
  {% endhighligt %}

*TODO*:
 Implement as offlineimap hook

### Content trackers


#### Git

*TODO*

### Network syncer

#### Rsync

*TODO*

### Archives

#### tarballs

*TODO*


## OfflineIMAP integration

*TODO*



<!--
vim: expandtab ts=2 :
-->
