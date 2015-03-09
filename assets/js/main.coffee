---
---
# vim: ts=2 expandtab syntax=coffee :

# Safe bind $ to jQuery.
(($) -> ) jQuery

#
# linkHeaders
#
linkHeaders = () ->
  console.log('in linkHeaders()')

  $("h2, h3, h4, h5, h6").each(
    (i, el) ->
      console.log('in each() callback()')
      $el = $(el)
      id = $el.attr('id')
      icon = '<i class="fa fa-link"></i>'
      if id
        $el.append(
          $("<a />").addClass("header-link").attr("href", "#" + id).html(icon)
        )
  )


#
# Functions to call once document ready.
#
$ ->
  console.log("in main()")
  linkHeaders()
