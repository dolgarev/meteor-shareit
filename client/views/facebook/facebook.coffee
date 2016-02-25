Template.shareit_facebook.onRendered ->
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
    $('<meta>', { property: 'og:site_name', content: ShareIt.location.hostname() }).appendTo 'head'

    url = data.facebook?.url || data.url
    url = if _.isString(url) and url.length then url else ShareIt.location.href()
    $('<meta>', { property: 'og:url', content: url }).appendTo 'head'

    title = data.facebook?.title || data.title
    if _.isString(title) and title.length
      $('<meta>', { property: 'og:title', content: title }).appendTo 'head'
    else
      title = ''

    description = data.facebook?.description || data.excerpt || data.description || data.summary
    if _.isString(description) and description.length
      $('<meta>', { property: 'og:description', content: description }).appendTo 'head'
    else
      description = ''

    author = data.facebook?.author || data.author
    if _.isString(author) and author.length
      $('<meta>', { property: 'article:author', content: author }).appendTo 'head'
    else
      author = ''

    publisher = data.facebook?.publisher || data.publisher
    if _.isString(publisher) and publisher.length
      $('<meta>', { property: 'article:publisher', content: publisher }).appendTo 'head'
    else
      publisher = ''

    if data.thumbnail?
      img = if _.isFunction data.thumbnail then data.thumbnail() else data.thumbnail

      if _.isString(img) and img.length
        img = ShareIt.location.origin() + img unless /^http(s?):\/\/+/.test(img)
        $('<meta>', { property: 'og:image', content: img }).appendTo 'head'
      else
        img = ''

    if ShareIt.settings.sites.facebook.appId?
      $('<meta>', { property: 'fb:app_id', content: ShareIt.settings.sites.facebook.appId }).appendTo 'head'

      attach_share_handler (evt) ->
        evt.preventDefault()
        FB.ui {method: 'share', display: 'popup', href: url}, (res) -> res
    else
      href = "https://www.facebook.com/sharer/sharer.php?s=100&p[url]=#{encodeURIComponent url}&p[title]=#{encodeURIComponent title}&p[summary]=#{encodeURIComponent description}"
      href += "&p[images][0]=#{encodeURIComponent img}" if img

      Template.instance().$(".fb-share").attr "href", href

Template.shareit_facebook.helpers ShareIt.helpers
