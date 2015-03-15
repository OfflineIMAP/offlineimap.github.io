---
layout: page
title: Documentation
---
{% assign links = site.data.links %}

* junk
{:toc}

---

## Changelogs

- [Changelog of mainline]({{ site.base }}/doc/Changelog.html) *(active branch, recommended)*
- [Changelog of stable branch]({{ site.base }}/doc/Changelog.maint.html) *(previous branch, deprecated)*

## OfflineIMAP

- [Installation]({{ site.base }}/doc/installation.html)
- [Quick Start]({{ site.base }}/doc/quick_start.html)
- [Configuration Examples]({{ site.base }}/doc/conf_examples.html)
- [How to make backups properly]({{ site.base }}/doc/backups.html)
- [Frequently Ask Questions]({{ site.base }}/doc/FAQ.html)

- [Features]({{ site.base }}/doc/features.html) *(old)*

### OfflineIMAP advanced

- [Folder filtering and nametrans]({{ site.base }}/doc/nametrans.html)
- [Some real use cases]({{ site.base }}/doc/use_cases.html)

## Documentation for contributors

<!--
Don't change the fixed id: there is a reference to here from the about page.
-->

### Users

{: #updating-website}
#### Updating the website

* [Quick start]({{ site.base }}/doc/website-quick-start.html)

#### Updating the wiki

* [How to contribute the wiki]({{ site.base }}/doc/contribute-wiki.html)

### Developers

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

- [Make a new release]({{ site.base }}/doc/make-new-release.html)
- [Maintain the website]({{ site.base }}/doc/maintain-website.html) *(TODO, 404)*
- [Maintain the wiki]({{ site.base }}/doc/maintain-wiki.html)


<!-- DEBUG

{% for doc in site.doc %}
{{ doc.title }}: {{ doc.url }}
{% endfor %}

-->



<!--
vim: ts=2 expandtab
-->
