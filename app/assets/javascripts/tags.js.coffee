jQuery ($) ->
  event = if window.hasOwnProperty('ontouchend') then 'touchend' else 'click'
  $('#tags h1').on event, (e) ->
    $(this)
      .toggleClass('opened')
      .next('nav').toggle()
