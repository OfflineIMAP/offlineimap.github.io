---
layout: post
title: Does not have a message with UID 15541
date: 2016-01-27
author: Tomas Nordin
categories: server imap error
---

{% assign icons = site.data.icons %}

A message refuse to be downloaded despite reported as a mail with an UID. Server
or OfflineIMAP then say that the account does not have that UID, and fetch of
the message fails.

<!--more-->

* dummy
{:toc}

## Background ##

My private mail accounts are served by remote servers. One of them (one of two)
is a remain from my studies at the university KTH in Stockholm Sweden. They
kindly let you keep the mail address and also they are not tight-fisted on
storage space.

I'm a Mutt user. Starting out with Mutt, I was using it's built-in functionality
to connect to the server and read my mail. Being curious on other mail user
agents, (to make fast mail body searches), I started to understand that a
maildir is a good thing to have, because a number of agents work with maildirs
out of the box.

Through the documentation of Notmuch, OfflineIMAP was suggested as something
descent for pulling down and synchronizing your mail in and out of a maildir. So
let's try with OfflineIMAP.

## Installed OfflineIMAP and got trouble ##

Or, I got half way. I got an error traceback such as

    Thread 'Copy message 15541 from INBOX' terminated with exception:
    Traceback (most recent call last):
      File "/usr/lib/pymodules/python2.7/offlineimap/threadutil.py", line 140, in run
        Thread.run(self)
      File "/usr/lib/python2.7/threading.py", line 763, in run
        self.__target(*self.__args, **self.__kwargs)
      File "/usr/lib/pymodules/python2.7/offlineimap/folder/Base.py", line 250, in copymessageto
        message = self.getmessage(uid)
      File "/usr/lib/pymodules/python2.7/offlineimap/folder/IMAP.py", line 215, in getmessage
        raise OfflineImapError(reason, severity)
    OfflineImapError: IMAP server 'remote_kth' does not have a message with UID '15541'

and from there, OfflineIMAP gave up and only some mails where pulled. It turned
out my OfflineIMAP version was not really the shiny new thing (a vanilla apt-get
install), so I installed version 6.6.1.

With that newer version, a similar traceback was given, but now OfflineIMAP
persisted, so everything but some culprit mail was downloaded.

## Is this a problem of OfflineIMAP? ##

Mailing list to the rescue. On my first post to the mailing list, Nicolas
responded:

> If the issue is not solve, I would ask to the Microsoft support or a
> forum. If OfflineIMAP wants to download this UID, it's because the
> server pretend to have this UID. IOW, I'd say it really looks like a
> server issue.

That gave me comfort. I was easily convinced it was an issue with the server. It
was like, I sort of *wanted* it to be an issue with the server. I mean, rather
than it would be a problem with a tool made by developers who maintain a dialog
with it's users.

The mailing list dialog continued:

> On Thu, Jan 21, 2016 at 08:26:15PM +0100, Tomas Nordin wrote:
>
> > I am in contact with the IT people there. They are not aware of UID:s.
> > Do you have a suggestion on how I can guide them in helping me
> > trouble-shoot this.
> >
> > I mean, is there a suggestion of a way they can query the Imap server so
> > as to see the UID being reported?
>
> Manual IMAP sessions are well described in the net. ,-)
>
> I'm pretty sure the issue comes from the exchange server. We had another
> report of this in github:
>
> https://github.com/OfflineIMAP/offlineimap/issues/296
>
> --
> Nicolas Sebrecht

Well thank you Nicolas, "Manual IMAP sessions are well described in the net". Is
that so? IMAP sessions huh? Well, OK.

That other reported issue by the way, seem to share my problem also in that it
was with the same kind of server.

## Manual imap session ##

So it seems I was up to the task to somehow debug the mail server myself.
Because, it seemed to me I'm not going to be able to get the people over there
to do it. Even if they know how to, I guess they have to say they cannot because
my credentials are needed.

### Well described in the net ###

I did not search and research that very much. This is interesting indeed, but I
feel that I have other things to do than to spend days on learning much and
plenty about IMAP servers and mail. Those are the links that I found and read
from to get somewhere:

