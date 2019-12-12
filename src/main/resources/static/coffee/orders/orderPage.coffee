class @OrderPage extends AbstractPage

    constructor: (@orderId) ->
        super()
        console.log @orderId

    destroy: () ->
        super()