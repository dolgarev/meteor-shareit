Template.shareit.helpers
  siteTemplates: ->
    ("shareit_#{site}" for site in ShareIt.settings.siteOrder when ShareIt.settings.sites[site]?)
