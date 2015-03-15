---
layout: page
title: MUA specific hints
---
{% assign links = site.data.links %}

* junk
{:toc}

---


Some of patches I receive or pick up from the list share common
patterns of breakage.  Please make sure your MUA is set up
properly not to corrupt whitespaces.  Here are two common ones
I have seen:

* Empty context lines that do not have _any_ whitespace.

* Non empty context lines that have one extra whitespace at the
  beginning.

One test you could do yourself if your MUA is set up correctly is:

* Send the patch to yourself, exactly the way you would, except
  To: and Cc: lines, which would not contain the list and
  maintainer address.

* Save that patch to a file in UNIX mailbox format.  Call it say
  a.patch.

* Try to apply to the tip of the "master" branch from the
  git.git public repository::

    $ git fetch http://kernel.org/pub/scm/git/git.git master:test-apply
    $ git checkout test-apply
    $ git reset --hard
    $ git am a.patch

If it does not apply correctly, there can be various reasons.

* Your patch itself does not apply cleanly.  That is _bad_ but
  does not have much to do with your MUA.  Please rebase the
  patch appropriately.

* Your MUA corrupted your patch; "am" would complain that
  the patch does not apply.  Look at .git/rebase-apply/ subdirectory and
  see what 'patch' file contains and check for the common
  corruption patterns mentioned above.

* While you are at it, check what are in 'info' and
  'final-commit' files as well.  If what is in 'final-commit' is
  not exactly what you would want to see in the commit log
  message, it is very likely that your maintainer would end up
  hand editing the log message when he applies your patch.
  Things like "Hi, this is my first patch.\n", if you really
  want to put in the patch e-mail, should come after the
  three-dash line that signals the end of the commit message.


### Pine

(Johannes Schindelin)
  I don't know how many people still use pine, but for those poor souls it may
  be good to mention that the quell-flowed-text is needed for recent versions.

  ... the "no-strip-whitespace-before-send" option, too. AFAIK it was introduced
  in 4.60.

(Linus Torvalds)
  And 4.58 needs at least this

::

  ---
  diff-tree 8326dd8350be64ac7fc805f6563a1d61ad10d32c (from e886a61f76edf5410573e92e38ce22974f9c40f1)
  Author: Linus Torvalds <torvalds@g5.osdl.org>
  Date:   Mon Aug 15 17:23:51 2005 -0700

      Fix pine whitespace-corruption bug

      There's no excuse for unconditionally removing whitespace from
      the pico buffers on close.

  diff --git a/pico/pico.c b/pico/pico.c
  --- a/pico/pico.c
  +++ b/pico/pico.c
  @@ -219,7 +219,9 @@ PICO *pm;
  	    switch(pico_all_done){	/* prepare for/handle final events */
  	      case COMP_EXIT :		/* already confirmed */
  		packheader();
  +#if 0
  		stripwhitespace();
  +#endif
  		c |= COMP_EXIT;
  		break;

(Daniel Barkalow)
  > A patch to SubmittingPatches, MUA specific help section for
  > users of Pine 4.63 would be very much appreciated.

  Ah, it looks like a recent version changed the default behavior to do the
  right thing, and inverted the sense of the configuration option. (Either
  that or Gentoo did it.) So you need to set the
  "no-strip-whitespace-before-send" option, unless the option you have is
  "strip-whitespace-before-send", in which case you should avoid checking
  it.


### Thunderbird

(A Large Angry SCM)
  By default, Thunderbird will both wrap emails as well as flag them as
  being 'format=flowed', both of which will make the resulting email unusable
  by git.

  Here are some hints on how to successfully submit patches inline using
  Thunderbird.

  There are two different approaches.  One approach is to configure
  Thunderbird to not mangle patches.  The second approach is to use
  an external editor to keep Thunderbird from mangling the patches.

**Approach #1 (configuration):**

  This recipe is current as of Thunderbird 2.0.0.19.  Three steps:

    1. Configure your mail server composition as plain text
       Edit...Account Settings...Composition & Addressing,
       uncheck 'Compose Messages in HTML'.
    2. Configure your general composition window to not wrap
       Edit..Preferences..Composition, wrap plain text messages at 0
    3. Disable the use of format=flowed
       Edit..Preferences..Advanced..Config Editor.  Search for:
       mailnews.send_plaintext_flowed
       toggle it to make sure it is set to 'false'.

  After that is done, you should be able to compose email as you
  otherwise would (cut + paste, git-format-patch | git-imap-send, etc),
  and the patches should not be mangled.

**Approach #2 (external editor):**

This recipe appears to work with the current [*1*] Thunderbird from Suse.

The following Thunderbird extensions are needed:
  AboutConfig 0.5
	  http://aboutconfig.mozdev.org/
  External Editor 0.7.2
	  http://globs.org/articles.php?lng=en&pg=8


1) Prepare the patch as a text file using your method of choice.

