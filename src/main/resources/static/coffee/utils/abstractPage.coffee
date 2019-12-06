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
        
    pageHTML: () ->
        @container.html(@_customHTML())

    emptyState: () ->
        return ''
        
    _customHTML: () ->
        return ''

    _loadingPage: () ->
        @container.html(ComponentsUtils.loadingPage()) 
