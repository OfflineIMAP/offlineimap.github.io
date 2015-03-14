---
layout: page
title: Documentation
---
{% assign links = site.data.links %}

## User documentation

- [Installation]({{ site.base }}/doc/installation.html)
- [Quick Start]({{ site.base }}/doc/quick_start.html)
- [Configuration Examples]({{ site.base }}/doc/conf_examples.html)
- [Frequently Ask Questions]({{ site.base }}/doc/FAQ.html)

- [Features]({{ site.base }}/doc/features.html) *(old)*

### User advanced

- [Folder filtering and nametrans]({{ site.base }}/doc/nametrans.html)
- [Some real use cases]({{ site.base }}/doc/use_cases.html)

## Changelogs

- [Changelog of mainline]({{ site.base }}/doc/Changelog.html) *(active branch, recommended)*
- [Changelog of stable branch]({{ site.base }}/doc/Changelog.maint.html) *(previous branch, deprecated)*

## Developer documentation

- [Coding guidelines]({{ site.base }}/doc/CodingGuidelines.html)
- [Git Advanced]({{ site.base }}/doc/GitAdvanced.html)

### OfflineIMAP's APIs

<ul>
  {% for version in site.data.versions %}
  <li>
    <a href="{{ site.base }}/doc/versions/{{ version }}">{{ version }}</a>
  </li>
  {% endfor %}
</ul>

## Maintainers documentation

*TODO*

<!-- DEBUG

{% for doc in site.doc %}
{{ doc.title }}: {{ doc.url }}
{% endfor %}

-->


<!--
Don't change the fixed id: there is a reference to here from the about page.
-->

{: #updating-website}
## Updating the website

* [Quick start]({{ site.base }}/doc/website-quick-start.html)

<!--
vim: ts=2 expandtab
-->
