$ ->

  action             = $("body").data("action")
  controller         = $("body").data("controller")
  action_pattern     = new RegExp action
  controller_pattern = new RegExp controller

  $(".nav > li").each (i, nav) ->
    $nav = $(nav)
    nav_text = $nav.text()
    if action_pattern.test nav_text 
      $nav.addClass "active"
    if controller_pattern.test nav_text
      $nav.addClass "active"
