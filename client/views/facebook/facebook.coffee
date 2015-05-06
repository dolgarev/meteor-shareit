Template.shareit_facebook.rendered = ->
  return unless @data

  attach_share_handler = _.once (handler) ->
    Template.instance().$('.fb-share').click handler if _.isFunction handler

  @autorun ->    
    data = Template.currentData()

    $('meta[property^="og:"]').remove()
    #
    # OpenGraph tags
    #
    $('<meta>', { property: 'og:type', content: 'article' }).appendTo 'head'
    $('<meta>', { property: 'og:site_name', content: location.hostname }).appendTo 'head'

    url = data.facebook?.url || data.url || location.href
    $('<meta>', { property: 'og:url', content: url }).appendTo 'head'

    title = data.facebook?.title || data.title
    $('<meta>', { property: 'og:title', content: title }).appendTo 'head' if title

    description = data.facebook?.description || data.excerpt || data.description || data.summary
    $('<meta>', { property: 'og:description', content: description }).appendTo 'head' if description

    author = data.facebook?.author || data.author
    $('<meta>', { property: 'article:author', content: author }).appendTo 'head' if author

    publisher = data.facebook?.publisher || data.publisher
    $('<meta>', { property: 'article:publisher', content: publisher }).appendTo 'head' if publisher

    if data.thumbnail
      img = if _.isFunction data.thumbnail then data.thumbnail() else data.thumbnail
    if img
      img = location.origin + img unless /^http(s?):\/\/+/.test(img)
      $('<meta>', { property: 'og:image', content: img }).appendTo 'head'

    if ShareIt.settings.sites.facebook.appId?
      $('<meta>', { property: 'fb:app_id', content: ShareIt.settings.sites.facebook.appId }).appendTo 'head'
      attach_share_handler (evt) ->
        evt.preventDefault()
        FB.ui
          method: 'share'
          display: 'popup'
          href: url
        , 
          (response) ->
            console.log 'response', response
    else
      href = "https://www.facebook.com/sharer/sharer.php?s=100&p[url]=#{encodeURIComponent url}&p[title]=#{encodeURIComponent title}&p[summary]=#{encodeURIComponent description}"
      href += "&p[images][0]=#{encodeURIComponent img}" if img

      Template.instance().$(".fb-share").attr "href", href

Template.shareit_facebook.helpers ShareIt.helpers
