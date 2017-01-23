---
layout: page
title: How to restore a backup
date: 2015-03-19
author: Nicolas Sebrecht
---

{% assign icons = site.data.icons %}
{% assign colors = site.data.colors %}


* junk
{:toc}

---

{: .warning}
{{ icons.warning }} Be care {{ icons.end }}
It's good practice to start by making **yet another backup of both the Maildir and the cache**, before anything else.

The best way to restore a backup is to start from a clean *"empty"* state.


## Clean the cache

The cache stands in the path defined by the `metadata` configuration option. By default it's `~/.offlineimap`.

The cache files depends on you cache settings:
- `plain`, for plain text
- `sqlite`

All have a name in the from `Account-<account_name>`. Delete them all for the `<account_name>` you want to restore.


## Clean the Maildir

Move the maildir directory to `<maildir>.old` and create a fresh new empty maildir directory.

{% highlight bash %}
$ mv <maildir> <maildir>.old
$ mkdir <maildir>
{% endhighlight %}


## Make a new fresh sync

It's now time to perform a first sync. This will download all the mails of the remote server and write a fresh cache.


## Restore the backup

### Locally, first

Then, copy the content (your raw mails) from the backup to the fresh Maildir.

{: .note}
{{ icons.note }} Note: {{ icons.end }}
Compare the trees between the backup and the fresh Maildir before restoring the mails. Especially if you are restoring onto another IMAP server.
 
The trees must match or you'll have to manually restore the content in a per-folder basis.


### On the remote

Finally, sync again. The local mails are synced back to the server.

{: .note}
{{ icons.note }} Note: {{ icons.end }}
Don't forget to set `readonly = False` on the remote side.


{:style='color:DarkBlue'}
***You're done!***


<!--
vim: expandtab ts=2 :
-->
