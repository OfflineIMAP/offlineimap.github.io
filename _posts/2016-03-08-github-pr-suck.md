---
layout: post
title: Why Github pull requests suck so hard
date: 2016-03-08
updated: 2016-03-09
author: Nicolas Sebrecht
categories: Github, pull requests
---

{% assign links = site.data.links %}
{% assign icons = site.data.icons %}

One thing that really irritates me at Github is the pull request feature.
**Almost all about this feature is done wrong.**

<!--more-->

* junk
{:toc}


### Signing the patches

Github offers no way to add your `Signed-off-by` line to the patches you merge
from the webapp. "Signing off" the patches at merge time is relevant information
and it means something. This is a rather common practice in communities.

{:.warning}

Not being able to signing off the patches on a merge is a pity.


### Managing pull requests

When a contributor sends a pull request it is stacked to the list of PR.

Tracking changes in this list is a pain. New pull requests since your previous
visit aren't highlighted. The list of pull request is lacking lot of features
like personal *prioritization, bookmarking, etc*.

{:.warning}

Expect to consume a lot of time only for managing your pull requests at Github.

{:.DarkBlue}

@Github: shared labels can't address everything.


### Notifications

The most important task before merging any change is the peer review. Skipping
this process is *very **very*** bad. Hence, proper notifications are critical.
However, the way Github has PR implemented is the best way for skipping it.

Email notifications are randomly served. Sometimes you'll get notifications,
sometimes not.

Online notifications are a bit better while the [notifications
page](https://github.com/notifications) happily mix everything.

The best workaround would be to associate an issue to each PR. Not very glorious
when you know it doesn't address all the points above and that it can't be
created automatically by enabling a configuration setting.

{:.warning}

Github notifications for PR are a joke.

{:.DarkBlue}

@Github, this issue is know for YEARS.


### Tracking changes

Contributors learn this soon. Getting changes merged upstream might require far
more than one shot. Hence, the first simplest feature one **needs** is to go
back and forth accross the different versions of the submissions. Comparing
revisions of the submissions is **required** to make a proper review.

{:.warning}

Forget about that. Github is in no help. It lacks the notion of **"topics"**.
What a pain, again.

{:.DarkBlue}

@Github: implementing topics (almost tags, BTW) for PR is so hard to implement?


### Inter-diffs

On top of this, the reviewing process is made much more easy when inter-diffs
are available. When working on a new submission, you usually only have the
previous submission in mind.  This is because that's where the most relevant
information stand. Also, it's a brain saver to work incrementally...

{:.warning}

Here again, Github won't help you. All provided diffs are against the base of
the changes. You have **no way** to get inter-diff generated for you easily.
While critical, it is missing.

{:.DarkBlue}

@Github: of course, when the basic pre-requisites to implement this feature are
missing (the notion of topics), no one will expect inter-diffs to become reality
one day or another.


### History deletions

This one is **big**. You can actually lose all your reviewing job. All comments
are **deleted** and **lost** if the sender erase the PR with another one having
the same branch name. 👏

I wonder if Github offers other ways to lose your job...

{:.warning}

Big thanks to Github for this one! Losing work is always a pleasure.


### Addressing PR to reviewers

When changing code, it's welcome to address the changes you wrote to the
original authors and the others contributors who made changes around yours. It's
easy to retrieve their name and emails with `git blame` or `tig blame` and cc'
them by mail. However, that's unhelpful with Github.

The best workaround would be to `@mention` the other contributors but this would
require you to know the nick names for all of them. This is not something you're
going to remember nor easily retrieve, really. Finally, the contributors won't
call for reviews.

Also, not everyone agree to use your service, Github. Thanks for considering
them, too.

{:.warning}

Hence, adressing a PR to the best reviewers is yet another true pain.

{:.DarkBlue}

@Github: why don't you provide a form when the user make a PR to send email
notifications, including those not subscribed?


### Granting reviewers and testers

When working in teams, it's important to grant the contributors for their work.
When it comes to reviewing, the standard way of doing so is by adding
`Reviewed-by`, `Acked-by` and the likes to the `Signed-off-by` lines.

{:.warning}

Github lacks a way to grant reviewers and testers.


### PR by email

What about hooks? I know so many organizations and maintainers out-there would
love to get the patches from pull requests automatically sent to their mailing
list. **This would FIX almost all of the above issues in ONE SHOT!**

{:.warning}

Github was requested for this feature FOR YEARS and never made the first step to
support it. Thank you.

{:.DarkBlue}

@Github: how long are you going to ignore the feedbacks of you users?


### Continous Integration

One thing Github has usefull is integration of third services. For example,
Travis CI greatly helps testing PR. What is missing is a way to append the
**commit message** with the success/failure information.

Also, people tend to rely on the tests blindly. However, having the tests pass
is not enough and won't replace peer review.


### Encouraging good practices

Contributors are willing to send pull requests with Github. *I'd even say some
users don't understand anymore why I'm in favor of sending patches by emails.*
The service supports the feature... Why not use it?

{:.warning}

Sending patches to the mailing list is still a best because Github support of PR
is **wrong by many ways**.

{:.DarkRed}

To go a bit further, I'd even say **the current implementation is a team
killer**. **If most users don't get the patches in their INBOX, they just won't
take the pain to provide reviews.**

Yes, I know. Github displays the commands to fetch the patches on the PR page.
**Do you really expect all the reviewers to connect, checkout each PR one by
one, execute those commands, checkout the changes locally, return online to the
pull request page and find all the relevant excepts to add comments?**

As a side effect, some long-term contributors get discouraged to provide
feedbacks and stop to provide reviews when they don't just leave the project.
While the **interactions between members are critical, Github's way of handling
pull requests will perversely turn down all the emulation of the community
members quickly. Fun is lost. Motivation gets lost.** A lot of contributors (not
comfortable with the provided process for reviews) will stop contributing soon.

> I am CERTAIN this is HOW we lost MOST of our OCCASIONAL but LONG-TERM
contributors. Still, NOBODY but the maintainer does code review in our projects.


{:.DarkBlue}

@Github: Thank you Github. Their feedbacks were very usefull and greatly
appreciated. While peer review was the norm is our community, it is completely
lost today.

> I'm aware of the integration services. No one can revamp the peer review
process correctly.


### Conlusion

{:.DarkRed}

**Working with PR and encouraging code reviews in teams is a nightmare with
Github©.**

Not using this feature at all is the best. You know why.

{:.warning}

Finally, removing the support for pull requests is not available. THAT SUCKS
HARD.

It's easy to understand why Github don't enable this feature. If you make your
repository public and people want to contribute, they will likely use the
integrated PR feature. Hence, you're almost forced to use Github if you don't
want to discard contributions for your project. IOW, publicing your project on
Github is far more than just open your work to the public: you have to connect
to the webapp or use whatever client at some point in time. In pratice, rather
often than occasionaly. **The more a maintainer will use a platform, the more
contributors feel the need of using it, too.** The result is that this strongly
increases the number of users for Github. **This is the real reason why we can't
disable PR. *You* are used as a *marketing promoter*. Not by what you could say,
but by what you actually DO.**

{:.DarkBlue}

@Github: is there no other way to convince new users to sign up to your website
than almost **forcing maintainers** to accept PR in their public repositories?

**One day or another, we will move away from github. This will be for good
reasons.**

Feel free to join the chat and provide your point of you!
