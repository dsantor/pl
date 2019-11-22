class @BidsResultPage extends AbstractDialog

    constructor: (@parentPage) ->
        super()
    destroy: () ->
        @parentPage = null
        super()

    show: () ->
        super()

    hide: () ->
        super()

    _customHTML: () ->
        return 'hehe'