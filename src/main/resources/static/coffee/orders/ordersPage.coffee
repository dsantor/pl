class @OrdersPage extends AbstractPage

    constructor: () ->
        super()
        OrderService.getAll(null, this, @_ordersLoadedSuccess, ajaxCallbackPrintMessage)

    destroy: () ->
        # super()

    getPageTitle: () ->
        return "Porudzbine"

    _clickEventHandler: (event) ->

    _ordersLoadedSuccess: (response) ->
        @orders = response.data
        console.log @orders
        @pageHTML()
        

    _customHTML: () ->
        tableHtml = ''
        innerHTML = ''
        for order in @orders
            innerHTML += "<tr>
                            <td class='table-text w-20'>
                                <a class='text-decoration-none' href='#order/#{order.id}'>
                                    <span class='d-inline-block align-middle launch-icon'></span>
                                </a>
                                #{order.clientName}
                            </td>
                            <td class='table-text w-20'>#{order.saldo}</td>
                            <td class='table-text w-20'>#{order.paid}</td>
                            <td class='table-text w-20'>#{order.status}</td>
                            <td class='table-text w-20'>#{ComponentsUtils.getTimeFromMillis(order.createdAtMillis)}</td>                            
                        </tr>"
        tableHtml = "<div class='pt-5'>
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
        return tableHtml
    
