
{% assign links = site.data.links %}
{% assign latest = site.data.latest %}


<!--

Duplicate the less possible information that should stand in the README at
Github.

-->

{: .metainfo}
Latest rc: [{{ latest.rc }}](https://github.com/OfflineIMAP/offlineimap/releases/tag/{{ latest.rc }})
Latest stable: [{{ latest.stable }}](https://github.com/OfflineIMAP/offlineimap/releases/tag/{{ latest.stable }})

{:style="float: left; margin-right: 25px"}
![OfflineIMAP logo]({{ links.logos.scalable }})

{:.buttons :style="float: left;"}
<a class="github-button"
href="https://github.com/OfflineIMAP/offlineimap/fork"
data-icon="octicon-repo-forked" data-style="mega"
data-count-href="/OfflineIMAP/offlineimap/network"
data-count-api="/repos/OfflineIMAP/offlineimap#forks_count"
data-count-aria-label="# forks on GitHub" aria-label="Fork
OfflineIMAP/offlineimap on GitHub">Fork</a>
<a class="github-button" href="https://github.com/OfflineIMAP/offlineimap"
data-icon="octicon-star" data-style="mega"
data-count-href="/OfflineIMAP/offlineimap/stargazers"
data-count-api="/repos/OfflineIMAP/offlineimap#stargazers_count"
data-count-aria-label="# stargazers on GitHub" aria-label="Star
OfflineIMAP/offlineimap on GitHub">Star</a>

<script async defer id="github-bjs" src="https://buttons.github.io/buttons.js"></script>


# Introduction

OfflineIMAP is a *GPLv2 software* to dispose your mailbox*(es)* as a local Maildir*(s)*.

For example, this allows reading the mails while offline without the need for your mail reader (MUA) to support disconnected operations.

OfflineIMAP will synchronize both sides via *IMAP*.


# Project

Checkout the [OfflineIMAP official project]({{ links.offlineimap.project }}) on Github.

# Download

Download releases as [tarball or zipball]({{ links.offlineimap.downloads }}).



<!--
vim: spelllang=en ts=2 expandtab:
-->
