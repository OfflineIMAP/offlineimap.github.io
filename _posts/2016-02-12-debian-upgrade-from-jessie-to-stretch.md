---
layout: post
title: A tale of FMD5 (or upgrading offlineimap from 6.3.4 to 6.6.1)
date: 2016-02-12
author: François Joulaud
categories: configuration
---

{% assign icons = site.data.icons %}
{% assign visible_name_commit = "https://github.com/OfflineIMAP/offlineimap/commit/6b2ec956cfe8e356d3ffd54eee34773deb73279f" %}
{% assign FAQ152 = "http://docs.offlineimap.org/en/latest/FAQ.html#id32" %}

While upgrading my Debian machine from jessie to stretch, offlineimap
was upgraded from 6.3.4 to 6.6.1 and it had a unexpected effect in my
case.

<!--more-->

## Initial configuration and decision to upgrade

I saw the big warning in the Debian NEWS file about the "nametrans" change :

      Reverse nametrans
        +++++++++++++++++
    
        Starting with v6.4.0, OfflineImap supports the creation of folders
            on the remote repostory. This change means that people that
            only had a nametrans option on the remote repository
            (everyone) will need to have a nametrans setting on the local
            repository too that will reverse the name transformation.
    
        For further information, see documentation about this feature at:
    
          file:///usr/share/doc/offlineimap/html/nametrans.html#reverse-nametrans


But after reading carefully the linked documentation my configuration
seemed to be Ok. To be clear my configuration includes the following
snippets.

For Local repositories:
{% highlight python %}
    folderfilter = lambda foldername: foldername.startswith("localprefix.")
    nametrans = lambda foldername: trans_local(foldername, "localprefix")
{% endhighlight %}

For Remote repositories:
{% highlight python %}
    nametrans = lambda foldername: trans_remote(foldername, "localprefix")
{% endhighlight %}

which use those functions
{% highlight python %}
    def trans_local(foldername, prefix):
        if foldername.startswith(prefix):
            return foldername.replace(prefix+".","",1)
        else:
            #raise AssertionError("config of nametrans with prefix '"+prefix+"' is not good")
            return "notfound_"+prefix+"_"+foldername

    def trans_remote(foldername, prefix):
           return prefix+"."+foldername
{% endhighlight %}

## The unexpected effect

So far so good.

I upgrade, modify the completely unrelated ssl parameters, and just
wait for my automatic mail process (I have offlineimap in a crontab)
to continue business as usual.

And I wait, and I wait, and after some time I just wonder what the
hell offlineimap is doing. And I found out that it was completely
re-uploading all my mails. I have some accounts with more than 5G of
mails and with the crappy connexion I had, it took forever.

I stopped offlineimap, deactivated all my crontabs and investigated
the problem.

I think that the problem comes from the use of nametrans in
visiblename for Maildir folder (commit [Apply nametrans to all
Foldertypes]({{visible_name_commit}})) because it leads to change the
[FMD5 part]({{FAQ152}}) of the filename calculated by offlineimap.

Offlineimap thus believed that I removed all my mails and added it
back. With no way for it to detect it was the same mails. It then
reuploaded all the "new" mail before deleting all the "old" mail which
is really inefficient.

My problem was exactly the inverse of the one in [this blog post](https://kdecherf.com/blog/2015/09/12/how-not-to-migrate-emails-between-gmail-accounts/).

## How I avoided to do some reupload.

Once the problem was understood I came up with a workaround which seems to work.
The principle is to rename all filenames with the new expected name (with the new calculated md5sum) by offlineimap in
concerned Maildirs.

With my setup I used this dirty hack in shell :

{% highlight bash %}
    MYPREFIX=localprefix
    for box in $HOME/Maildir/${MYPREFIX}.* ; do
        cd $box
        oldmd5=$(pwd | sed 's!.*/!!' | tr -d '\n' | md5sum | sed 's/ *-$//')
        newmd5=$(pwd | sed "s!.*/!!;s!^${MYPREFIX}\.!!" | tr -d '\n' | md5sum | sed 's/ *-$//')
        for dir in cur new ; do
            rename -v "s/FMD5=${oldmd5}/FMD5=${newmd5}/" ${dir}/* ;
        done
    done
{% endhighlight %}

Note that this only works if done after the last use of offlineimap
6.3.4 and before the first use of offlineimap 6.6.1. If done at other
moments I think we risk loss of mails and duplicates of mails.


I opened one [Debian bug](http://bugs.debian.org/812108) on this
matter and wait for any idea to work up this upgrade cleanly.
