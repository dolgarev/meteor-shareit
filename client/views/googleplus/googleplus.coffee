Template.shareit_googleplus.onRendered ->
  return unless @data

  @autorun ->
    template = Template.instance()
    data = Template.currentData()
    $('meta[itemscope]').remove()

    #
    # Schema tags
    #
    description = data.googleplus?.description || data.excerpt || data.description || data.summary
    url = data.url || Shareit.location.origin() + Shareit.location.pathname()
    title = data.title
    itemtype = data.googleplus?.itemtype || 'Article'
    $('html').attr('itemscope', '').attr('itemtype', "http://schema.org/#{itemtype}")
    $('<meta>', { itemprop: 'name', content: Shareit.location.hostname() }).appendTo 'head'
    $('<meta>', { itemprop: 'url', content: url }).appendTo 'head'
    $('<meta>', { itemprop: 'description', content: description }).appendTo 'head'

    if data.thumbnail
      if typeof data.thumbnail == "function"
        img = data.thumbnail()
      else
        img = data.thumbnail
    if img
      if not /^http(s?):\/\/+/.test(img)
        img = Shareit.location.origin() + img

    $('<meta>', { itemprop: 'image', content: img }).appendTo 'head'
    #
    # Google share button
    #

    href = "https://plus.google.com/share?url=#{url}"
    template.$(".googleplus-share").attr "href", href

Template.shareit_googleplus.helpers(ShareIt.helpers)
