---
layout: page
title: How to become a maintainer
date: 2015-03-20
author: Nicolas Sebrecht
---

{% assign links = site.data.links %}
{% assign icons = site.data.icons %}


Contrary to popular belief, becoming a maintainer is not something hard, for OfflineIMAP at least. :-)

* junk
{:toc}

---

## The short story

Express your desire to one of the current official maintainers. This is all you have to do.

We don't require years of contributions. Of course, we will pay attention a bit to your past interest to the project and your skills. But nothing is mandatory and it's fine to still be learning while being an official maintainer. Nobody is all-knowing, even with years of experience. So, if one current maintainer agrees, he will grant you the write access to the official repository.

Be aware that there is no more leader maintainer, neither is a leader in the team. Once you become a team member and did some maintenance for the project, you're free to take all the strong decisions.

Since we are a team, we always try to discuss with others before taking any strong decision, including the users. This prevents from breaking things inside the whole community and the proximity we have with our users. Even most discreet of them will raise one day with good hints, review, feedback or opinion. This is how we are running in OfflineIMAP. And yes, we are really proud about the solid relationship we have with the users.


## What you should know about

> Skills are probably the main barrier in people's mind. I'll try to show you why this is a wrong belief.


{: .note}
{{ icons.note }} We are all learning, always. {{ icons.end }}
As such, it's fine to request a maintainer position even if you don't have the experience nor the skills you think you should have.

{: .note}
{{ icons.note }} You are not alone. {{ icons.end }}
Also, you could ask a current active maintainer to mentor you for some time if you don't feel comfortable enough. He could say *yes or no* but it's free to ask. **Such requests are really welcome!**

> Maintainers, developers, users, everybody expect you to do mistakes. It's fine as long as you recognize them and try to fix them.


### Be aware of the changes

{:style='color:DarkRed'}
You must be subscribed to the mailing list, for sure.

### The documentation

Having read the available documentation once is a good start.

### A bit of Python *(for `offlineimap.git` only)*

While it's not mandatory, it's much better if you are able to review and comment on the submitted patches.

You're not supposed to know **EVERYTHING**. When you have doubts on something or when the patches are touching some area you're not used to, do ask the contributor for any question. Contributors are used to explain what they did. If the original authors of the code are still around, you might request them too.

### Git

Git is the main tool of the maintainer. You should be comfortable with the concepts of branches, pull, rebase and merge. All more advanced skills can be learn on the job.

## How to, technical ressources

### Graduate other's patches

{: .note}
**Before** applying other's patches whose meant to go into the official history, it's required to ensure the topic is good enough. Here are the basic rules.

##### Documentation reflects the changes

There's nothing worse than wrong documentation of a software.

##### Code is correctly commented

Same applies in the code.

##### Tested code

Ask the contributor if the code was tested, otherwise you might need to test the changes by yourself.

##### Commits are well-formed

* A subject line describing the whole commit.
* Details come after blank line.
* Commits are signed.

See the current `git log`.


### Merging patches

#### From a pull request

Wheter a pull request comes from Github or not, you should merge the patches with Git so you can sign-off the patches.

{% highlight bash %}
$ git checkout -b initials/topic-name <base>
$ git fetch user_repo branch
$ git merge user_repo/branch
{% endhighlight %}

#### From files/mails

The source of such patches are mostly the mailing list. Contributors are welcome sending patches to the mailing list because it's easy to comment and review.

Applying patch files is easy when you know the correct base it's built on.

##### Copy the mails to the git repository

> For easy picking of patches from the mailing list, I use a dedicated local folder in the maildir format. The `cur` directory is symlinked to the git repository.

{% highlight bash %}
$ cd Maildir/<the mailing list>
$ mkdir --parents offlineimap_patches/{cur,new,tmp}
<folderfilter the "offlineimap_patches" folder within OfflineIMAP>
$ cd <OfflineIMAP git repository>
$ ln -s path/to/cur \_incoming
$ echo \_incoming >> .git/info/exclude
{% endhighlight %}

Then, I just copy the patches I want in my MUA into this folder.

##### Integrate into Git

{% highlight bash %}
$ git am --reject -s \_incoming/patches{1..n}
{% endhighlight %}

##### If `am` did not apply all the hunks

In the worst case and if you can't find the correct parent of the OP's patches, you might need to resolve conflicts manually.

With the above command, all the rejected hunks are put into `*.rej` files. Edit each and paste the code you want into the sources. Once done for all the `*.rej`, continue with:

{% highlight bash %}
$ git am --continue
{% endhighlight %}

### Signing the topic

You really should sign on top of each other's commit. It makes it clear you reviewed each patch.

{% highlight ini %}
[alias]
  # Usage: git signoff-rebase [base-commit]
  signoff-rebase = "!GIT_SEQUENCE_EDITOR='sed -i -re s/^pick/e/' sh -c 'git rebase -i $1 && while git rebase --continue; do git commit --amend -s --no-edit; done' -"
{% endhighlight %}

### Polish other's patches

At some point, it's good practice to pick a topic which isn't as good as you'd like to. It's welcome to avoid boring contributors with your own nitpickings. Do bear in mind that it's a lot of work to re-roll a series of patches.



<!--
vim: expandtab ts=2 :
-->
