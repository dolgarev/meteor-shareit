Template.shareit_twitter.onRendered ->
  return unless @data

  @autorun ->
    data = Template.currentData()
    $('meta[property^="twitter:"]').remove()

    #
    # Twitter cards
    #
    $('<meta>', { property: 'twitter:card', content: 'summary' }).appendTo 'head'
    # What should go here?
    #$('<meta>', { property: 'twitter:site', content: '' }).appendTo 'head'

    url = data.twitter?.url || data.url
    url = if _.isString(url) and url.length then url else ShareIt.location.origin() + ShareIt.location.pathname()
    $('<meta>', { property: 'twitter:url', content: url }).appendTo 'head'

    author = data.twitter?.author || data.author
    if _.isString(author) and author.length
      $('<meta>', { property: 'twitter:creator', content: author }).appendTo 'head'
    else
      author = ''
      
    title = data.twitter?.title || data.title
    if _.isString(title) and title.length
      $('<meta>', { property: 'twitter:title', content: title }).appendTo 'head'
    else
      title = ''

    description = data.twitter?.description || data.excerpt || data.description || data.summary
    if _.isString(description) and description.length
      $('<meta>', { property: 'twitter:description', content: description }).appendTo 'head'
    else
      description = ''

    if data.thumbnail?
      img = if _.isFunction data.thumbnail then data.thumbnail() else data.thumbnail  
      if _.isString(img) and img.length
        img = ShareIt.location.origin() + img unless /^http(s?):\/\/+/.test(img)          
        $('<meta>', { property: 'twitter:image', content: img }).appendTo 'head'
      else
        img = ''

    #
    # Twitter share button
    #
    href = "https://twitter.com/intent/tweet?url=#{encodeURIComponent url}&text=#{encodeURIComponent title}"

    hashtags = data.twitter?.hashtags || data.hashtags
    href += "&hashtags=#{encodeURIComponent hashtags}" if _.isString(hashtags) and hashtags.length
    href += "&via=#{encodeURIComponent author}" if author
      
    Template.instance().$(".tw-share").attr "href", href

Template.shareit_twitter.helpers ShareIt.helpers
