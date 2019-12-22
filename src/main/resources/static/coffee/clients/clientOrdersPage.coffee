class @ClientOrdersPage extends AbstractPage

    constructor: (clientId) ->
        super()
        console.log clientId
        OrderService.getAllClientOrders(clientId, null, this, @_ordersLoaded, @_ordersLoadedError)

    destroy: () ->
        super()

    _ordersLoaded: (response) ->
        console.log response