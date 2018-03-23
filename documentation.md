---
layout: page
title: Documentation
---

{% assign links = site.data.links %}
{% assign contribs = site.data.contribs %}


## FAQ

[Frequently Ask Questions]({{ site.base }}/doc/FAQ.html)


## Table of content

* junk
{:toc}

---

<!--
Don't change the fixed id: there is a reference to here from the about page.
-->


## Learning with us

- [Be effective]({{ site.base }}/doc/be-effective.html), a 2 minutes guide for hours of time saved (the starting point for everybody new to OfflineIMAP).



## OfflineIMAP

### Starting

- There are good tutorials on the web:
  - [How to use offlineimap on Fedora](https://hobo.house/2015/09/09/take-control-of-your-email-with-mutt-offlineimap-notmuch/)
  - [https://wiki.archlinux.org/index.php/OfflineIMAP](https://wiki.archlinux.org/index.php/OfflineIMAP)
- [Installation]({{ site.base }}/doc/installation.html)
- [Quick Start]({{ site.base }}/doc/quick_start.html)
- [offlineimap.conf](https://github.com/OfflineIMAP/offlineimap/blob/master/offlineimap.conf)
- [Configuration Examples]({{ site.base }}/doc/conf_examples.html)

### Man pages

- [offlineimap(1)]({{ site.base }}/doc/offlineimap.html)
- [offlineimapui(7)]({{ site.base }}/doc/offlineimapui.html)


### Make backups of a mailbox

- [How to make backups properly]({{ site.base }}/doc/backups.html)
- [Restore a backup]({{ site.base }}/doc/backups-restore.html)


### OfflineIMAP advanced

- [Folder filtering and nametrans]({{ site.base }}/doc/nametrans.html)
- [Some real use cases]({{ site.base }}/doc/use_cases.html)
- [Configuration factorization]({{ site.base }}/doc/ConfigurationFactorization.html)
- [Tips and Tricks]({{ site.base }}/doc/tipsandtricks.html)


### User contributions

The source files of the contributions are locally available in `./contrib` or [online, here]({{ links.offlineimap.project }}/tree/next/contrib).

{% for contrib in contribs %}
- [{{ contrib.linkname }}]({{ site.base }}/doc/contrib/{{ contrib.filename }}.html)
{% endfor %}


{: #documentation-for-contributors}
## Contributors

### Users

* [git bisect](/doc/git-bisect.html), how to find the offending patch

{: #updating-website}
* [Update the website]({{ site.base }}/doc/website-quick-start.html)
* [How to contribute the wiki]({{ site.base }}/doc/contribute-wiki.html)


### Testers

- [Testing offlineimap]({{ site.base }}/doc/Testing.html)


### Developers

<!-- TODO: become a developers for OfflineIMAP -->
- [Developer's Certificate of Origin]({{ site.base }}/doc/dco.html) *(important)*
- [Coding guidelines]({{ site.base }}/doc/CodingGuidelines.html)
- [Git Advanced]({{ site.base }}/doc/GitAdvanced.html)

#### Available APIs

<ul>
  {% for version in site.data.versions %}
  <li>
    <a href="{{ site.base }}/doc/versions/{{ version }}">{{ version }}</a>
  </li>
  {% endfor %}
</ul>

### Maintainers

- [Become a maintainer]({{ site.base }}/doc/become-a-maintainer.html)
- [Make a new release]({{ site.base }}/doc/make-new-release.html)
- [Maintain the website]({{ site.base }}/doc/maintain-website.html)
- [Maintain the wiki]({{ site.base }}/doc/maintain-wiki.html)


## Changelogs

- [Changelog of mainline]({{ site.base }}/doc/Changelog.html) *(active branch, recommended)*
- [Changelog of stable branch]({{ site.base }}/doc/Changelog.maint.html) *(previous branch, deprecated)*



<!--
vim: ts=2 expandtab
-->
