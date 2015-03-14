---
---

# Allow exporting variables via 'root'.
root = exports ? this

#
# Feed commits. See https://github.com/sdepold/jquery-rss
#
# Set user avatar.
# Todo: cache img.
commitsSuccess =  () ->
  $("#feed-commits > ul").find('li').each( () ->
    img = $(this).find('img')

    username = img.attr('data')
    if username != ''
      $.getJSON('https://api.github.com/users/' + username).done(
        (json) ->
            img.attr('src', json.avatar_url)
      )
    # Author is not known in Github. (not tested)
    else
      $(this).find('i').html().replace(/by ,/i, '')
  )

# -- Valid tokens --
# url: the url to the post
# author: the author of the post
# date: the publishing date
# title: the title of the post
# body: the complete content of the post
# shortBody: the shortened content of the post
# bodyPlain: the complete content of the post without html
# shortBodyPlain: the shortened content of the post without html
# teaserImage: the first image in the post's body
# teaserImageUrl: the url of the first image in the post's body
# index: the index of the current entry
# totalEntries: the total count of the entries
# feed: contains high level information of the feed (e.g. title of the website)
newsRSS = (divid, url, entryTemplate, success) ->
  $(divid).rss(
    url
    {
      limit: 20
      # default: "<ul>{entries}</ul>"
      #layoutTemplate: "<div class='commit-container'>{entries}</div>",
      # default: '<li><a href="{url}">[{author}@{date}] {title}</a><br/>{shortBodyPlain}</li>'
      entryTemplate: entryTemplate
      # valid values: any object/hash
      tokens: {
      }

      # output mode of google feed loader request
      # default: 'json'
      # valid values: 'json', 'json_xml'
      outputMode: 'json_xml'

      # formats the date with moment.js
      # default: 'dddd MMM Do'
      # valid values: see http://momentjs.com/docs/#/displaying/
      dateFormat: 'YYYY-MM-DD'

      # the effect, which is used to let the entries appear
      # default: 'show'
      # valid values: 'show', 'slide', 'slideFast', 'slideSynced', 'slideFastSynced'
      effect: 'show' # Effects are distracting...

      # a callback, which gets triggered when an error occurs
      # default: function() { throw new Error("jQuery RSS: url don't link to RSS-Feed") }
      #error: function(){},

      # a callback, which gets triggered when everything was loaded successfully
      # this is an alternative to the next parameter (callback function)
      # default: function(){}
      #success: function(){},
      success: success
      # a callback, which gets triggered once data was received but before the rendering.
      # this can be useful when you need to remove a spinner or something similar
      #onData: function(){}
    }

    # callback function
    # called after feeds are successfully loaded and after animations are done
    #function callback() {}
  )

#
# Make variables accessibles from other files.
#
unless root.newsRSS
  root.newsRSS = newsRSS
unless root.commitsSuccess
  root.commitsSuccess = commitsSuccess


# vim: ts=2 expandtab :
