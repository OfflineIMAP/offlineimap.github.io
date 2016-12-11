---
layout: page
title: Testing Offlineimap
date: 2016-12-11
author: Nicolas Sebrecht
---


* junk
{:toc}

---


## Requirements

Testers should be comfortable with:

- offlineimap
- git
- bug reporting

## Release cycles

All new patches are applied to the branch called `next` in the official
repository.

Once enough patches are merged and instead of releasing the next stable,
maintainers notify the testers that a new version will be released soon.  The
code is freezed for some time so that the testers can check the code and report
issues.

Some testers might rather make near from continous testing by checking almost
each patches. However, this way of working should be dedicated to the most
advanced users. If you don't know Python and can't recover from bad issues, you
should not blindly work on the `next` branch.

You should really read our [Git documentation]({{ site.url
}}/doc/GitAdvanced.html) once to get a good understanding of our way of working
with the official sources.


## Environment for the testers

In order to avoid any conflicts, offlineimap installations from ditribution
packages and other manual installations should be removed.

To avoid the pain of re-installing offlineimap you might like to run it from
your local git sources directly.

{:.warning}

To avoid most of the strongest issues, it's highly recommended to [correctly
backup offlineimap]({{ site.url }}/doc/backups.html).


## Other notes

Please, work in the open as much as possible. In rare cases, it's possible to
ping the maintainers directly so they can privately work on your issues. Notice
that some other trusted contributors might be requested to help, too.

A note to OSX / homebrew users: when you install offlineimap using the `--HEAD`
option, the head of the git repo gets installed - so testing is quite easy.


<!--
vim: expandtab ts=2 :
-->
