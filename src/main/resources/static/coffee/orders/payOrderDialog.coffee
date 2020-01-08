class @PayOrderDialog extends AbstractDialog

    constructor: () ->
        super()

    destroy: () ->
        super()
        @orderId    = null
        @parentPage = null

    show: (@orderId, @parentPage) ->
        super()
        @customHTML()

    hide: () ->
        super()

    positiveAction: () ->
        paidAmount = @container.find('.js--paid--amount')

        if not @_validateInput(paidAmount)
            return
        
        data = {
            orderId    : @orderId
            paidAmount : paidAmount.val().trim()
        }
        OrderService.payOrder(data, null, this, @_payOrderSuccess, @_payOrderError)
        super()

    _customHTML: () ->
        return "<div class='col-7 m-auto p-5 flex'>
                    <div class='container container-padding w-50'>
                        <div class='form-group'>
                            <div class='pos-rel'>
                                <label>Iznos uplate*</label>
                                <input type='number' class='form-control js--paid--amount' placeholder='din'/>
                            </div>
                        </div>
                    </div>
                </div>"

    _payOrderSuccess: (response) ->
        FloatingMessage.success("Uspešno izvešeno plaćanje")
        if @parentPage and @parentPage.payOrderSuccess?
            @parentPage.payOrderSuccess(response)

    _payOrderError: (response) ->
        FloatingMessage.error("Došlo je do greške. Pokušajte ponovo")