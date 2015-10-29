script_loader = (url, id, d = document) ->
  unless d.getElementById id
    fjs = d.getElementsByTagName('script')[0]
    js = d.createElement 'script'
    js.async = true
    js.id = id
    js.src = url
    fjs.parentNode.insertBefore js, fjs


ShareIt =
  settings:
    autoInit: true
    buttons: 'responsive'
    sites:
      facebook:
        'appId': null
        'version': 'v2.3'
        'description': ''
        'buttonText': 'Share on Facebook'
      twitter:
        'description': ''
        'buttonText': 'Share on Twitter'
      googleplus:
        'description': ''
        'buttonText': 'Share on Google+'
      pinterest:
        'description': ''
        'buttonText': 'Share on Pinterest'
      instagram:
        'description': ''
        'buttonText': 'Share on Instagram'
    siteOrder: []
    classes: 'large btn'
    iconOnly: false
    faSize: ''
    faClass: ''
    applyColors: true

  configure: (params) ->
    $.extend true, @settings, params if params?

  helpers:
    classes: -> ShareIt.settings.classes
    showText: (text) -> not ShareIt.settings.iconOnly and " #{text}"
    applyColors: (cssClasses) -> ShareIt.settings.applyColors and " #{cssClasses}"
    faSize: -> ShareIt.settings.faSize
    faClass: -> ShareIt.settings.faClass and "-#{ShareIt.settings.faClass}"
    buttonText: ->
      facebook: ShareIt.settings.sites.facebook.buttonText
      twitter: ShareIt.settings.sites.twitter.buttonText
      googleplus: ShareIt.settings.sites.googleplus.buttonText
      pinterest: ShareIt.settings.sites.pinterest.buttonText
      instagram: ShareIt.settings.sites.instagram.buttonText

  init: (params) ->
    @configure params if params?

    # Twitter    
    script_loader '//platform.twitter.com/widgets.js', 'twitter-wjs'

    # Facebook
    if @settings.autoInit and @settings.sites.facebook?
      window.fbAsyncInit = =>
        FB.init @settings.sites.facebook
          
    $('<div id="fb-root"></div>').appendTo 'body' unless $('#fb-root').get(0)?  
    script_loader '//connect.facebook.net/en_US/sdk.js', 'facebook-jssdk'
