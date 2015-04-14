---
layout: post
title: Why we've changed maxage
date: 2015-04-14
author: Janna Martl & Nicolas Sebrecht
categories: devel
---

{% assign icons = site.data.icons %}

*(Change introduced in OfflineIMAP v6.5.7)*

As a maintainer, there are features I'm more confident about than others. This is especially the case when it's about code that has been there for a long time that had few issues for years.

When **Janna Martl** raised issues with maxage, introduced in August 2009, it really came as a surprise...

<!--more-->

...much better, she dug into the root cause and explained to us what was wrong. But before going further, let's see how it worked.


## How maxage used to work

The point of maxage is to only sync "recent" messages.

Here's how this feature came in:

> Subject: [PATCH] Patch to provide maxage and maxsize account options to exclude old/large messages
> 
> This is designed to make offlineimap even better for low bandwidth connections.
> 
> maxage allows you to specify a number of days and only messages within
> that range will be considered by offlineimap for the sync.  This can be
> useful if you would like to start using offlineimap with a large
> existing account and do not want to import large archives of mail.
> 
> [...]
> 
> In both cases the cachemessagelist function of the folder was modified to ignore
> messages that do not meet the criteria.  If the criteria are not specified
> then the existing code will be executed the same as before.  If a message
> does not meet the criteria it will be as though this message does not exist
> - offlineimap will completely ignore it.  It will not have flags updated,
> it will not be deleted, it will not be considered at all.
> 
> When operating against an IMAP repository a server side search function
> is used.  This of course requires support for server side search.
> 
> I have tested this with either option, no options etc. against IMAP, Maildir
> and Gmail.  I have run variations of this patch here for the last 3 weeks or
> so syncing about 4 accounts normally.

So instead of considering all mail, we only consider mail that is newer than a given date.

Before any sync, we cache (in RAM) the lists of messages to consider for the sync. When we want to apply a partial sync, we exclude the messages we don't want from this cache. In order to apply maxage, we exclude the mails with dates before maxage.

With simple comparisons of both lists of mails, we know what we have to do to sync the flags, add new mails and remove those deleted. Internally, we know a mail was deleted when it's missing from one of the cached lists.


### The glitches

> Subject: maxage causes loss of local email
>
> I use the maxage setting, and for a long time I've noticed that every
> day, a random subset of mail of age maxage + 1 gets deleted locally
> (but not on the remote server). I think I've found the cause:
>
> [...]
>
> Janna Martl

The problem? We were retrieving the list of local messages from N days ago, and the list of remote messages from N days ago, but "N days ago" meant something different in each case. For messages on the IMAP server, we calculated age based on IMAP internaldate, as defined by the RFC. For messages in a Maildir, we calculated age using a timestamp in the filename, and that timestamp was set as the current time when the message was downloaded.

So, even if the two repositories contained the same messages, the lists of messages we were syncing did not always match each other. Some mails could wrongly be kept in cache for the Maildir while excluded from the remote: if a message was sent a long time ago but downloaded recently, it would be seen as "recent" by the Maildir (hence kept in cache) and "old" by the IMAP server (hence excluded from the list of messages to consider). As a consequence, some mails was could **appear** as deleted on the remote server, hence the deletion in the Maildir.

{:.warning}
Notice that there is no loss of data. The mails wrongly deleted in the Maildir are still on the IMAP server.


## The fix

So, Janna fixed this by setting and getting the date and time correctly for Maildir messages: instead of using the download time, she set a local message's timestamp to be the internaldate of its remote counterpart.

{:style='color:DarkRed'}
*This is a good improvement, but still not enough!*


### Heh, yes but what about timezones?

Janna found another issue. While testing the fix she discovered that **Gmail uses local timezones** for the internal date. So, we were computing the dates against UTC while the IMAP server computed the internal date against a random timezone. *Sigh!*

{:style='color:DarkRed'}
It turns out that there is no way to figure out what timezone the remote server is using, and we quicky understood there was almost nothing we could do but very hackish fixes. We were stuck trying to compute the correct lists of messages to consider for a sync...


## Revisiting the whole logic

The solution? Well, in OfflineIMAP **we usually work with UIDs!** And that's what we used to re-design maxage.

The idea is the following: we can't specify the starting point for local and remote message lists as a specific date, because that date will be interpreted differently on each side depending on timezones. But if we request local and remote messages starting at a specific UID, that's unambiguous. That UID should be the minimum UID of messages in the desired date range. So the strategy is as follows:

1. Retrieve local messages within the date range.
2. Find the minimum UID min_uid of these messages.
3. Retrieve local messages with UID >= min_uid.
4. Retrieve remote messages with UID >= min_uid.

{:style='color:DarkBlue'}
In other words, we compute a starting UID based on maxage, first. Once the starting UID is known, proceed by considering all mails on both sides with UIDs greater than or equal to that starting UID.

{:.note}
{{ icons.note }} Note {{ icons.end }}
Step 3 is necessary because of edge cases: it's possible to have messages A and B, where A's internaldate is before B's internaldate, but A has a larger UID than B. This could happen e.g. if a message is copied to the server behind offlineimap's back.

{:style='color:DarkRed'}
*This works well, in theory.*


### Yet another issue!

At this point, Janna found that for IMAP/IMAP configurations, **messages on one server might be in a different order (with respect to UIDs) than the corresponding messages on the other server**. When we upload mails in a defined order, they might be assigned UIDs in a different order.

{:style='color:DarkRed'}
This makes behaviour of maxage **unpredicable** for IMAP/IMAP and we could do nothing about that while simply relying on what the IMAP protocol provides.


## Partially removing maxage

Hence, I decided to *partially* remove maxage:

> Since the order of UIDs won't match the order of the sending, we are
> wrong to try to apply the min(UID) logic to the IMAP/IMAP and IMAP/Gmail
> cases. I didn't know that. Actually, I was expecting UIDs to be assigned
> in a more predictive way.
> 
> IOW, it appears that:
> 
> 1. Strictly relying on internal date is not reliable.
> 
> 2. Strictly relying on UID ranges is not reliable.
> 
> 3. Relying on both internal date and UID ranges as given by the remote
>    servers, whatever the logic we apply and how we mix both information, is
>    simply not reliable.
> 
> 4. IMAP protocol does not provide anything else that could help for the
>    purpose.
> 
> As a consequence to all of these, it appears that applying maxage in the
> IMAP/IMAP or IMAP/Gmail cases is WRONG. We are far beyond implementation
> issues. It's BROKEN BY DESIGN. We should NOT have supported this thing at
> all in the first place.
> 
> 
> Unless someone PROVES me that I'm wrong, I'm in favour to forbid the
> maxage feature outside the case of a local Maildir.


### The proposed alternative

This is where Janna started to design an alternative to maxage for IMAP/IMAP.

Let's welcome `startdate`, a new configuration option. It is desgined for IMAP/IMAP setups only. It is a replacement for maxage but has its own limitations.

For the same reasons we couldn't keep maxage, it was not possible to provide a strict equivalent wihout much more advanced (and intrusive) strategy. `startdate` will work with a **fixed date** and requires the remote server to be empty on the first sync.

This is all we could come with, for now.


## Conclusion

I think there's not much to add. We faced a lot of edge-cases and surprising behaviour.

The good news is that I'm much more confident in maxage now than before. Thanks to the UIDs, the sync logic is much more reliable.

{:style='color:DarkBlue'}
Thanks to Janna who put a lot of effort into fixing maxage!

<!--
vim: ts=2 expandtab spelllang=en :
-->

