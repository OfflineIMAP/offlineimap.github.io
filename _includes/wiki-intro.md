
## Introduction

[The wiki]({{ wiki.site }}) is a usual Git repository while it's not a Github project.

There are 3 URL associated with it:
- <{{ wiki.project }}>, online HTTP URL for web browsers
- <{{ wiki.repo.http }}>, URL to the sources (.git, HTTP protocol) allows `git clone`
- <{{ wiki.repo.git }}>, URL to the sources (.git, Git protocol) allows `git push`

So, here is what users can do:

- non Github users:
  - clone
  - change locally
  - put it somewhere else
  - raw git pull requests

- Github users:
  - all the above
  - oneline edit
  - push to it directly (?)

- team maintainers:
  - push


The problem is that users are more used to Github projects, with pull requests available. So, to open the contributions, I made a mirror of the sources.

There are 3 more available URL:

- <{{ wiki.copy.project }}>
- <{{ wiki.copy.repo.http }}>
- <{{ wiki.copy.repo.git }}>

This enable more, especially for the Github users:

- better visibility (a classic Github project is on the projects page)
- Github fork
- Github pull requests



<!--
vim: expandtab ts=2 :
-->
