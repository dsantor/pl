class @BidsResultPage extends AbstractDialog

    constructor: (@parentPage) ->
        super()
        @negativeButtonVisibility(false)
        @positiveButtonText('Zatvori')

    destroy: () ->
        @parentPage = null
        super()

    show: () ->
        super()

    hide: () ->
        super()

    _customHTML: () ->
        return 'hehe'