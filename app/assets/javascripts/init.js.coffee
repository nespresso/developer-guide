$(document).ready ->
  # Init your scripts here!
  #
  # Example:
  #
  # $('#some_selector').each ->
  #   new App.ExampleScript @

  $('form.simple_form').each ->
    new App.FormAccessibilizer @

  # Bootstrap tooltips
  $('[title]').tooltip()

  $(document).bind 'keydown', (event) ->
    if event.altKey and event.ctrlKey and event.which is 88 # Ctrl-Alt-X
      $('html').toggleClass('debug')

  # Fancybox
  $('a.fancybox').fancybox
    openSpeed: 0
    closeSpeed: 0
    nextSpeed: 0
    prevSpeed: 0
    helpers:
      overlay:
        locked: false
        speedOut: 0
      thumbs:
        width: 100,
        height: 100
