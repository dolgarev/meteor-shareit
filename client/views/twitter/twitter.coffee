Template.shareit_twitter.rendered = ->
  return unless @data

  @autorun ->
    template = Template.instance()
    data = Template.currentData()
    $('meta[property^="twitter:"]').remove()

    #
    # Twitter cards
    #
    $('<meta>', { property: 'twitter:card', content: 'summary' }).appendTo 'head'
    # What should go here?
    #$('<meta>', { property: 'twitter:site', content: '' }).appendTo 'head'

    url = data.twitter?.url || data.url || location.origin + location.pathname
    $('<meta>', { property: 'twitter:url', content: url }).appendTo 'head'

    author = data.twitter?.author || data.author
    $('<meta>', { property: 'twitter:creator', content: author }).appendTo 'head' if author
      
    title = data.twitter?.title || data.title
    $('<meta>', { property: 'twitter:title', content: title }).appendTo 'head' if title

    description = data.twitter?.description || data.excerpt || data.description || data.summary
    $('<meta>', { property: 'twitter:description', content: description }).appendTo 'head' if description

    if data.thumbnail
      img = if _.isFunction data.thumbnail then data.thumbnail() else data.thumbnail  
      if img
        img = location.origin + img unless /^http(s?):\/\/+/.test(img)          
        $('<meta>', { property: 'twitter:image', content: img }).appendTo 'head'

    #
    # Twitter share button
    #
    href = "https://twitter.com/intent/tweet?url=#{encodeURIComponent url}&text=#{encodeURIComponent title}"

    hashtags = data.twitter?.hashtags || data.hashtags
    href += "&hashtags=#{encodeURIComponent hashtags}" if hashtags

    href += "&via=#{encodeURIComponent author}" if author
      
    template.$(".tw-share").attr "href", href


Template.shareit_twitter.helpers ShareIt.helpers
