---
layout: page
title: GSoC student helpers
author: Nicolas Sebrecht
date: 2016-02-18
updated: 2016-03-11
---

{% assign links = site.data.links %}
{% assign icons = site.data.icons %}

* junk
{:toc}

### Contacts

* [Nicolas](mailto:nicolas.s-dev@laposte.net)
* [Abdó](mailto:abdo.roig@gmail.com)

## Your first contact

If you're about to contact us, here's what we'd like to know about you.

{:.warning}
{{ icons.note }} Important: {{ icons.end }}
We understand some information are private data, so **consider sending a private mail** to **both** mentors.

* Name
* Country and timezone
* Short bioagraphical information
  - skills (check the required skills, perfect matching may not be mandatory)
  - education
  - open source experience
* Why you? *(optional)*
* What tools do you know/use? *(text editor, source code management system, daily OS, etc)*
* Github pseudo *(if any)*

* Your ideas, questions, etc

{:.note}
{{ icons.note }} Tip: {{ icons.end }}
Avoid asking for the obvious, that's annoying.


## Decided to apply?

Your next goal is to write a proposal. **You should really focus on this.**

### Your proposal

* Check out the project and the online documentation first (full reading is not
  expected).
* Understand what the project is all about.
* Send your proposal(s) or expose your ideas if you don't have a draft yet.
* **As for code: release soon, release often.** You should really work
  incrementally, by small steps. **Start little but start soon.** The sooner
  it's out, the sooner you'll get our feedbacks. Also, it's fine to annotate
  your work with a `WIP` flag ("Work In Progress") to let us know you're
  currently wokring on this area.

{:.note}
{{ icons.note }} Tip: {{ icons.end }}
Don't bother too much about making the kick-ass impression at this stage. **This should not take your day!**


## What next?

Once your porposal(s) submitted, there are lot of things you can do instead of waiting for the next step.

{:.warning}
{{ icons.note }} Important: {{ icons.end }}
At this point, it's best starting **public threads** in our [mailing list]({{ links.mailing_list.subscribe }})!

#### Become a real member

Subscribe the mailing list and create a github account.

#### Try OfflineIMAP

imapfw intend to replace OfflineIMAP. Give it a try, see what it does. *(Deep knowledge of OfflineIMAP is not required required, though.)*

#### Read about imapfw

There is already released ressources about it. Help yourself. If it's not already done, read them. Ask if you're not missing something important unless you're sure of you.

#### Try imapfw

While still at early development stage, imapfw can already run commands. Get the source and try them.

#### Get you used to the tree

Files are organized. Check the tree.

#### Read some source code

Understanding the full codebase at the first shot is not human. Try to correctly identify the key modules, first. Then, you should read and try to understand some hunks you feel critical.

There are mainly two ways:

* bottom-up: from low-level to high-level
* top-down: from high-level to low-level

In practice you might mix both. Always try to figure if it's low-level or high-level code. This will greatly help.

#### Identify the libraries

We use third-party libraries. One is embedded with the codebase.

#### Ensure you have a proper environment

Are you missing a tool? Do they work?

#### Look how we work

Read [this full thread](http://thread.gmane.org/gmane.mail.imap.offlineimap.general/7064).

Don't try to understand the patches or details of what we are talking about, that's not the point. You'll learn how we're used to work and how we expect you to work with us. *Notice there's nothing much special, that's how a lot of open source communities work.*

**Fully read this thread. You'll actually learn *a lot* the quick way**. There, we do or discuss a lot of things like: code logic, code design, code review, concepts orthogonality, release cycle, comments about code comments, history introspection, legacy compatibility, compatibility with other tools, honoring configuration and CLI options, all sort of contributors interactions like defending opinions or technical decisions, blaming, critics, apologies, question about how we track tasks for the project, etc.

*While this might look disordered and confusing from outside this kind of teamwork is very efficient and rewarding.*

#### Play with imapfw

Again, imapfw can already run commands. Try to make use of the rascal by yourself. Play with it. Break things and read the errors to fix your configuration.

#### Report broken expectations

Code is moving, documentation might be missing or hard to understand. Report us what you think need improvements (and why if applicable). **Your new eyes matter.**

#### Read the git history

imapfw is a new tool, history can be read entirely. Do it.

#### Try to provide some patches

Don't wait to send some changes. **Start little but don't wait!** It can be about anything (code, documentation, README, etc). Even typos need to be fixes. If you still didn't send your first patch, you're not ready yet. ,-)

{:.note}
{{ icons.note }} Tip: {{ icons.end }}
Keep us informed about what you're doing, always. We have good reasons to request you to do so at this stage.

{:.note}
{{ icons.note }} Tip: {{ icons.end }}
Ask us if you're stuck at any step. While we do expect you to fix your own issues as much as possible, it's stupid to spend hours in researches when someone can help.


## FAQ

*(To be updated from time to time)*

<!--
vim: expandtab ts=2 :
-->
