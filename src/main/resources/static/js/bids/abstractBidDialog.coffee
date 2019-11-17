class @AbstractBidDialog

    constructor: () ->
        @JS_NEGATIVE_BUTTON = '.' + ComponentsUtils.NEGATIVE_BUTTON
        @JS_POSITIVE_BUTTON = '.' + ComponentsUtils.POSITIVE_BUTTON
        @container = $('.js--side--dialog--container')

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent


    show: () ->
        @container.html(@_templateHTML())
        @container.attr('visibility', true)

    hide: () ->
        @container.attr('visibility', false)

    destroy: () ->
        @container.off 'click', @clickEvent
        @clickEvent = null
        @container.html('')

    save: () ->
        @hide()

    cancel: () ->
        @hide()

    _templateHTML: () ->

    _clickEventHandler: (event) ->
        target = $(event.target)

        element = target.closest(@JS_NEGATIVE_BUTTON)
        if element.length > 0
            @cancel()
            return
        
        element = target.closest(@JS_POSITIVE_BUTTON)
        if element.length > 0
            @save()
            return