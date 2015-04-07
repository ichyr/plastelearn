# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

user_cabinet_ready = ->
    $('#course_table .pagination a').click (e) ->
      e.preventDefault()
      $.getScript @href
      false

    $('#course_table #user_cabinet_search').submit ->
      $.get $('#user_cabinet_search').attr('action'), $('#user_cabinet_search').serialize(), null, 'script'
      false

    return

$(document).on "ready page:update", user_cabinet_ready