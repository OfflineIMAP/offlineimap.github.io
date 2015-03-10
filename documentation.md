---
layout: page
title: Documentation
---
{% assign links = site.data.links %}

## User documentation

- [Installation]({{ site.base }}/doc/installation.html)
- [Quick Start]({{ site.base }}/doc/quick_start.html)
- [Manual]({{ links.offlineimap }}/blob/master/docs/MANUAL.rst) *(at Github)*
- [Configuration Examples]({{ site.base }}/doc/conf_examples.html)
- [Frequently Ask Questions]({{ site.base }}/doc/FAQ.html)

- [Features]({{ site.base }}/doc/features.html) *(old)*

## Developer documentation

Available sphinx documentation:

<ul>
  {% for version in site.data.versions %}
  <li>
    <a href="{{ site.base }}/doc/versions/{{ version }}">{{ version }}</a>
  </li>
  {% endfor %}
</ul>

<!-- DEBUG

{% for doc in site.doc %}
{{ doc.title }}: {{ doc.url }}
{% endfor %}

-->

<!--
vim: ts=2 expandtab
-->
