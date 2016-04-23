---
layout: post
title: "Our GSoC 2016 with Gentoo"
date: 2016-04-23
author: Nicolas Sebrecht
categories: GSoC2016
---

{% assign links = site.data.links %}
{% assign icons = site.data.icons %}

A sad story.

<!--more-->

* junk
{:toc}


### The GSoC

Basically, the process is quite simple. Everybody follows the official
timeline provided by Google.

1. Students submit proposals based on their own ideas or the ideas provided in
	 the public ideas page of the organization. Proposals describe their expected
	 contributions for the project during summer.

2. Once the deadline for submitting proposals is reached, the mentors in the
	 organization rank the proposals and the organization admins request slots to
	 Google.

3. Google allocates a number of slots for the projects to the organizations.
	 Next, the admin allocates the slots to the projects for their org.


### Why Gentoo?

That's easy. They have been my first contact. Also, this was my first experience
in the GSoC program and since I've had a warm welcome from the admins, I decided
to rely on experienced people.

Relying on an organization applying to the GSoC for several years would avoid us
some administrative tasks and allow us to learn how it's done.

{:.DarkBlue}

I was aware that there are other organizations. After all, if joining Gentoo was
incongruous they would have warned me about that.


### Time for Google to select the orgs

{:.DarkBlue}

Later, I discovered that it's not so obvious. *For example, admins at Gentoo are
having a hard time at motivating mentors to apply to the GSoC.*

{:.note}

Having a good ideas page is definetly relevant for the org to be accepted by
Google.


I've been surprised by the number of mentors/projects waiting for the
organization to be accepted by Google before they decide to join. Not all came
lately because of good reasons. **There was 6 late projects for a total of 23.
This is more than 1/4!** The main org admin said most came lately by "pure
laziness". I tend to agree with him on that.


### The ranking

Each mentor has been requested to rank all the proposals before April 3rd to the
dashboard provided by Google:

* 0: Invalid proposal.
* 1: Bad, I absolutely do not want this student with us this year.
* 2: Not good enough, we should not accept this student.
* 3: OK
* 4: Very good, we should accept this student.
* 5: Excellent, we absolutely have to have this student this year.

The deadline for requesting slots to Google was April 11. During this reviewing
period, we are requested to communicate with the students and the other mentors.

Ranking is not so easy. This is mainly about the proposal but there are other
criteria to consider like the student interactions, the feedbacks from the other
mentors, the effective contributions, etc.

This is a real job and I think all the mentors did their best to rank the
proposals.

So far so good. We got the final results before the deadline requested by
Google. Here are the notations for the 7 best proposals, ranked in
order:

{:.DarkBlue}

| Notation |          | Mentors     |
| -------- |:--------:|             |
| 4.14     | *imapfw* | *2 mentors* | *(Abdó and me)* |
| 4.125    | gentoo   | 1 mentor    |
| 4        | *imapfw* | *2 mentors* | *(Abdó and me)* |
| 3.89     | gentoo   | 1 mentor    |
| 3.59     | gentoo   | 4 mentors   |
| 3.56     | gentoo   | 2 mentors   |
| 3.5      | gentoo   | 1 mentor    |

This table is mine. We were asked to rank on the dashboard so it's easy to
calculate the averages.

Notice that since we are new to the GSoC, the org admin decided to allocate 1
slot at most to imapfw. This was clear since the beginning. Later, it appeared
that all the proposals for imapfw were too similar to get more than one student.
Similar proposals are hard to handle because student contributions would clash.
This would not fit well for a GSoC.


{:.note}

imapfw had 4 proposals for a total of 17 (actually 20 but I'm excluding the most
obvious spams). This is not bad at all compared to the other projects of the org
having at most 2 proposals. Also, our applicants were all aware of the other
applicants before applying. **I'm happy imapfw has good traction!**


### The slots

On April 13th, slots allocation was announced. Gentoo had 5 slots. At the next
step, the org admin has to allocate the slots for the accepted projects on the
official dashboard. The deadline was April 20th.

{:.DarkRed}

I consider this job was far from easy. Especially to select the 4th and 5th
students.

Because this was not so obvious for those, the org admin decided to poll the
mentors.

Extract of the poll request:

> I'm having second thoughts about picking among the 6 projects we have
for our 5 slots. So, I would like to ask each of you to send me an
email with your list of 5 preferred projects from the following
students: [...]. No need to rank them, just the 5 you prefer.

{:.DarkBlue}

Notice that there are 6 projects considered by the org admin for this poll, one
of the imapfw project was already excluded while highly ranked.

