---
layout: page
title: Coding guidelines
---

* junk
{:toc}

This document contains assorted guidelines for programmers that want to hack OfflineIMAP.


# Exception handling

OfflineIMAP on many occasions re-raises various exceptions and often changes exception type to `OfflineImapError`.  This is not a problem per se, but you must always remember that we need to preserve original tracebacks.  This is not hard if you follow these simple rules.

For re-raising original exceptions, just use:

{% highlight python %}
raise
{% endhighlight %}

from inside your exception handling code.

If you need to change exception type, or its argument, or whatever, use this three-argument form:

{% highlight python %}
raise YourExceptionClass(argum, ents), None, sys.exc_info()[2]
{% endhighlight %}

In this form, you're creating an instance of new exception, so `raise` will deduce its ``type`` and `value` parameters from the first argument, thus the second expression passed to `raise` is always `None`.

And the third one is the traceback object obtained from the thread-safe `exc_info()` function.

In fact, if you hadn't already imported the whole `sys` module, it will be better to import just `exc_info()`:

{% highlight python %}
from sys import exc_info
{% endhighlight %}

and raise like this::

{% highlight python %}
raise YourExceptionClass(argum, ents), None, exc_info()[2]
{% endhighlight %}

since this is the historically-preferred style in the OfflineIMAP code.

<!--
vim: expandtab ts=2 :
-->
