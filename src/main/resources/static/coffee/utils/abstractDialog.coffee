class @AbstractDialog

    constructor: () ->
        @JS_NEGATIVE_BUTTON = '.' + ComponentsUtils.NEGATIVE_BUTTON
        @JS_POSITIVE_BUTTON = '.' + ComponentsUtils.POSITIVE_BUTTON

        @JS_NEGATIVE_BUTTON_TEXT = "Otkazi"
        @JS_POSITIVE_BUTTON_TEXT = "Sacuvaj"

        @JS_NEGATIVE_BUTTON_VISIBILITY = ''
        @JS_POSITIVE_BUTTON_VISIBILITY = ''

        @container = $('.js--side--dialog--container')

    show: () ->
        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

        @loadingPageHTML()
        #@container.html(@_templateHTML())
        @container.attr('visibility', true)

    hide: () ->
        @container.attr('visibility', false)
        @container.off 'click', @clickEvent
        @clickEvent = null

    destroy: () ->
        @hide()
        @container.html('')
        @container = null


    positiveButtonVisibility: (visible = true) ->
        if visible
            @JS_POSITIVE_BUTTON_VISIBILITY = ''
        else
            @JS_POSITIVE_BUTTON_VISIBILITY = 'hide'

    negativeButtonVisibility: (visible = true) ->
        if visible
            @JS_NEGATIVE_BUTTON_VISIBILITY = ''
        else
            @JS_NEGATIVE_BUTTON_VISIBILITY = 'hide'

    positiveButtonText: (text) ->
        @JS_POSITIVE_BUTTON_TEXT = text

    negativeButtonText: (text) ->
        @JS_NEGATIVE_BUTTON_TEXT = text

    positiveAction: () ->
        @hide()

    negativeAction: () ->
        @hide()

    _templateHTML: (innerHtml = '') ->
        html = "<div style=background-color:white;>
                    <div class='form-group form-inline header'>
                        <div class='logo-text-icon'>
                        </div>
                        <div>
                            <button class='cbtn btn-light #{ComponentsUtils.NEGATIVE_BUTTON} #{@JS_NEGATIVE_BUTTON_VISIBILITY}'>
                                #{@JS_NEGATIVE_BUTTON_TEXT}
                            </button>
                            <button class='cbtn btn-primary mr-15px #{ComponentsUtils.POSITIVE_BUTTON} #{@JS_POSITIVE_BUTTON_VISIBILITY}'>
                                #{@JS_POSITIVE_BUTTON_TEXT}
                            </button>
                        </div>
                    </div>
                </div>
                #{innerHtml}"
        @container.html(html)

    customHTML: () ->
        @_templateHTML(@_customHTML())
    _customHTML: () ->
        return ''

    loadingPageHTML: () ->
        @_templateHTML("<div><span class='loader-icon'></span></div>")
        
    emptyStateHTML: () ->
        @_templateHTML(@_emptyStateHTML())
    _emptyStateHTML: () ->
        return ''

    _pageClientEventHandler: (event) ->
        return

    _clickEventHandler: (event) ->
        target = $(event.target)

        element = target.closest(@JS_NEGATIVE_BUTTON)
        if element.length > 0
            @negativeAction()
            return
        
        element = target.closest(@JS_POSITIVE_BUTTON)
        if element.length > 0
            @positiveAction()
            return
        
        @_pageClientEventHandler(event)