---
layout: post
title: imapfw is made public
date: 2015-10-08
author: Nicolas Sebrecht
categories: development
---
{% assign icons = site.data.icons %}


I'm publishing **imapfw**, a new IMAP tool which I intend to replace OfflineIMAP. ,-)

<!--more-->

Some months passed since my previous announce to make a deep refactoring of OfflineIMAP. While doing this job, I realized it was something very hard and it would be better to write a new software. That's what I'm currently doing and it's called [imapfw](https://github.com/OfflineIMAP/imapfw).

{:.note}
This tool won't do much for now. This is still in very early development stage.

{:.warning}
Because it's **WORK IN PROGRESS** and **EXPERIMENTAL** stuff, it won't make anything good. Expect it to have strong failures.


## Introduction

Here are the main goals I have in mind for imapfw:

* use the last Python 3 technologies;
* clean and beautifull code;
* easily extensible;
* fully *(aggressively?)* concurrent;
* fit the needs to both novice and experts;
* support **a lot** of use cases;
* safe and with integrated tests;
* fucking good documentation;
* IDLE mode? I'm still not sure about this one.

Believe me, those goals altogether are very ambitious.

That's why I decided to make imapfw a **framework** *(hence the name imap**fw**)* which I want both **simple** and **powerfull**.

Beginners shouldn't be scared, though. All the framework architecture only requires *ONE* file which is called the **rascal**. It won't require the user to write one line of Python code.


## A call for feedbacks

I'm publishing this tool today in order to get your feedbacks. Any constructive comment is always welcome but keep it in mind this is WIP, please!

Also, feel free to give your opinion about anything.

### Users of OfflineIMAP

Since I intend imapfw to replace OfflineIMAP in the long term, you might want to follow the development and give your feedbacks. My best guess is that you will mostly be interested by the [**rascal**](https://github.com/OfflineIMAP/imapfw/tree/next/rascals): how it looks, is it hard, etc.

### Developers

This call for feedbacks is mostly for you! Please, do fork the project and read a bit of code. Early feedbacks about code are very important.

I don't expect patches, for now. However, let me know if you'd like to contribute soon. I'll share more about what I have in mind.


## How it looks

A good start is to fork the project and look at the CLI options:

{% highlight bash %}
$ ./imapfw.py -h
{% endhighlight %}

The main argument is the `ACTION`. It tells what imapfw must do. I've started the implementation of the most expected feature: `syncAccounts`. For now, it won't sync anything and you can run it safely.

### The rascal

Here's an extract of the [rascal](https://github.com/OfflineIMAP/imapfw/tree/next/rascals):

{% highlight python %}

__VERSION__ = 0.1


##########
# GLOBAL #
##########

#
# The main configuration options are set in this dict.
#
MainConf = {
    'concurrency_backend': 'multiprocessing',
    'max_sync_accounts': 2,
}


from imapfw.api import actions, engines, controllers, types, drivers
# Support for contributor's backends. ,-)
#from imapfw.api import contrib


################
# REPOSITORIES #
################

ImapExampleConf = {
    'dns':      'imap.gmail.com',
    'port':     '143',
    'username': 'myname',
    'max_connections': 2,
}

MaildirExampleConf = {
    'path': '~/Maildir',
    'max_connections': 2,
}

class MaildirRepositoryExample(types.Maildir):

    conf = MaildirExampleConf
    driver = drivers.Maildir # Default: drivers.Maildir.


class ImapRepositoryExample(types.Imap):

    conf = ImapExampleConf
    driver = ImapDriverExample # Default: drivers.Imap.

    def _getPassword(self):
        return self.conf.password

    def credentials(self):
        return self.conf.username, self._getPassword()

    def search(self, server, uid_list, conditions):
        title = mail.getTitle()

        if title.startswith('spam'):
            mail.deleteRemote('deleting spam')

        if title.startswith('offlineimap'):
            mail.setTitle("filtered: %s"% title)
            mail.moveTo('INBOX.offlineimap') # IMAP MOVE.

        return # Continue proceeding to the folder.

    def getFolders(self):
        return ['sample', 'of', 'static', 'remote', 'folder', 'list']



############
# ACCOUNTS #
############

class AccountExample(types.Account):
    left = MaildirRepositoryExample
    right = ImapRepositoryExample

    # Optional. The folders considered for a sync.
    # Arguments:
    # - folder_list: list of folder names to sync.
    # Returned values: the new list of folders to sync.
    def syncFolders(self, foldersList):
        return ['folderA', 'folderB', 'folderC']

{% endhighlight %}

* The first thing to notice is that configuration options are simple dictionnaries. Forget the INI style. I aim simple users to not have to write ONE line of Python code.
* OfflineIMAP users should feel comfortable reading this file. It follows almost the same semantic and the same logic around **accounts**.
* Most experienced users will notice the classes. Here is the hierarchy and how
  they are logically linked:
  * an account is defined (derivates from `types.Account`) with both left and right "repositories".
  * a "repository" *(I'm about to fully remove this term)* maps to a configuration dictionary and a driver to actually access it. It derivates from the associated type (`types.Maildir`, `types.Imap`, etc) and the drivers are similar (`drivers.Maildir`, `drivers.Imap`, etc).

On top of this, each **type** acts as a controller for the underlying driver. I expect experimented users to make most of their *crappy* things here. Think about filtering folders, translating, etc. ,-)

How everything is linked is important: it's possible to decide what type uses which driver for what account.


Now, look at the imports:

{% highlight python %}
from imapfw.api import actions, engines, types, drivers
{% endhighlight %}

* **actions** are the actions available from the command line.
* **engines** allows to define the default engine to use for the action (if this action supports more than one engine). It can be redefined at the CLI!
* **types** are the little sisters of the OfflineIMAP's repositories: Maildir, Imap, Gmail, etc, in the sense they hold a driver and some configuration options *(like the credentials)* to access it.
* **drivers** are the low-level drivers to use for the types (didn't exist in OfflineIMAP).

The imports are what makes the framework so powerfull. They allow the user to **redefine** some methods, or even write their own full new backends.

Because actions, engines, types and drivers are well orthogonal and seperated concepts, extending imapfw should be much easier than it was with OfflineIMAP.

## A brief introduction about imapfw's internals

Internally, there are other implementation concepts that some of you might like to be aware of. The most important are the **concurrency**, the **workers** and the **managers**.

The **concurrency** is a module to use a single and very simple API whatever the Python backend in use (`multiprocessing` or `threading`). Yes, I'm aware they are already very similar but they still have some subtil differences it's better to avoid introducing in the long run. We force using a subset of them.

Because the conccurency backend is easily switchable, **worker** is a simple term to refer to either a process (`multiprocessing`) or a thread (`threading`).

The **managers** are objects to nicely handle concurrency. It takes inspiration from the managers of the `multiprocessing` library. They allow to have an intuitive usage for the "passing by message" design.


## Final note !

It's time for me to write the last words. I'd rather let you to discover imapfw more in details by yourself.

This post is long enough for today! Also, I ddin't sleep this night to polish the code, publissh it and write this bloog post. I hope nobody have noticcce.... :-D


<!--
vim: ts=2 expandtab spelllang=en :
-->
