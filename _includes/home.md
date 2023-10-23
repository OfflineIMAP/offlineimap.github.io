
{% assign links = site.data.links %}
{% assign latest = site.data.latest %}


<!--

Duplicate the less possible information that should stand in the README at
Github.

-->

{: .metainfo}
Latest stable: [{{ latest.stable }}](https://github.com/OfflineIMAP/offlineimap3/releases/tag/{{ latest.stable }})

{:style="float: left; margin-right: 20px; width: 30px;"}
![OfflineIMAP logo]({{ links.logos.scalable }})

{:style="float: left; margin-right: 20px;"}
<a class="github-button"
href="https://github.com/OfflineIMAP/offlineimap3/fork"
data-icon="octicon-repo-forked" data-style="mega"
data-count-href="/OfflineIMAP/offlineimap3/network"
data-count-api="/repos/OfflineIMAP/offlineimap3#forks_count"
data-count-aria-label="# forks on GitHub" aria-label="Fork
OfflineIMAP/offlineimap3 on GitHub">Fork</a>

<a class="github-button" href="https://github.com/OfflineIMAP/offlineimap3"
data-icon="octicon-star" data-style="mega"
data-count-href="/OfflineIMAP/offlineimap3/stargazers"
data-count-api="/repos/OfflineIMAP/offlineimap3#stargazers_count"
data-count-aria-label="# stargazers on GitHub" aria-label="Star
OfflineIMAP/offlineimap3 on GitHub">Star</a>

<script async defer id="github-bjs" src="https://buttons.github.io/buttons.js"></script>


> ***"Get the emails where you need them."***

[![Gitter](https://badges.gitter.im/OfflineIMAP/offlineimap3.svg)](https://gitter.im/OfflineIMAP/offlineimap3?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Introduction

OfflineIMAP is a *GPLv2 software* to dispose your mailbox*(es)* as a local Maildir*(s)*.

For example, this allows reading the mails while offline without the need for
your mail reader (MUA) to support disconnected operations.

OfflineIMAP will synchronize both sides via *IMAP*.

# Project

Checkout the [OfflineIMAP official project]({{ links.offlineimap.project }}) in Github.

> **Side note from a maintainer:**
While I'm still maintaining OfflineIMAP, I'm mostly focusing on [imapfw]({{
links.imapfw.website }}) which I intend to come as a replacement in the long term.
\\
― Nicolas Sebrecht

# Download

Download releases as [tarball or zipball]({{ links.offlineimap.downloads }}).

# Contributions

<iframe frameborder="0" width="480" height="270"
src="//www.dailymotion.com/embed/video/x3usii9" allowfullscreen></iframe>

{:style="color: gray;"}
*13 years of history in less than 45 seconds.*


<!--
vim: spelllang=en ts=2 expandtab:
-->
