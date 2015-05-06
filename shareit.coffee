ShareIt =
  settings:
    autoInit: true
    buttons: 'responsive'
    sites:
      'facebook':
        'appId': null
        'version': 'v2.3'
        'description': ''
      'twitter':
        'description': ''
      'googleplus':
        'description': ''
      'pinterest':
        'description': ''
      'instagram':
        'description': ''
    siteOrder: []
    classes: "large btn"
    iconOnly: false
    faSize: ''
    faClass: ''
    applyColors: true

  configure: (hash) ->
    $.extend true, @settings, hash

  helpers:
    classes: ->
      ShareIt.settings.classes
    showText: ->
      not ShareIt.settings.iconOnly
    applyColors: ->
      ShareIt.settings.applyColors
    faSize: ->
      ShareIt.settings.faSize
    faClass: ->
      ShareIt.settings.faClass and "-#{ShareIt.settings.faClass}" or ""

@ShareIt = ShareIt

ShareIt.init = (hash) ->
  @configure hash if hash?

  script_loader = (url, id, d = document) ->
    unless d.getElementById id
      fjs = d.getElementsByTagName('script')[0]
      js = d.createElement 'script'
      js.async = true
      js.id = id
      js.src = url
      fjs.parentNode.insertBefore js, fjs

  # Twitter    
  script_loader '//platform.twitter.com/widgets.js', 'twitter-wjs'

  # Facebook
  $('<div id="fb-root"></div>').appendTo 'body' unless $('#fb-root').length
  if ShareIt.settings.autoInit
    window.fbAsyncInit = ->
      if ShareIt.settings.sites?.facebook
        FB.init ShareIt.settings.sites.facebook

  script_loader '//connect.facebook.net/en_US/sdk.js', 'facebook-jssdk'
