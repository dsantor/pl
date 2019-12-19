class @AbstractPage

    constructor: () ->
        @container = $('.js--page--container')
        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

    destroy: () ->
        @container.off 'click', @clickEvent
        @clickEvent = null
        @container  = null
    
    getPageTitle: () ->
        return 'Daki plast'
        
    pageHTML: (data) ->
        @container.html(@_customHTML(data))

    _emptyState: () ->
        return ''
        
    emptyState: () ->
        @container.html(@_emptyState())
        
    _customHTML: (data) ->
        return ''

    _loadingPage: () ->
        @container.html(ComponentsUtils.loadingPage()) 


    _clickEventHandler: (event) ->