1. [debug-your-imap-server-with-telnet](http://seeit.org/2010/01/31/debug-your-imap-server-with-telnet/)
2. [rfc3501](http://www.faqs.org/rfcs/rfc3501.html)

The first one was actually found by quack'ing the term "manual imap session".
The second one is from the people trying to maintain some interoperability in
the digital world, by maintaining specifications on how stuff should work.

### openssl ###

On my system there is a tool preinstalled I think, at least I don't remember
installing it explicitly, called `openssl`. From the top of the manual:

> OpenSSL is a cryptography toolkit implementing the Secure Sockets Layer (SSL
> v2/v3) and Transport Layer Security (TLS v1) network protocols and related
> cryptography standards required by them.
>
> The openssl program is a command line tool for using the various cryptography
> functions of OpenSSL's crypto library from the shell.

It comes with a sub command `s_client`. The top of it's manual:

> The s_client command implements a generic SSL/TLS client which connects to a
> remote host using SSL/TLS. It is a very useful diagnostic tool for SSL
> servers.

### openssl mail server session ###

I used the program `script` to log my sessions with openssl, they tend to be
lengthy. One need to be aware that the script program logs each and every
key-press. So when viewing the log in a text editor, it might look more or less
weird depending on how the editor render non-visible things, and how many
back-spaces and none-charecter key-strokes was done.

The connecting command of openssl was this:

    openssl s_client -connect webmail.kth.se:993 -crlf

The `-crlf` option translates a line feed from the terminal into CR+LF. Totally
required in my case, the server I am talking to require it, and I think it is
required by the RFC too.

Now a lot of output is given, ending with:

    * OK The Microsoft Exchange IMAP4 service is ready.

To talk to the server, one has to adhere to a communication protocol. It is
required to make up a (unique?) command identifier for each command. I went with
a001, a002, and so on. I don't know if it is strictly required to iterate the
identifier, but I did that for each command or request. The session started with
a log in:

    a001 login <user> <passwd>
    a001 OK LOGIN completed.
    a002 select INBOX
    * 1233 EXISTS
    * 0 RECENT
    * FLAGS (\Seen \Answered \Flagged \Deleted \Draft $MDNSent)
    * OK [PERMANENTFLAGS (\Seen \Answered \Flagged \Deleted \Draft $MDNSent)] Permanent flags
    * OK [UNSEEN 1045] Is the first unseen message
    * OK [UIDVALIDITY 14] UIDVALIDITY value
    * OK [UIDNEXT 16124] The next unique identifier value
    a002 OK [READ-WRITE] SELECT completed.

As a client I say `a001` followed by some command. The server finally responds
with something, prefixed with the client command identifier. Like `a001 OK LOGIN
completed.` I can reveal already that the information given on the first unseen
message, `OK [UNSEEN 1045]`, is the culprit message.

The first step was to figure out if the culprit message exist, since it was not
certain given the error traceback:

    a004 fetch 1040:1050 (uid)
    * 1040 FETCH (UID 15500)
    * 1041 FETCH (UID 15507)
    * 1042 FETCH (UID 15514)
    * 1043 FETCH (UID 15516)
    * 1044 FETCH (UID 15523)
    * 1045 FETCH (UID 15541)
    * 1046 FETCH (UID 15544)
    * 1047 FETCH (UID 15545)
    * 1048 FETCH (UID 15553)
    * 1049 FETCH (UID 15561)
    * 1050 FETCH (UID 15562)
    a004 OK FETCH completed.
    a005 logout
    * BYE Microsoft Exchange Server 2013 IMAP4 server signing off.
    a005 OK LOGOUT completed.
    read:errno=0

{:.note}

When I do the `fetch` command, I give as an argument not the UID number but
something I think is referred to as the index number or message number. This
number is consecutive and is not the same for one message always. It will be
different when the folder is rearranged by deleting messages.

The command fetch (commands are specified in the RFC spec as linked to above)
take a set as an argument followed with what to fetch, (UID) in this case. Now
it was clear that the message with UID 15541 is reported. Gossip on the mailing
list:

> On Sun, Jan 24, 2016 at 05:13:20PM +0100, Tomas Nordin wrote:
>
> > So now I am hacking around with openssl s_client. Here is some output of
> > my session:
> >
> > ...
> >
> > It seems to me the UID 15541 is reported. Does that prove something.
> > What should I do now?
>
> It seems there's really a mail with UID 15541. Try fetching this one
> alone. OfflineIMAP is doing something like
>
>   tagx FETCH 15541 ('BODY.PEEK[]')
>
> --
> Nicolas Sebrecht

I made some trials to fetch the mail "manually". Another session looked like
this:


    a00 OK LOGIN completed.
    a01 select INBOX
    * 1234 EXISTS
    * 0 RECENT
    * FLAGS (\Seen \Answered \Flagged \Deleted \Draft $MDNSent)
    * OK [PERMANENTFLAGS (\Seen \Answered \Flagged \Deleted \Draft $MDNSent)] Permanent flags
    * OK [UNSEEN 1045] Is the first unseen message
    * OK [UIDVALIDITY 14] UIDVALIDITY value
    * OK [UIDNEXT 16130] The next unique identifier value
    a01 OK [READ-WRITE] SELECT completed.
    a02 fetch 1045 (uid rfc822.size flags body.peek[header.fields (date to cc from subject x-priority content-type)])
    a02 OK FETCH completed.
    a03 fetch 1045 (body)
    * 1045 FETCH (BODY ("text" "plain" ("charset" "iso-8859-1") NIL NIL "quoted-printable" 1 1) FLAGS ())
    a03 OK FETCH completed.
    a04 fetch 1045 (body.peek[header.fields (from subject)])
    * 1045 FETCH (BODY[HEADER.FIELDS (from subject)] {127}
    From: Microsoft Exchange Server 2010
    Subject: Retrieval using the IMAP4 protocol failed for the following message:
    15541

There is a lot to learn in communicating with a mail server. For example, I
thought that the command above `a03 fetch 1045 (body)`, would spit out the body
of the message, but not so. (My idea of the body of the message is the part
containing the human readable message). He just say some details of the message
like the charset and so on and then *completed*.

Then I tried to get some information out from the message like `from:` and
`subject:` (a04). It seems the message was from the server. Concerning the
subject my conclusion is that the query fails. If the subject would really be
"Retrieval using the IMAP4 protocol failed for the following message: 15541",
this is a recursive mind-blower for me.

At
[debug-your-imap-server-with-telnet](http://seeit.org/2010/01/31/debug-your-imap-server-with-telnet/),
a problem was described about some over-sized mail that crashed the mail box. The
manual IMAP session was used to delete that one mail. This occurred very tempting
to me.

Nicolas said on the mailing list that it would be very interesting to fetch that
whole message in raw to see what is going on. Of course I agree, but with my
limited knowledge about this, and the output of my sessions, did not give me an
idea how to do that. On the contrary, it seemed not possible to me. It failed
even to serve the subject.

### Kill the culprit message ###

What to do when there is a problem with something? Kill it. And here goes the
killing session:

    a02 select INBOX
    * 1234 EXISTS
    * 0 RECENT
    * FLAGS (\Seen \Answered \Flagged \Deleted \Draft $MDNSent)
    * OK [PERMANENTFLAGS (\Seen \Answered \Flagged \Deleted \Draft $MDNSent)] Permanent flags
    * OK [UNSEEN 1045] Is the first unseen message
    * OK [UIDVALIDITY 14] UIDVALIDITY value
    * OK [UIDNEXT 16133] The next unique identifier value
    a02 OK [READ-WRITE] SELECT completed.
    a03 fetch 1045 (uid)
    * 1045 FETCH (UID 15541)
    a03 OK FETCH completed.
    a04 uid fetch 15541 (uid flags)
    * 1045 FETCH (UID 15541 FLAGS ())
    a04 OK FETCH completed.
    a05 store 1045 +flags (\Deleted)
    * 1045 FETCH (FLAGS (\Deleted))
    a05 OK STORE completed.
    a06 fetch 1045 (uid)
    * 1045 FETCH (UID 15541)
    a06 OK FETCH completed.
    a07 expunge
    * 1045 EXPUNGE
    * 1233 EXISTS
    a07 OK EXPUNGE completed.
    a08 fetch 1040:1050 (uid)
    * 1040 FETCH (UID 15500)
    * 1041 FETCH (UID 15507)
    * 1042 FETCH (UID 15514)
    * 1043 FETCH (UID 15516)
    * 1044 FETCH (UID 15523)
    * 1045 FETCH (UID 15544)
    * 1046 FETCH (UID 15545)
    * 1047 FETCH (UID 15553)
    * 1048 FETCH (UID 15561)
    * 1049 FETCH (UID 15562)
    * 1050 FETCH (UID 15585)
    a08 OK FETCH completed.
    a09 logout
    * BYE Microsoft Exchange Server 2013 IMAP4 server signing off.
    a09 OK LOGOUT completed.

The killing was done by first tagging the message for deletion, (`a05 store 1045
+flags (\Deleted)`). Then by expunging it: `a07 expunge`. This was the most
scary part, expunge take no arguments, just expunge. It kills the messages
flagged for deletion, similar to the behavior in popular user agents. The RFC
said that this is how it works, so I trusted them.

## Conclusion ##

Since the culprit message has been killed, there is no more tracebacks raised on
me. That is a relief bigger than the disappointment by not understanding what
was going on with that message.

I can have a theory on what this mail is, and maybe I would guess that it is a
sort of auto-reply that happens when a mail cannot be sent. What do I know?

However, next time I am better armed to discuss with the IT department. I will
have a manual IMAP session and give them the output. Maybe then they can extract
that message and see what it is. We will see.

------------------------------------------------------------------------
Happy OfflineIMAPing!
