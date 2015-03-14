---
layout: page
title: Sending patches, a longer introduction
---
{% assign icons = site.data.icons %}


{: .note}
People on the mailing list need to be able to read and comment on the changes you are submitting.  It is important for a developer to be able to "quote" your changes, using standard e-mail tools, so that they may comment on specific portions of your code.  For this reason, all patches should be submitted "inline".

{: .warning}
{{ icons.warning }} WARNING: {{ icons.end }}
Be wary of your MUAs word-wrap corrupting your patch.  Do not cut-n-paste your patch; you can lose tabs that way if you are not careful.

### Prefixes

It is a common convention to prefix your subject line with `[PATCH]`.  This lets people easily distinguish patches from other e-mail discussions.

Use of additional markers after `PATCH` and the closing bracket to mark the nature of the patch is also encouraged.  E.g. `[PATCH/RFC]` is often used when the patch is not ready to be applied but it is for discussion, `[PATCH v2]`, `[PATCH v3]` etc. are often seen when you are sending an update to what you have previously sent.


### Format patches

* ``git format-patch`` command follows the best current practice to format the body of an e-mail message.  At the beginning of the patch should come your commit message, ending with the ``Signed-off-by:`` lines, a line that consists of three dashes, followed by the diffstat information and the patch itself.

* If you are forwarding a patch from somebody else, optionally, at the beginning of the e-mail message just before the commit message starts, you can put a ``From:`` line to name that person.

* You often want to add additional explanation about the patch, other than the commit message itself.  Place such "cover letter" material between the three dash lines and the diffstat.

  * Short sample:

        [PATCH] subject of a great change

        This is the long and detailed explanation of this patch.
        It has multiple lines.

        Signed-off-by: Long Name <my@mail.com>
        ---

        Here is the cover letter. Above is the three dash line.
        Lines here are ignored when the patch will be applied by
        What follows is the diffstat sample.

        file-changed.ext |    1 +
        1 files changed, 1 insertions(+), 0 deletions(-)
  
        diff --git a/file-changed.ext b/file-changed.ext
        index 09aeecf..d9dfc75 100755
        --- a/file-changed.ext
        +++ b/file-changed.ext
        @@ -1025,6 +1025,7 @@ context line."
         #
         # This is a comment in the code
         # of whatever operation.
        +# Added comment.
         #
         EOF

        -- 
        1.7.4.rc2
        the recipient.


  * Long sample:

        [PATCH] subject of a great change

        This is the long and detailed explanation of this patch.
        It has multiple lines.
  
        Signed-off-by: Long Name <my@mail.com>
        ---
  
        Here is the cover letter. Above is the three dash line.
        Lines here are ignored when the patch will be applied by
        the recipient. The following diffstat description would be
        ignored.
  
        A common diff format looks like this:
          1. It is preceded with a "git diff" header, that looks like this:
  
            diff --git a/file-changed.ext b/file-changed.ext
  
          2. It is followed by one or more extended header lines (this
             example shows a merge with two parents):
    
            index <hash>,<hash>..<hash>
            mode <mode>,<mode>..<mode>
            new file mode <mode>
            deleted file mode <mode>,<mode>
    
             The mode <mode>,<mode>..<mode> line appears only if at least one
             of the <mode> is different from the rest. Extended headers with
             information about detected contents movement (renames and copying
             detection) are designed to work with diff of two <tree-ish> and
             are not used by combined diff format.
    
          3. It is followed by two-line from-file/to-file header
    
            --- a/file
            +++ b/file
    
             Similar to two-line header for traditional unified diff format,
             /dev/null is used to signal created or deleted files.
    
          4. Chunk header format is modified to prevent people from accidentally
             feeding it to patch -p1.
    
            @@@ <from-file-range> <from-file-range> <to-file-range> @@@
    
             There are (number of parents + 1) @ characters in the chunk header.
  
        What follows is the diffstat sample.
  
        file-changed.ext |    1 +
        1 files changed, 1 insertions(+), 0 deletions(-)
    
        diff --git a/file-changed.ext b/file-changed.ext
        index 09aeecf..d9dfc75 100755
        --- a/file-changed.ext
        +++ b/file-changed.ext
        @@ -1025,6 +1025,7 @@ context line."
         #
         # This is a comment in the code
         # of whatever operation.
        +# Added comment.
         #
         EOF
  
        -- 
        1.7.4.rc2


### Other notes



* Do not attach the patch as a MIME attachment, compressed or not.  Many popular e-mail applications will not always transmit a MIME attachment as plain text, making it impossible to comment on your code.  A MIME attachment also takes a bit more time to process.  This does not decrease the likelihood of your MIME-attached change being accepted, but it makes it more likely that it will be postponed.

  *Exception:*  If your mailer is mangling patches then someone may ask you to re-send them using MIME, that is OK.

* Do not let your e-mail client send quoted-printable.

* Do not let your e-mail client send `format=flowed` which would destroy whitespaces in your patches.

* Do not PGP sign your patch, at least for now.  Most likely, your maintainer or other people on the list would not have your PGP key and would not bother obtaining it anyway.  Your patch is not judged by who you are; a good patch from an unknown origin has a far better chance of being accepted than a patch from a known, respected origin that is done poorly or does incorrect things.

  If you really really really really want to do a PGP signed patch, format it as "`multipart/signed`", not a text/plain message that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is not a text/plain, it's something else.

* Unless your patch is a very trivial and an obviously correct one, first send it with "`To:`" set to the mailing list, with "`cc:`" listing people who are involved in the area you are touching (the output from "`git blame $path`" and "`git shortlog --no-merges $path`" would help to identify them), to solicit comments and reviews.  After the list reached a consensus that it is a good idea to apply the patch, re-send it with "`To:`" set to the maintainer and optionally "`cc:`" the list for inclusion.  Do not forget to add trailers such as "`Acked-by:`", "`Reviewed-by:`" and "`Tested-by:`" after your "`Signed-off-by:`" line as necessary.

<!--
vim: expandtab ts=2 :
-->
