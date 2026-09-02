---
layout: post
title: How OfflineIMAP Works
date: 2012-08-27 12:00
author: ezyang
categories: community project
updated: 2026-09-02
---
{% assign icons = site.data.icons %}

Reposted from: [blog](https://blog.ezyang.com/2012/08/how-offlineimap-works/).  License: CCC BY-SA 3.0.

As software engineers, we are trained to be a little distrustful of marketing copy like this:

<!--more-->

* junk
{:toc}

> OfflineIMAP is SAFE; it uses an algorithm designed to prevent mail loss at all costs. Because of the design of this algorithm, even programming errors should not result in loss of mail. I am so confident in the algorithm that I use my own personal and work accounts for testing of OfflineIMAP pre-release, development, and beta releases.

What is this algorithm? Why does it work? Where is the correctness proof? Unfortunately, no where in OfflineIMAP’s end user documentation is the algorithm described in any detail that would permit a software engineer to convince himself of OfflineIMAP’s correctness. Fortunately for us, OfflineIMAP is open source, so we can find out what this mysterious algorithm is. In fact, OfflineIMAP’s synchronization algorithm is very simple and elegant. (Nota bene: for simplicity’s sake, we don’t consider message flag synchronization.)

### Preliminaries

Define our local and remote repositories (Maildir and IMAP, respectively) to consist of sets over messages L and R. In a no-delete synchronization scheme, we would like to perform some set of operations such that end states of the repositories L’ and R’ are L ∪ R.

However, no-delete synchronization schemes work poorly for email, where we would like the ability to delete messages and have those changes be propagated too. To this end, OfflineIMAP defines a third repository called the status repository, also a set over messages, which says whether or not a message has been synchronized in the past without an intervening synchronized delete. There are now seven possible states for a message to have, based on which repositories it is a member:

![image](/assets/img/blog/state-space.png)

Considering all possible combinations:

*   **Synchronized** (L,R,S): The message is fully synchronized and needs no further processing.
*   **New Local** (L): The message was newly added to the local repository and needs to be uploaded.
*   **New Remote** (R): The message was newly added to the remote repository and needs to be downloaded.
*   **Status Missing** (L,R): The message is synchronized but our status is out-of-date.
*   **Remote Removed** (L,S): The message was synchronized, but since then was removed from the remote; it should now be removed from local.
*   **Local Removed** (R,S): The message was synchronized, but since then was removed from the local; it should now be removed from remote.
*   **Missing** (S): The message has been deleted everywhere and our status has a stale entry for it.

The green-shaded region of the Venn diagram is what we would like L, R and S to cover at the end of synchronization.

### Algorithm

Define a synchronization operation on a source, destination and status repository `syncto(src, dst, status)` to be these two steps:

1.  Calculate the set difference `src - status`, and copy these messages to `dst` and `status`.
2.  Calculate the set difference `status - src`, and delete these messages from `dst` and `status`.

The full synchronization algorithm is then:

1.  `syncto(R, L, S)` (download changes)
2.  `syncto(L, R, S)` (upload changes)

### How it works

In the absence of crashes, the correctness proof only involves verifying that the status repository invariant (that messages in status have been synchronized in the past without an intervening synchronized delete) is preserved over all four operations, and that the set differences are, in fact, precisely the sets of messages we want to copy and delete. However, we can also try and look at how the local, remote and status repositories change as the algorithm progresses. In particular, the contents of the status repository in the first `syncto` is slightly surprising as it evolves differently from `local`, despite having the same operations applied to it (it then evolves in lockstep with `remote`).

![image](/assets/img/blog/normal.png)

Another important correctness claim is that OfflineIMAP never “loses mail”. Under what conditions is mail deleted? When it is present in status repository, but not in the local or remote repository. So it is easy to see that when the status repository is “lost” (either corrupted, or deleted as the instructions tell you to if you delete the contents of your local folders), OfflineIMAP will conservatively perform a full, no-delete synchronization between the two sources. So long as the status repository never contains data for more messages than it ought to, OfflineIMAP will not delete your mail.

### Variations

Suppose that I have more disk space available on local disk for Maildir than my remote IMAP server. Eventually, you will end up in the awkward position of wanting to delete messages from your remote IMAP server without correspondingly nuking them from your local mail store. OfflineIMAP provides the `maxage` option (in which OfflineIMAP refuses to acknowledge the existence of messages older than some sliding window), but what if we _really_ wanted to be sure that OfflineIMAP would never ever delete messages from my local repository?

Simple: Skip step 1-2.

![image](/assets/img/blog/asymmetric.png)

### Conclusion

By utilizing a third repository, for which data loss results in a _conservative_ action on the part of the program, OfflineIMAP achieves its claims of _an algorithm designed to prevent mail loss at all costs_. It is also a simple algorithm, and I hope that any computer scientist or software engineer using this software will take the time to convince themselves of its correctness, rather than relying on the hearsay of some marketing material.

Converted by [chris001](https://github.com/chris001).
