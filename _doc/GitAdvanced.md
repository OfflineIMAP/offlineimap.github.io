---
layout: page
title: Git Advanced
date: 2015-03-07
author: Nicolas Sebrecht
---
{% assign links = site.data.links %}
{% assign icons = site.data.icons %}


{: .note}
{{ icons.note }} Note from Nicolas Sebrecht, when he became the maintainer:{{ icons.end }}
 
I started reading over the `SubmittingPatches` document from the Git project, primarily because I wanted to have a document similar to it for OfflineIMAP and to make sure people understand what they are doing when they write `Signed-off-by` line.
 
Also, understanding the branching model and workflow are important to feel comfortable.
 
But the patch submission requirements are a lot more relaxed here on the technical/contents front, because the OfflineIMAP is a lot smaller ;-).
So here are only the relevant bits.

{: .note}
{{ icons.note }} Do read this document{{ icons.end }}
 
You should really read this document entirely. Most of the hints here are quite "standard" when it comes to ***topic oriented*** workflow (or very similar), while few projects actually document their model.
 
In other words, **you'll find here documentation that will apply to a lot of projects out there**. With the following in mind, you will **more quickly earn the trust of the key persons** involved in the project you're contributing.



* junk
{:toc}

---

## Git Branching model

### Branches

OfflineIMAP uses the following branches

- **master**
  This is **the mainline**. Simple users should use this branch.

- **next**
  **The development branch** for developers and testers.

  The content of `next` is merged into the mainline `master` at release time for both stable and releases candidates.
  
  When patches are sent to the mailing list, contributors discuss about them. Once done and when patches looks ready for the mainline, patches are first merged into `next`.
  Advanced developers and testers use this branch to test the last merged patches before they hit the mainline. This helps not introducing strong breakages directly in the mainline.

- **maint**
  This is **the maintenance branch**.
  
  It gets its own releases starting off of an old stable release.

  {: .warning}
  Notice that this branch tend to be more or less abandoned when context does not force the maintainers to take care of it.

- **pu**
  Don't care much about this branch unless you're asked to use it.
  
  {: .warning}
  `pu` is almost abandoned nowadays.
  
  `pu` stands for *"proposed updates"* and helps **tracking of topics**. If a topic is not ready for the `next` release, it might be merged into `pu`.

  This branch only help developers to work on someone else topic or an earlier pending topic. They can extract a topic from this branch to work on it.

  {: .warning}
  This branch is **not intended to be checkouted**; never. Even developers don't do that. Due to the way `pu` is built you can't expect content there to work in any way... unless you clearly want to run into troubles.


### Decide what branch to base your work on

{: .note}
In general, base your work on the ``next`` branch. Otherwise, start off of the latest commit your change is relevant to.


### Extract a topic from pu

To find the tip of a topic branch, run ``git log --first-parent next..pu`` and look for the merge commit. The second parent of this commit is the tip of the topic branch.


``pu`` is built this way:

{% highlight bash %}
$ git checkout pu
$ git reset --keep next
$ git merge --no-ff -X theirs topic1
$ git merge --no-ff -X theirs topic2
$ git merge --no-ff -X theirs blue
$ git merge --no-ff -X theirs orange
...
{% endhighlight %}

As a consequence:

1. Each topic merged uses a merge commit. A merge commit is a commit having 2 ancestors. Actually, Git allows more than 2 parents but we don't use this feature. It's intended.

2. Paths in ``pu`` may mix up multiple versions if all the topics don't use the same base commit. This is very often the case as topics aren't rebased: it guarantees each topic is strictly identical to the last version sent to the mailing list. No surprise.


What you need to extract a particular topic is the **sha1** of the tip of that branch (the last commit of the topic). Assume you want the branch of the topic called 'blue'. First, look at the log given by this command:

{% highlight bash %}
$ git log --reverse --merges --parents origin/next..origin/pu
{% endhighlight %}

With this command you ask for the log:

* from next to pu
* in reverse order (older first)
* merge commits only
* with the sha1 of the ancestors

From this list, find the topic you're looking for, basing you search on the lines like:

> Merge branch 'topic/name' into pu

By convention, it has the form `<author_initials>/<brief_title>`.

When you're at it, pick the topic ancestor sha1. It's always the last sha1 in the line starting by 'commit'. For you to know:

* The first sha1 is the commit you see: the merge commit.
* The following sha1 is the ancestor of the branch checkouted at merge time (always the previous merged topic or the ancien next in our case).
* Last is the branch merged.

Giving:

~~~
commit sha1_of_merge_commit sha1_of_ancient_pu sha1_of_topic_blue
~~~

Then, you only have to checkout the topic from there:

{% highlight bash %}
$ git checkout -b blue sha1_of_topic_blue
{% endhighlight %}

You're done! You've just created a new branch called "blue" with the blue content. Be aware this topic is not updated against the **current** next branch.  ,-)


## Release cycles

A typical release cycle works like this:

1. A stable release is out.

2. Feature topics are sent, discussed and merged.

3. When enough work was merged, we start the freeze cycle: the first release candidate is out.

4. During the freeze cycle, no more features are merged. It's time to test OfflineIMAP The more we are late in `-rc` releases, the less patches are merged but bug fixes.

5. When we think a release is stable enough, we restart from step 1.


Because third-parties tend to not always follow the cycles, it's fine to send your patches as soon as they are ready. Any maintainer might prefer to pend your contributions before merging it at a better time. You'll always be notified if such decision is made for your work.

Know about where we are in the release cycle:

{% highlight bash %}
$ git tag
{% endhighlight %}


## OfflineIMAP's workflow


### Create commits