In the selection criteria, the org admin emphasized more than once that
"*planing to be involved with gentoo in the future*" was a contributing factor
in the decision. We didn't became aware of it until we got irreversibly
involved. However, I thought that it was clear for everybody that imapfw
students would be interested in becoming imapfw contributors and not much for
Gentoo. During the selection process, I was trusting the org admin to get this
in mind and balance the results.

{:.note}

Now that they know they are *not* accepted to the GSoC, two of our students
expressed they intend to contribute to imapfw once they are done with their
exams! We hope to see you later!


### The accepted projects

On April 20th, ***one day before the deadline***, the results of the poll were
announced: **the imapfw project in the course was the *last* for the 6 projects
considered in this poll.**

{:.DarkBlue}

While I was a bit worried, this was not much an issue for me. It was not clear
he would take those result as the only relevant criteria to select the projects.
I was trusting the org admin to put those **late and surprising results** in
perspective. I'm not sure this made sense to decide at the bottom of the scale
because listing the 5 **"*preferred*"** projects is obviously not objective...
And the results we got are quite surprising. Even the org admin said he was
surprised.

{:.warning}
{:.DarkRed}

**I was wrong to trust the org admin. He decided to accept the projects by only
considering those late results. Hence, *none of the imapfw projects got
accepted*.**

This was **obviously** unfair:

* 1 imapfw project of the top 3 was ignored in this poll.
* The poll was requesting a matter of *preference* which is a quite
subjective notion.
* There were grades of technical review already available to decide.

No constructive exchanges for allocating the slots. No team work. No open
process. Only a late opaque poll, discarding the most objective ranking and
all of the work done before. Erf...


### After the facts

As mentors for imapfw we were not expecting that students interested in imapfw
had to be interested into becoming a Gentoo contributor, too. That handicaped
us.

Here is an extract of the last response I got from one of the org admin after
the deadline:

> And last, but not least, if you want to run GSoC your own way, apply
as an organization yourself (google accepts plenty of small projects),
or at least choose an organization that fits better with your project
goals (PSF maybe?). You can't blame gentoo mentors for not selecting a
project that has nothing to do with gentoo, instead of another related
project with qualified student/proposal.

So,

1. This late poll was uncalled for.

2. The results of this poll could be put in perspective to get the full
	 picture but this was not done.

3. The accepted projects are explicitly neither the best quality according to
	 the internal evluation of the projects nor the pairs of mentors/students with
	 the best chances to succeed.


I don't blame the mentors. I think anyone of us realized what was going
to happen while responding this late poll.

{:.note}

Thanks to this org admin for the honest response.


### Our experience

{:.DarkBlue}

First, I'd like to thank all of our applicants for this GSoC. **You did a good
job and we had real fun time with you. Please, accept the sincere apologies from
Abdó and I. We both would certainly not have make this GSoC with Gentoo if we
could imagine how it turned out to be.** We are sad this GSoC experience has
been biased like that.

I'm not crying because we didn't get a slot. I regret we didn't get a slot while
we had 2 of the 3 best projects. As mentors, we obeyed all the requests from the
org admins in due time. We definetely applied all of them. Never heard
complaints either. I regret the mentors were finally not considered to evaluate
the success of the projects.

Actually, I'm mainly blaming myself. I guess that what happened is part of the
game, at least at Gentoo.

Perhaps I should have asked what are the exact criteria to select the projects.
I never asked if we could be handicaped by joining Gentoo as a sub-org, either.
I probably should have started discussions when I've had doubts on the selection
process. *Instead, I was trusting the org admins to draw the full picture by
themselves and encourage discussions to decide what projects to accept.* I was
wrong.


My apologies to the students.


### Why this blog post?

I'm having a hard time to explain our students what they did wrong and why they
are not accepted. I'd rather be honest about what happened and why they are
disqualified. It's not easy task to do right in my position.

Also, I want the org admins to get a chance to catch what I'm saying to the
students so they can provide their own feedbacks. It's well possible we did
things wrong as mentors while we didn't got hints about that. Maybe this
feedback can help them to improve their internal process while accepting
sub-orgs, too.

I believe that sharing our experience might be beneficial to other umbrella and
sub-orgs in the future. This experience was not a pleasure.

Finally, most of us didn't started contributing in open source via the GSoC
program. The main reason for me to be involved was to help students being
involved. I'll continue outside of the GSoC.

{:.DarkBlue}

**Thanks a lot to Abdó** who spent quite some time for this GSoC!
