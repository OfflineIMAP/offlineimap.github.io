---
layout: post
title: "tracking regressions"
date: 2016-07-29
author: Nicolas Sebrecht
categories: development
---

{% assign links = site.data.links %}
{% assign icons = site.data.icons %}


Four days after v7.0.0 and v6.7.0.2, I've had to release v7.0.1 and v6.7.0.3.
One day later it was for v7.0.2. Again, I intend a v7.0.3 soon. Something gone
wrong, obviously.

<!--more-->

* junk
{:toc}


### The release cycle

Our release cycle is efficient and quite standard. Once a stable is out, we
expect the release candidates (`-rcN`). The more we move ahead, the more the
maintainers apply bug fixes only. This helps fixing most of the bugs in the new
features and fixing the regressions. Once the code stabilize, the stable is
tagged.


### Oops, this failed

For the v7.0.0, I did not think I'll have to tag little bugfix releases soon
after. And for sure not more than once.

{:.DarkRed}
So, what happened?

{:.DarkRed}
It appeared users did not help to test out the late candidates. Years ago, we had
offlineimap enthusiasts running the latest releases, including the intermediate
candidates. Some even used to work on the `next` development branch. They were
doing a fucking good job at either fixing of reporting issues.

Lately, it looks like we've "lost" most of them. At least, this "team" of
testers stopped to track on new patches and latest release to try and see. As a
result, the v7.0.0 was not stable enough while I've strictly applied the same
release cycle policy.


### Imagine yourself the maintainer

How we work is simple. Code changes as we move forward by applying patches. You
*(the maintainer)* feel it's time to stabilize the code. So, you release a
candidate and let the time go. At the rhythm of feedbacks you fix some issues
and postpone the stable until all are fixed.

{:.note}
Side note: as a maintainer, you're a tester too. You're fixing the issues you
find.

{:.DarkRed}
But this time, you get very FEW to NO feedback at all.

This might mean too things:

1. The users did not found issues. That's good. It means you should release the
	 stable.

2. No users are testing your job. You're out of luck. If you release a stable,
	 you'll likely release a crappy version.

This is what happened for this v7.0.0.

IOW, the implicit contract broke. We make our best to write code and test but we
*can't* do all of the job. **We just can't try our own code in the wild and see
if this work for all the possible options and servers out there.**

{:.DarkBlue}
We used to have enthusiasts. For whatever reasons, most are gone. I suspect some
left because they felt not usefull anymore at some point in time.


### Responsability is shared, somewhat

From my point of view, nobody can expect offlineimap to "magically" work without
any issue for each and new release if few contributors help. We are a small
community. We *do* rely on you.

The implicit contract is that if nobody test the code, a crappy stable will get
out despite our good will. By installing and using it, you're finally doing the
job that was not done before, in late.  No one is comfortable when this happen.
Users tend to not trust us. Maintainers work in a hurry to fix issues.
Reputation decrease.


### A call for enthusiasts

**Join us!**

- We have a "testers" team in Github. By joining, your profile can be publicly
	linked to the OfflineIMAP organization (at your own preference).
- I can add you in the copy list of the emailed announces when requested.
- We try to take care to credit you when you report issues with your real name.
- You're wining close proximity to the hard core team. Your own issues become
	priority because we know we can trust you: you're learning or you already know
	how to make proper bug reports. You'll be one of the rare people we are
	willing to provide real *private support* to fix or enhance your environment.

That's teamwork we enjoy.

{:.DarkBlue}
You're reading this blog post. You might be subscribed to the RSS feed or you're
subscribed to the mailing list in order to be aware of what's happening.  I know
you could be one of them. ,-)

{:.note}
Drop me a note that you're willing to test releases. The more I know about your
environemnt and configuration, the more you'll help. Let me know if I can
request you on demand. Provide both negative and positive feedbacks, *especially
for late candidates*.

Contrary to wrong belief, it's not very harmful to your precious emails. There
are ways to prevent from hard issues:

1. We make backups. E.g., I use a script that takes care to snapshot the
	 (dedicated) filesystem of both my mails and the local cache, prior to any
	 sync.

2. When we try a new version, we first try on non-critical accounts.

As one of the hard core testers, I've never had to restore a backup because of
breakage. The internal design of offlineimap is robust. I don't pretend this
will never happen. I observe this didn't happen for now. Also, since I'm used to
test, I've setup a reliable environment like above for all my accounts.

*The side effect is that I'm prepared in case of troubles on my most precious
accounts, too. Probably more than the common offlineimap user. Not because I'm a
developer or a maintainer. Only because all the environment is up and ready in
case of strong issue.* ,-)
