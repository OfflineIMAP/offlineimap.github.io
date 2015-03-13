---
layout: post
title: An history review
date: 2015-03-12 12:00
author: Nicolas Sebrecht
categories: community project
---
{% assign icon = site.data.icon %}
{% assign color = site.data.color %}


Let's take a step back!

OfflineIMAP started back in 2002 as a one-guy project, **John Goerzen**. He did all the hard work to start it from scratch, set up the public repository, the mailing list, packaging for debian, etc.

He continued to improve and maintain the source code until he retired in *May, 2010* in a well-written letter. Since then, OfflineIMAP had to survive of strong challenges...

<!--more-->

For the curious, here is the announce:

> Well folks, back in June of 2002, I made the first commit to the OfflineIMAP
> repo.  I never imagined I'd still be using it 8 years later.  After all, mail
> readers would get decent IMAP support soon, right?  right?
> 
> Well, despite all my attempts to stop using OfflineIMAP over the years, I
> failed repeatedly.  KMail added offline IMAP support, but it kept crashing and
> losing mail.  Thunderbird's didn't have a broad enough feature set.  Gnus was
> too slow, mutt didn't cache things and was slow, etc.
> 
> I have long considered OfflineIMAP "done", and haven't had time to work on it
> in a significant way in some time.
> 
> http://changelog.complete.org/archives/1463-moral-obligations-of-free-software-authors
> 
> In any case, I'm no longer using OfflineIMAP.  So it's time for me to retire
> from my maintainer hat -- something, incidentally, I've also tried and failed
> to do before (couldn't find someone to adopt it, or the person that did
> disappeared).  This time I'm not coming back even if that happens.
> 
> Thanks to all of you that sent patches, documentation, PayPal tips, words of
> thanks, even bug reports.  No thanks to all of you trying to make this thing
> talk to Exchange and bugging me when it didn't :-)
> 
> I know a lot of you like and use OfflineIMAP.  I'm glad of that; it's
> satisfying to have something I wrote out of an annoyance with mail readers
> find more broad use.
> 
> I would therefore like to do what I can to encourage the community to thrive
> better after my involvement than it did with it.  Suggestions on this are
> welcome, but here are some initial thoughts:
> 
> 1. OfflineIMAP is already on github.  There are already three forks. Perhaps
> some of these people would start acting as patch integrators.
> 
> 2. Github supports wikis (I have one on my OfflineIMAP github page) and issue
> trackers.  Someone could set those up.
> 
> 3. The community could agree on the "canonical" new home of OfflineIMAP.  The
> person maintaining it could then produce periodic tarballs, etc.
> 
> 4. When there is obvious consensus in the community and evidence of long-term
> stability, I will update all my links to point to the new home to give the
> project the greatest possible visibility.
> 
> 5. Some person or group could volunteer to admin this list.
> 
> Thoughts?
> 
> -- John


{: .note}
*Heh yes, **3 forks at Github at that time!***
To be fair, it was a recent move from another forge.

But despite the call, nobody actually took the maintenance of the software. *OfflineIMAP was discontinued.*


# A fresh new start

In November, 6 months after John's retired, I proposed to maintain the project. Things were so calm that **I expected few and heavy relaxed contributions**, merging patches from time to time. That's not exactly what was going to happen...

A few developers did improve their own fork, silently. They used public repositories but the improvements were sightly dispatched and disconnected.  When I came into the scene, people woke up and started sending their patches.

Once the initial burst of the pending patches merged, I expected things to calm down. Again, I did not realized how I much I could be wrong.

**I almost collapsed under the patches...** thanks to some active and productive developers. If you're not new to the project, you already know the most productive of them at that time: **Sebastian Spaetz**. I think the project never hit so much activity before which was a good thing.

We tried hard to improve and implement the features we wanted. Most have been done but some challenges failed, the biggest being setting up a good test suites despite the successive attempts.


# The test suites

With all those patches coming, I wanted more testers to involve.

{: .note}
OfflineIMAP never got a decent test suites. At that time there was no one.
At the time of this writing, this remains very limited and partial.

Testers volunteered but wanted a test suites. Testing latest improvements on their mails was obviously a no go. Few have set up a mailbox dedicated to the tests but nothing extraordinary.

**Sebastian started a test suites which I rejected**. The reason was that to my mind, the most hard bugs to fix were related to IMAP servers and network being not properly handled. It's really where we had to focus. For that matter, a test suites would have been almost pointless.

{: .warning}
Retrospectively, this is something I regret. Not that it would have been a good help for the purpose, but it could be helpfull today in other areas. I'm still *NOT* convinced that making high level tests are a good thing. But instead of rejecting the patches, I think I should have redirect the efforts.
Tests suites are better at tracking the low-level regressions. It might not be true for every projects but it is for OfflineIMAP which problems are IMAP servers and network craziness. Also, test suites are sightly slowing down the refactoring process due to the incident breakage occuring in the tests suites. Like it or not, it's a real deal for projects actively improved by few developers doing a lot of refactoring.
Anyway, redirecting the efforts into another direction would have been very beneficial for the long-term. I missed that opportunity.

{: .note}
We still have few issues like that today but the strongest got fixes.

**The idea I promoted was to use a IMAP Proxy of a IMAP server like Dovecot**. With such tool, it's possible to achieve wonderfull things like

- fake network latencies,
- fake network disconnections,
- fake limited bandwitdh,
- pause the process at any time, inspect and resume,
- etc...

The lone problem was that there was no such tool out there that could do the trick. So, I started a new project.

**I failed lamentably**. The main reasons are:

* My short-term goal was too much big,
* I did not share enough my WIP,
* I was more and more busy and starting such an ambitious project was not the good time.


# A new maintainer in the course

In the end of 2011, Sebastian began maintaining OfflineIMAP. I had to move home and at that time, things calmed down.

{: .note}
Up to the point that a regular developer asked if we did not left. :-)
We didn't. It was hard to find free time and I guess we were more or less tired from the *sprint* we started 2 years ago.

The good news is that I could more and more leave the project without impacting it. **This is how opening the maintenance started.**


# Needed a new deal

I the Mid of 2012, I did a new call for maintainers to join and initiated the transition to get the project more open. After very interesting discussions with the members of the mailing list, the consensus was clearly in favor of a team of official maintainers.

{: .note}
Today, I think **it was the best thing we did**.

In order to allow others to involve themselves, I created the organization at Github, the one we have today, *like suggested by one of the users*. Three developers joined. Everybody involved but only one does regular contributions since then. You know him, I'm talking about **Eygene Ryabinkin**.


# The current situation

We are officially 5 in the core team. In practice, **Eygene did all the work alone for 2 years, if not 3**.

{: .warning}
So yes, we are still open to new maintainers.

{: .note}
I am currently improving the documentation and introducing new docs for the maintainers. This is **NOT something hard to do** with good documentation. I hope this will help a bit.

# Conclusion

So, what about all of this?

Well, **OfflineIMAP was promised by some people to a *precarious future*.** Today, we can proudly explain this was wrong.

{: .warning}
**Since it started in 2002, it ran only around 6 months without a maintainer**. **During this period of apparent death, the software was still being improved by single developers.**
**OfflineIMAP is now 13 years old of continous releases and improvements!**


{: .note}
  {{ icon.note }} Big Thanks!!! {{ icon.end }}
  I'd like to catch the opportunity of this history review to thank everybody involved. Each did his best until now and I'm sure we will always do.

{:style='color:DarkBlue'}
***Thank you guys!***

<!--
vim: ts=2 expandtab spelllang=en :
-->
