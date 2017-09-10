---
layout: page
title: Making backups with BTRFS snapshots
author: Yuri Volchkov
date: 2017-09-10
updated: 2017-09-10
---
{% assign icons = site.data.icons %}
* **Install snapbtr**

There is a number of different helpers for the automatic snapshoting a
btrfs volume. Assuming that we want to create a snapshot __before__
offlineimap syncs it's data, the best place to call such a tool is
hook scripts.

But almost all these helpers require root permission, which is not
acceptable for us (unless you are running offlineimap as root).

The snapbtr fits this requirement. It separates creating snapshots (no
root needed) from cleaning-up (root required).

To install, follow the instructions on
the [project page](https://github.com/yvolchkov/snapbtr#Install)

* **Create a workspace**

This approach requires serveral components. Let's keep them together
in one folder

{% highlight bash %}
mkdir ~/email && cd ~/email
{% endhighlight %}

* **Prepare the storage**

{% highlight bash %}
touch btrfs.vol
truncate -s 20G btrfs.vol
mkfs.btrfs btrfs.vol
mkdir store
mkdir btrfs-root
sudo mount btrfs.vol  btrfs-root/
sudo btrfs subvolume create btrfs-root/email
sudo mount btrfs.vol store/ -o subvol=email
# It is very important to change the owner! Otherwise snapbtr would not
# be able to create snapshots
sudo chown yuri:yuri btrfs-root/ -R
mkdir btrfs-root/snapshots
{% endhighlight %}

In this setup, the "store" folder is inteded to keep your
Maildir(s). So you would need to provide the path to it in your
~/.offlineimaprc file. For example:

{% highlight ini %}
[Repository gmail_local]
type = GmailMaildir
localfolders = ~/email/store/your_account@gmail.com
{% endhighlight %}


{: .warning}
IMPORTANT: if you already had offlineimap configured with this
account, you need to check if your offlineimap version is newer then
7.0.0. Or there is a high risk of wiping your emails on the __server__.
Check the  [FAQ](/doc/FAQ.html#may-i-delete-local-folders) for more details.

* **Setup the hook**

Create a script

{% highlight bash %}
cat > make_snapshot.sh <<EOF
#!/bin/bash
snapbtr -s $HOME/email/store $HOME/email/btrfs-root/snapshots
EOF

chmod +x make_snapshot.sh
{% endhighlight %}

And, finally add the path to the hook script into your
~/.offlineimaprc file into the Account section. For example:

{% highlight ini %}
[Account gmail]
localrepository = gmail_local
remoterepository = gmail_remote
status_backend = sqlite
presynchook = ~/email/make_snapshot.sh
{% endhighlight %}

{: .note}
{{ icons.note }} 
In this example we used offlineimap's hook. However there are other
options, because offlineimap is just an email fetcher, and usually
there are more applications in the final email stack. For example, if
you are using [notmuch](https://notmuchmail.org/), much better way to
make your snapshots would be using its "pre-new" hook. This way you
will be backuping not only offlineimap's data, but notmuch's database
as well.
