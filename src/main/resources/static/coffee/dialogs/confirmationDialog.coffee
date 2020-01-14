class @ConfirmationDialog

    constructor: (@parentPage) ->
        @container = $('.js--confirmation--dialog--container')
        @message = @container.find('.js--confirmation--dialog--message')

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

    destroy: () ->
        @container  = null
        @message    = null

        @container.off 'click', @clickEvent
        @clickEvent = null
        @parentPage = null
        @onTheFlyData = null

    show: (message, @onTheFlyData) ->
        @message.html(message)
        @container.attr('visibility', true)

    hide: () ->
        @container.attr('visibility', false)

    _clickEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--confirmation--dialog--positive--action')
            @positiveAction()
            return
        
        if closest(target, '.js--confirmation--dialog--negative--action')
            @negativeAction()
            return
        
    positiveAction: () ->
        @parentPage.confirmationDialogResponse(true, @onTheFlyData)
        @hide()

    negativeAction: () ->
        @parentPage.confirmationDialogResponse(false)
        @hide()

    