2) Before opening a compose window, use Edit->Account Settings to
   uncheck the "Compose messages in HTML format" setting in the
   "Composition & Addressing" panel of the account to be used to send the
   patch. [*2*]

3) In the main Thunderbird window, _before_ you open the compose window
   for the patch, use Tools->about:config to set the following to the
   indicated values::

     mailnews.send_plaintext_flowed	=> false
     mailnews.wraplength		=> 0

4) Open a compose window and click the external editor icon.

5) In the external editor window, read in the patch file and exit the
   editor normally.

6) Back in the compose window: Add whatever other text you wish to the
   message, complete the addressing and subject fields, and press send.

7) Optionally, undo the about:config/account settings changes made in
   steps 2 & 3.


[Footnotes]

*1* Version 1.0 (20041207) from the MozillaThunderbird-1.0-5 rpm of Suse
9.3 professional updates.

*2* It may be possible to do this with about:config and the following
settings but I haven't tried, yet::

  mail.html_compose			=> false
  mail.identity.default.compose_html	=> false
  mail.identity.id?.compose_html		=> false

(Lukas Sandström)
  There is a script in contrib/thunderbird-patch-inline which can help you
  include patches with Thunderbird in an easy way. To use it, do the steps above
  and then use the script as the external editor.

### Gnus

'|' in the *Summary* buffer can be used to pipe the current
message to an external program, and this is a handy way to drive
"git am".  However, if the message is MIME encoded, what is
piped into the program is the representation you see in your
*Article* buffer after unwrapping MIME.  This is often not what
you would want for two reasons.  It tends to screw up non ASCII
characters (most notably in people's names), and also
whitespaces (fatal in patches).  Running 'C-u g' to display the
message in raw form before using '|' to run the pipe can work
this problem around.


### KMail

This should help you to submit patches inline using KMail.

1) Prepare the patch as a text file.

2) Click on New Mail.

3) Go under "Options" in the Composer window and be sure that
   "Word wrap" is not set.

4) Use Message -> Insert file... and insert the patch.

5) Back in the compose window: add whatever other text you wish to the
   message, complete the addressing and subject fields, and press send.


Gmail
-----

GMail does not appear to have any way to turn off line wrapping in the web
interface, so this will mangle any emails that you send.  You can however
use "git send-email" and send your patches through the GMail SMTP server, or
use any IMAP email client to connect to the google IMAP server and forward
the emails through that.

To use ``git send-email`` and send your patches through the GMail SMTP server,
edit `~/.gitconfig` to specify your account settings::

  [sendemail]
	  smtpencryption = tls
	  smtpserver = smtp.gmail.com
	  smtpuser = user@gmail.com
	  smtppass = p4ssw0rd
	  smtpserverport = 587

Once your commits are ready to be sent to the mailing list, run the
following commands::

  $ git format-patch --cover-letter -M origin/master -o outgoing/
  $ edit outgoing/0000-*
  $ git send-email outgoing/*

To submit using the IMAP interface, first, edit your `~/.gitconfig` to specify your
account settings::

  [imap]
	  folder = "[Gmail]/Drafts"
	  host = imaps://imap.gmail.com
	  user = user@gmail.com
	  pass = p4ssw0rd
	  port = 993
	  sslverify = false

You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error
that the "Folder doesn't exist".

Once your commits are ready to be sent to the mailing list, run the
following commands::

  $ git format-patch --cover-letter -M --stdout origin/master | git imap-send

Just make sure to disable line wrapping in the email client (GMail web
interface will line wrap no matter what, so you need to use a real
IMAP client).

<!--
vim: expandtab ts=2 :
-->
