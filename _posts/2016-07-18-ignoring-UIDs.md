---
layout: post
title: "how to ignore UIDs"
date: 2016-07-18
author: Nicolas Sebrecht
categories: configuration
---

{% assign links = site.data.links %}
{% assign icons = site.data.icons %}


When offlineimap is on trouble, it's now possible to ignore UIDs.

<!--more-->

* junk
{:toc}


### The copy_ignore_eval feature

If UIDs can't be correctly synced for whatever reason, it might be usefull to
ignore them. This allows to workaround issues or postpone a bug report.

{:.note}

This feature will be included in v7.0.0.

Here is the configuration file extract:

```
# This option stands in the [Repository RemoteExample] section.
#
# If offlineiamp is having troubles to download some UIDS, it's possible to get
# them ignored in a list. This only ignore the download.
#
# The function must return the list of UIDs (integers), None otherwise. It is
# passed the folder name (using the remote name with the remote separator,
# likely '/').
#
#copy_ignore_eval = lambda foldername: {'INBOX': [2, 3, 4]}.get(foldername)
```

The UID numbers to ignore are in a list which is mapped to the folder name.

### Output sample

```
Folder INBOX/sp&AOk-cial [acc: Test]:
 IGNORED: Copy message UID 2428 RemoteTest:INBOX/sp&AOk-cial -> LocalTest
```
