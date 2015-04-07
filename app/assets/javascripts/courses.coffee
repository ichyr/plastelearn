# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

index_courses_ready = ->
    $('.index_course_list .pagination a').click (e) ->
      e.preventDefault()
      $.getScript @href
      false

    $('.index_course_list #course_index_search_form').submit ->
      $.get $('#course_index_search_form').attr('action'), $('#course_index_search_form').serialize(), null, 'script'
      false

    return

$(document).on "ready page:update", index_courses_ready