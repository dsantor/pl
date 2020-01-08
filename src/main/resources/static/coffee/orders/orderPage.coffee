class @OrderPage extends AbstractPage

    constructor: (orderId) ->
        super()
        @order = null
        OrderService.get(orderId, null, this, @_loadedOrder, ajaxCallbackPrintMessage)
        @payOrderDialog = new PayOrderDialog()

    destroy: () ->
        super()
        @order = null
        @payOrderDialog.destroy()
        @payOrderDialog = null

    _loadedOrder: (response) ->
        @order = response.data
        @pageHTML()

    _clickEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--back--button')
            MainNavigation.back()
            return
        
        if closest(target, '.js--paying--order')
            @payOrderDialog.show(@order.id, this)
            return

        if closest(target, '.js--complete--order')
            console.log 'complete order dialog'
            return
    
    _customHTML: () ->
        workersHTML = ''
        keys = Object.keys(@order.workersMap)
        for key in keys
            workersHTML += "<a href='#worker/#{key}'>#{@order.workersMap[key]}</a></br>"
        return "<nav class='nav justify-content-end header pt-3'> 
                    <span class='nav-link span-a back-button js--back--button'>Nazad</span>
                    <span class='nav-link span-a js--paying--order'>Plaćanje</span>
                    <span class='nav-link span-a js--complete--order'>Završi porudžbinu</span>
                </nav>
                <div class='h-75 pt-5 flex'>
                    <div class='container w-50'>
                        <table class='table table-borderless'>
                            <tr>
                                <td>Porudžbinu kreirao/la</td>
                                <td><a href='#user/#{@order.createdById}'>#{@order.createdByName}</a></td>
                            </tr>
                                
                            <tr>
                                <td>Klijent</td>
                                 <td><a href='#client/#{@order.clientId}'>#{@order.clientFullName}</a></td>
                            </tr>
                                
                            <tr>
                                <td>Kreirano</td>
                                 <td>#{ComponentsUtils.getTimeFromMillis(@order.createdAtMillis)}</td>
                            </tr>
                            <tr>
                                <td>Status prodžbine</td>
                                <td>#{@order.status}</td>
                            </tr>
                            <tr>
                                <td>Cena</td>
                                <td>#{@order.saldo}</td>
                            </tr>
                            <tr>
                                <td>Uplaćeno</td>
                                 <td>#{@order.paid}</td>
                            </tr>
                                
                            <tr>
                                <td>Radnici</td>
                                <td>#{workersHTML}</td>
                            </tr>
                        </table>
                    </div>
                </div>"

    payOrderSuccess: (response) ->
        @order.paid = response.data
        @pageHTML()