* Make commits of logical units.
* If you change, add, or remove a command line option or make some other user interface change, the associated documentation should be updated as well.
* Check for unnecessary whitespace with `git diff --check` before committing.
* Do not check in commented out code or unneeded files.
* the first line of the commit message should be a short description (50 characters is the soft limit, see DISCUSSION in git-commit(1)), and should skip the full stop
* The body should provide a meaningful commit message, which:
  * uses the imperative, present tense: **change**, not **changed** or **changes**;
  * includes motivation for the change, and contrasts its implementation with previous behaviour.
* Add a `Signed-off-by: Your Name <you@example.com>` line to to confirm that you agree to the [Developer's Certificate of Origin]({{ site.base }}/doc/dco.html).
* Make sure that you have tests for the bug you are fixing.
* Make sure that the test suite passes after your commit.


{: .note}
{{ icons.note }}{{ icons.end }}
To improve tracking of who did what, we've borrowed the "sign-off" procedure from the Linux kernel project on patches that are being emailed around.  Although OfflineIMAP is a lot smaller project it is a good discipline to follow it.
 
The sign-off is a simple line at the end of the explanation for the patch, which **certifies that you wrote it or otherwise have the right to pass it on as a open-source patch**.  The rules are pretty simple: if you can't certify, don't sign-off, don't send.


#### Make atomic commits

Make separate commits for logically separate changes

Unless your patch is really trivial, you should not be sending your changes in a single patch.  Instead, always make a commit with complete commit message and generate a series of small patches from your repository.

Describe the technical detail of the change(s).

If your description starts to get too long, that's a sign that you probably need to split up your commit to finer grained pieces.  That being said, patches which plainly describe the things that help reviewers check the patch, and future maintainers understand the code, are the most beautiful patches.

Descriptions that summarise the point in the subject well, and describe the motivation for the change, the approach taken by the change, and if relevant how this differs substantially from the prior version, can be found on Usenet archives back into the late 80's. Consider it like good Netiquette, but for code.


### Submit your patches

{: .note}
{{ icons.note }} Where should I send {{ icons.end }}
  The [mailing list]({{ links.mailing_list_subscribe }}) is the preferred way for sending patches. This allows easier review and comments on the code. This can be really essential for advanced changes or topics that could require discussions. Read more about that in this [detailed version]({{ site.base }}/doc/GitAdvanced-send-long.html)

  For more trivial patches, using the Github feature pull request is fine.

#### Make a pull request

* Push your changes to a topic branch in your public fork of OfflineIMAP.
* Submit a pull request to the OfflineIMAP maintainers.
* If a ticket is open in the issues, add a comment with the link to your pull request.


#### Export commits as patches

* Use ``git format-patch -M`` to create the patch.
* Do not attach your patch, but read in the mail body, unless you cannot teach your mailer to leave the formatting of the patch alone.
* Be careful doing cut & paste into your mailer, not to corrupt whitespaces.
* Do not PGP sign your patch.


##### Side notes for experts

* Provide additional information (which is unsuitable for the commit message) between the ``---`` and the diffstat.
* If your name is not writable in ASCII, make sure that you send off a message in the correct encoding.
* Send the patch to the [mailing list]({{ links.mailing_list_subscribe }}) if (and only if) the patch is ready for inclusion.
* If you use `git-send-email(1)` which is a good idea, please test it first by sending email to yourself.
* See below for instructions specific to your mailer.


#### Generate your patch using git tools out of your commits

* ``git`` based diff tools (git, Cogito, and StGIT included) generate *unidiff* which is the preferred format.

* You do not have to be afraid to use ``-M`` option to ``git diff`` or ``git format-patch``, if your patch involves file renames.  The receiving end can handle them just fine.

* Please make sure your patch does not include any extra files which do not belong in a patch submission.

* Make sure to review your patch after generating it, to ensure accuracy.

* Before sending out, please make sure it cleanly applies to the ``next`` branch head. If you are preparing a work based on somewhere else, that is fine, but please mark it as such.

### An ideal patch flow

Here is an ideal patch flow for this project the current maintainers suggests to the contributors:

0. You come up with an itch.  You code it up.

1. Send it to the list and cc people who may need to know about the change.

   The people who may need to know are the ones whose code you are butchering.  These people happen to be the ones who are most likely to be knowledgeable enough to help you, but they have no obligation to help you (i.e. you ask for help, don't demand).
   
   ``git log -p -- $area_you_are_modifying`` would help you find out who they are.

2. You get comments and suggestions for improvements.  You may even get them in a "on top of your change" patch form.

3. Polish, refine, and re-send to the list and the people who spend their time to improve your patch.  Go back to step (2).

4. The list forms consensus that the last round of your patch is good.  Send it to the list and cc the maintainers.

5. A topic branch is created with the patch and is merged to ``next``, and cooked further and eventually graduates to ``master``.


In any time between the (2)-(3) cycle, the maintainer may pick it up from the list and queue it to ``pu``, in order to make it easier for people play with it without having to pick up and apply the patch to their trees themselves.


### Know the status of your patch after submission

You can use Git itself to find out when your patch is merged in master. ``git pull --rebase`` will automatically skip already-applied patches, and will let you know. This works only if you rebase on top of the branch in which your patch has been merged (i.e. it will not tell you if your patch is merged in ``pu`` if you rebase on top of ``next``).

{: .note}
{{ icons.note }}I still can't see my patches!{{ icons.end }}
 
There is a difference between merging/applying patches and make them public.
 
When a maintainer says "**applied**" or "**merged**", it means it's applied in his own local repository. So, you might not see your patches in the official repository yet.
 
You should ping the maintainer only if your patches look still not public after some days.


<!--
vim: expandtab ts=2 :
-->
