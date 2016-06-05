---
layout: post
title: "improving the policy about the imaplib2 library"
date: 2016-06-05
author: Nicolas Sebrecht
categories: development
---

{% assign links = site.data.links %}
{% assign icons = site.data.icons %}


Since John left the project, many users and contributors asked why imaplib2 (the
IMAP library) is packaged within offlineimap.

<!--more-->

* junk
{:toc}


In an ideal world, any Python dependency not in Python core is declared as
dependency and that's all. Pypi helps handling the dependencies.

In offlineimap, the main dependency is imaplib2. Since the early days, it is
packaged with offlineimap and I usually hear that users would benefice from
having imaplib2 packaged outside for mainly two reasons:

1. imaplib2 could be updated wihout updating offlineimap.
2. This would avoid code duplication.

While this makes sense at the first glance, I don't think this would benefit
most users.

### Code duplication?

Well, if you actually **install** any other software depending on imaplib2
**and** that you care about **92Ko** of disk space, then you might wonder about
this code duplication.

In real life, few other projects are using imaplib2. Most distributions don't
even package imaplib2.  In distributions packaging imaplib2, I'm not aware of
any other package depending on this library.

Code duplication is not a real issue. The distributions having strong policies
in this area are already doing the job of removing imaplib2 in our sources and
packaging it outside.

If imaplib2 were removed from our sources, I wonder that package maintainers
would not maintain it much wisely. They would not pay the attention it requires
because it's a small file and it's not widely used. They would likely spend
their time on other issues and more important packages.


### Updating imaplib2 only?

Hmm, let's get the full picture.

Offlineimap is built as a big wrapper on top of imaplib2. It is definetly very
tied to imaplib2. We don't diverge from upstream and we closely work with
upstream.  Offlineimap has always been shipped with imaplib2. Actually, imaplib2
is a one file library to allow bundling it like we do.

imaplib2 is moving slowly. At least, not as fast as offlineimap. Each time we
see a new version of imaplib2, we first check that the changes are fine and if
they are, we update it in our sources. When not sure, we integrate imaplib2 at
correct times in the release cycle so it can be tested enough and validate the
update. It already happened that imaplib2 was not updated or downgraded for good
reasons from our sources. Most users (and even distribution maintainers) don't
know when there are issues in imaplib2. Usually, they just pick a recent enough
version and use it.

Lot of changes in imaplib2 have been reported, initiated or even made by the
offlineimap contributors. I think we are in a good position to know which is the
best version of imaplib2 offlineimap should work with. This policy is working
well.

Removing imaplib2 would break historical assumptions that imaplib2 is bundled in
offlineimap.  This would not be an issue if all users knew how to handle Python
libraries correctly. I don't think this is the case. We could learn them how to
do this but I'm pretty sure most just don't care and don't want to care about
that.

Also, I know for sure that our users are used to download the tarball or simply
`git clone` and run `./offlineimap.py` directly. This is what we have everywhere
in our docs and what we request to do while helping and digging into issues. As
a maintainer, I like the idea of just downloading offlineimap and run it
directly.

{:.note}

Since v7.0.0-rc2, this statement is not true anymore. With the support for
Python 3, we made the choice to use the `six` dependency. We don't package it.
However, contrary to imaplib2, six is widely used and I expect that all the
distributions are packaging this library.

Finally, relying on an external imaplib2 would mean we would have to handle
different versions of imaplib2 in the code and the bug reports. This would be
much more additional work for our small team.


### The new policy

There's no way in my mind we would benefice from removing the bundled imaplib2.

However, we have ways to make the life easier for both the distribution
maintainers and users/developers wanting to play with other versions of
imaplib2.

This is why "superseding" the bundled imaplib2 version is now allowed.

Since v7.0.0-rc2, offlineimap imports a virtual imaplib2. This virtual library
is in charge of importing the real imaplib2. The policy is the following:

1. Try to load imaplib2 from the system (`PYTHONPATH`). If found, check that the
   version is allowed and recent enough and use it.

2. If not found or if the version is not allowed, load the bundled imaplib2.

{:.note}

Currently, the code allows ***any newer release***. I expect we will stick to
this policy.


### Official support

While loading and running a newer version than the bundled imaplib2 is allowed,
this does **not** mean this release is officialy supported for offlineimap.

{:.warning}

Actually, I decided we will only support offlineimap when it is using the exact
same version as the bundled version of imaplib2.

This is not an offense. As said previously, offlineimap is a big wrapper of
imaplib2 and there are assumptions in the code regarding imaplib2. This is
historical heritage and it's hard to get rid of this.


{:.DarkBlue}

With this new policy, I think we are reaching enough flexibility for those who
want/need it while still providing the best by default.
