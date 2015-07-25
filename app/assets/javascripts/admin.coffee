# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

admin_courses_ready = ->
    $('.admin-courses-list .pagination a').click (e) ->
      e.preventDefault()
      $.getScript @href
      console.log("data inputted => trigger 1")
      false

    $('.admin-courses-list #course_admin_search_form').submit ->
      $.get $('#course_admin_search_form').attr('action'), $('#course_admin_search_form').serialize(), null, 'script'
      false

    $('.admin-user-list .pagination a').click (e) ->
      e.preventDefault()
      $.getScript @href
      console.log("data inputted => trigger 1")
      false

    $('.admin-user-list #course_admin_search_form').submit ->
      $.get $('#course_admin_search_form').attr('action'), $('#course_admin_search_form').serialize(), null, 'script'
      false

    return

$(document).on "ready page:update", admin_courses_ready