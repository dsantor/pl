class @OrdersPage extends AbstractPage

    constructor: (clientId, container) ->
        super()
        @pageHTML()
        if clientId
            OrderService.getAllClientOrders(clientId, null, this, @_ordersLoadedSuccess, ajaxCallbackPrintMessage)
        else
            OrderService.getAll(null, this, @_ordersLoadedSuccess, ajaxCallbackPrintMessage)
        
        @ordersContainer = @container.find('.js--orders--container')
        @filterContainer = @container.find('.js--filter--container--wrapper')
        filterStatus = [{key: 'all', value: 'Svi'}, {key: 'paid', value: 'Plaćeno'}, {key: 'unpaid', value: 'Neplaćeno'}]
        @autoSuggestion = new AutoSuggestion(this, @filterContainer, AutoSuggestion.ORDER_FILTER, filterStatus)
        @asInput = @container.find('.js--filter--as')
        @filterFrom = @container.find('.js--filter--from')
        @filterTo = @container.find('.js--filter--to')

        @suggestionsContainer = @container.find('.js--filter--suggestions')
        @status = @container.find('.js--filter--status')        
        @filterToggleButton = @container.find('.js--filters--content')
    destroy: () ->
        super()

    getPageTitle: () ->
        return "Porudzbine"

    _clickEventHandler: (event) ->

    _ordersLoadedSuccess: (response) ->
        @orders = response.orders
        @clients = response.clients
        if @orders.length > 0
            @_renderOrdersHTML(@orders)
        else
            @_renderEmptyState()
        
    _renderEmptyState: () ->
        @ordersContainer.html(ComponentsUtils.emptyState('Nema porudžbenica :('))

    _customHTML: () ->
        return "<div class='js--filter--container--wrapper pt-5'></div>
                <div class='js--orders--container'>
                    #{ComponentsUtils.loadingPage()}
                </div>"
    
    _renderOrdersHTML: (orders) ->
        tableHtml = ''
        innerHTML = ''
        for order in orders
            innerHTML += "<tr>
                            <td class='table-text w-20'>
                                <a class='text-decoration-none' href='#order/#{order.id}'>
                                    <span class='d-inline-block align-middle launch-icon'></span>
                                </a>
                                #{order.clientFullName}
                            </td>
                            <td class='table-text w-20'>#{order.saldo}</td>
                            <td class='table-text w-20'>#{order.paid}</td>
                            <td class='table-text w-20'>#{order.status}</td>
                            <td class='table-text w-20'>#{ComponentsUtils.getTimeFromMillis(order.createdAtMillis)}</td>                            
                        </tr>"
        tableHtml = "<div>
                        <table class='table mb-0'>
                            <tr>
                                <th class='table-text w-20'>Poručilac</th>
                                <th class='table-text w-20'>Cena</th>
                                <th class='table-text w-20'>Uplaćeno</th>
                                <th class='table-text w-20'>Status</th>
                                <th class='table-text w-20'>Poručeno</th>
                            </tr>
                        </table>
                        <table class='table table-striped'>
                        #{innerHTML}
                        </table>
                    </div>"
        @ordersContainer.html(tableHtml)
    
    triggerFilterAs: (event) ->
        ComponentsUtils.handleAutoSuggestion(@asInput, 'data-order-id', @clients, @suggestionsContainer, false, this, @_resetFilter)
    
    triggerFilterSuggestions: (event) ->
        ComponentsUtils.selectFromAutoSuggestion($(event.target), @asInput, 'data-order-id', @clients, @suggestionsContainer, @_applyFilter)
        @_applyFilter()

    triggerFilterStatus: (event) ->
        @_applyFilter()

    triggerFilterReset: (event) ->
        @_resetFilter()
        
    triggerFilterFrom: (event) ->
        @_applyFilter()

    triggerFilterTo: (event) ->
        @_applyFilter()

    _applyFilter: () ->
        status = @status.val()
        # @workerASInput.val('') 
        orders = []
        if status == 'all'
            orders = @orders
        else if status == 'paid'
            for order in @orders
                if order.paid == order.saldo
                    orders.push(order)
        else if status == 'unpaid'
            for order in @orders
                if order.paid < order.saldo
                    orders.push(order)

        id = Number(@asInput.attr('data-order-id'))
        if (! isNaN(id)) 
            filteredOrders = []
            for order in orders
                if order.clientId == id 
                    filteredOrders.push(order)
            orders = filteredOrders

        if @filterFrom.val() or @filterTo.val()
            if @filterFrom.val()
                dateFrom = new Date(@filterFrom.val()).getTime()
            else
                dateFrom = new Date('1970').getTime()
            
            if @filterTo.val()
                dateTo = new Date(@filterTo.val()).getTime()
            else
                dateTo = new Date().getTime()

            filteredWithDate = []
            for order in orders
                if order.buildDateMillis >= dateFrom and order.buildDateMillis <= dateTo
                    filteredWithDate.push(order)

            orders = filteredWithDate

        if orders.length is 0
            @ordersContainer.html(@autoSuggestion.emptyState())
        else
            @_renderOrdersHTML(orders)

    _resetFilter: () ->
        @asInput.val('')
        @asInput.removeAttr('data-user-id')
        @status.val(@status[0].options[0].value)
        @_renderOrdersHTML(@orders)
