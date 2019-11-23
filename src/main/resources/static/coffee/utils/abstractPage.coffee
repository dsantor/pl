    class @AbstractPage

        constructor: () ->
            @container = $('.js--page--container')

            @clickEvent = @_clickEventHandler.bind(this)
            @container.on 'click', @clickEvent

        destroy: () ->
            @container.off 'click', @clickEvent
            @clickEvent = null