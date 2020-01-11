class @UpdateOrderDialog extends AbstractDialog

    constructor: () ->
        super()

    destroy: () ->
        super()
        @parentPage = null
        @order = null

    show: (@parentPage, @order) ->
        super()
        @customHTML()
        @container.find('.js--order--status').val(@order.status)
        @container.find('.js--note').val(@order.note)

    hide: () ->
        super()

    positiveAction: () ->
        status = @container.find('.js--order--status').val()
        note   = @container.find('.js--note').val()

        data = {
            id     : @order.id
            status : status
            note   : note
        }
        OrderService.updateOrderStatus(data, null, this, @_updateOrderStatusSuccess, @_updateOrderStatusError)
        super()

    _customHTML: () ->
        return "<div class='col-7 m-auto p-5 flex'>
                <div class='container container-padding w-50'>
                    <div class='form-group'>
                        <div class='form-group'>
                            <label>Status porudzbine</label>
                            <select class='js--order--status'>
                                <option value='ACCEPTED'>Prihvaćen</option>
                                <option value='WAITING'>Na čekanju</option>
                                <option value='DECLINED'>Odbijen</option>
                                <option value='FINISHED'>Završen</option>                                
                            </select>
                        </div>
                        <div class='pos-rel'>
                            <label>Napomena</label>
                            <textarea class='form-control js--note' placeholder='Naponema...'/>
                        </div>
                    </div>
                </div>
            </div>"

    _updateOrderStatusSuccess: (response) ->
        if @parentPage
            @parentPage.updateOrderStatus(response.data)

    updateOrderStatusError: () ->
        FloatingMessage.error("Ops. Došlo je do greške, pokušajte ponovo")