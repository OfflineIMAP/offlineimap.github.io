---
---


# Allow exporting variables via 'root'.
root = exports ? this

#
# Base class, holds factorized methods common to all kind of feeds.
#
class NsFeed
  constructor: ->
    @data = []
    @formatted = '<p>Could not get JSON</p>'
    @items = []

  getItems: (limit) =>
    if @data
      for i of @data
        if i >= limit
          break
        @items.push @data[i]

  append: (where) ->
    $(where).append(@formatted)

#
# Base class to work on JSON data.
#
class NsJSON extends NsFeed
  constructor: (json) ->
    super()
    @data = json

class Releases extends NsJSON
  getChangelogLink: (version) =>
    pageLink = $('div[id=\'' + version + '\']').attr('link')
    if pageLink
      return '/doc/' + pageLink
    return undefined

  format: =>
    content = ''
    for item in @items
      line = ''
      version = item.name
      version_url = 'https://github.com/OfflineIMAP/offlineimap/tree/' + version
      tarball = item.tarball_url
      zipball = item.zipball_url
      upload_url = 'http://www.offlineimap.org/uploads/offlineimap-' + version + '.tar.gz'
      upload_url_sha1 = upload_url + '.sha1'
      upload_url_sha256 = upload_url + '.sha256'
      upload_url_sha512 = upload_url + '.sha512'

      line += '<a href="' + version_url + '">' + version + '</a> '

      links = ''
      links += '(<a href="' + upload_url + '">official upload</a>: '
      links += '<a href="' + upload_url_sha1 + '">sha1</a>, '
      links += '<a href="' + upload_url_sha256 + '">sha256</a>, '
      links += '<a href="' + upload_url_sha512 + '">sha512</a>) '
      links += '(<a href="' + tarball + '">github tarball</a>) '
      links += '(<a href="' + zipball + '">github zipball</a>) '
      changelogLink = @getChangelogLink(version)
      if changelogLink
        links += '(<a href="' + changelogLink + '">announce</a>) '
      line += '<i>' + links + '</i>'

      line = '<li>' + line + '</li>'
      content += line
    @formatted = '<ul>' + content + '</ul>'
    #console.log(content)

# Add new type of feed here.
#class Whetever extends NsJSON


#
# Download full JSON, limit entries, format and put into HTML.
#
fillerJSON = (url, objType, limit, where) ->
  releases = $.getJSON(url).done(
      (json) =>
        obj = new objType json
        obj.getItems(limit)
        obj.format()
        obj.append(where)
    )

#
# Called from news.html.
#
fillNews = ->
  fillerJSON('https://api.github.com/repos/offlineimap/offlineimap/tags',
    Releases, 14, '#releases')

#
# Make fillNews accessible from other files.
#
unless root.fillNews
  root.fillNews = fillNews

# vim: ts=2 expandtab :
