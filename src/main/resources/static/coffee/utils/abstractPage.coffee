class @AbstractPage

    constructor: () ->
        @container = $('.js--page--container')
        @_loadingPage()
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

    emptyState: () ->
        return ''
        
    _customHTML: (data) ->
        return ''

    _loadingPage: () ->
        @container.html(ComponentsUtils.loadingPage()) 


    _clickEventHandler: (event) ->