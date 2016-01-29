---
layout: post
title: No, I'm not using maxconnections
date: 2016-01-29
author: Nicolas Sebrecht
categories: configuration
---

{% assign icons = site.data.icons %}
{% assign account_locking = "https://github.com/OfflineIMAP/offlineimap/commit/1b85e3525678e6038614e0510c0be7f7bc179f88" %}

I'm not using the `maxconnections` feature in the configuration file. Here is why.

<!--more-->


## Why it hurts

In the good old days of OfflineIMAP, you were probably told to enable `maxsyncaccounts` and `maxconnections` to either synchronize multiple accounts or improve performance. I would not ask you to use this feature anymore.

**This is something hard to say but it's true that nowadays nobody has good/full understanding on multithreading in the code.** Multithreading was introduced early but it appears that it badly supported all the later changes. IMAP connections internally requires locks that have to be correctly handled everywhere. While it's commonly known to be a hard task by itself, things are currently worse because the same chunks of code can be used in different contexts (e.g.: with/without IDLE).


## A workaround

Those configuration options were the only way to synchronize multiple accounts because of a **global lock**. OfflineIMAP used to allow only one instance of the program. For some years, things have changed: locking is done at the account level.

{:.note}

See [this commit](https://github.com/OfflineIMAP/offlineimap/commit/45782ca3ac72119ac3af276cbfc763c72fada86f) and [this one]({{ account_locking }}) for details.

*Thanks to Sebastian Spaeth*, running OfflineIMAP more than once is fine *as long as it's not with the same account(s)*.

That's what greatly helps: running multiple instances is a good workaround of the messing code. This way, you only rely on code about locking at the account level *which required only [23 lines of change]({{ account_locking }}) when introduced*. Much better than having to rely on locks spread all over the code about IMAP sessions, each handled by one Python thread.

{:.warning}

Because OfflineIMAP proved to have some glitches with multithreading, my advice is you should **make your best to avoid weird errors** and tracebacks: simply avoid `maxsyncaccounts` and `maxconnections` if you can.


> That's why I'm much more confident with multiple instances running at the same time.


{:.note}
{{ icons.note }} This advice is not always possible {{ icons.end }}
If you want to enable IDLE with **more than one folder**, you can't apply. *Each IDLE folder requires a dedicated IMAP connection*.


## Running more than one OfflineIMAP instance

In order to synchronize all my accounts in one command, I wrote a shell script with this kind of tricks:

{% highlight bash %}
offlineimap -a account_one & pid1=$!
offlineimap -a account_two & pid2=$!

wait $pid1
wait $pid2
echo "Last execution: $(date)"
{% endhighlight %}


{: .DarkBlue}
Ok, I agree with you this full thing is not glorious. But it's effective. And if you hit weird errors, you might like to be aware it's possible to improve stability. ,-)
