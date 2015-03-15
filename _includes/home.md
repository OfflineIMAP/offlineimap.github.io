
{% assign links = site.data.links %}
{% assign latest = site.data.latest %}


<!--

Duplicate the less possible information that should stand in the README at
Github.

-->

{: .metainfo}
Latest rc: [{{ latest.rc }}](https://github.com/OfflineIMAP/offlineimap/releases/tag/{{ latest.rc }})
Latest stable: [{{ latest.stable }}](https://github.com/OfflineIMAP/offlineimap/releases/tag/{{ latest.stable }})

![OfflineIMAP logo]({{ links.logos.scalable }})


# Introduction

OfflineIMAP is a *GPLv2 software* to dispose your mailbox*(es)* as a local Maildir*(s)*.

For example, this allows reading the mails while offline without the need for your mail reader (MUA) to support disconnected operations.

OfflineIMAP will synchronize both sides via *IMAP*.


# Project

Checkout the [OfflineIMAP official project]({{ links.offlineimap.project }}).

# Download

Download releases as [tarball or zipball]({{ links.offlineimap.downloads }}).



<!--
vim: spelllang=en ts=2 expandtab:
-->
