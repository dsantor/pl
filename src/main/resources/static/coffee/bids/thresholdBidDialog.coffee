class @ThresholdBidDialog extends AbstractDialog

    @BID_TYPE = 'THRESHOLD'

    constructor: () ->
        super()

    show: (@parentPage, updateItem = null) ->
        super()
        @customHTML()
        @sort       = @container.find('.js--sort')
        @width      = @container.find('.js--width')
        @height     = @container.find('.js--height')
        @innerWidth = @container.find('.js--inner--width')
        @price      = @container.find('.js--price')
        @quantity   = @container.find('.js--quantity')
        @id         = null
        if updateItem
            @sort.val(updateItem.sort or '---')
            @width.val(updateItem.width or '')
            @height.val(updateItem.height or '')
            @innerWidth.val(updateItem.innerWidth or '')
            @price.val(updateItem.price or '')
            @quantity.val(updateItem.quantity or '')
            @id = updateItem.id
        
    hide: () ->
        super()

    destroy: () ->
        @parentPage = null
        @orderTypes = null
        super()

    positiveAction: () ->
        if not @_validateForm()
            return
        formData = @_collectDataFromForm()
        @parentPage.bidDialogResult(formData)
        @hide()

    negativeAction: () ->
        super()

    setData: (@orderTypes) ->

    _collectDataFromForm: () ->
        return {
            bidType    : ThresholdBidDialog.BID_TYPE
            id         : @id
            sort       : @_valueOf(@sort.val())
            width      : @_valueOf(@width.val())
            height     : @_valueOf(@height.val())
            innerWidth : @_valueOf(@innerWidth.val())
            price      : @_valueOf(@price.val())
            quantity   : @_valueOf(@quantity.val())
        }

    _validateForm: () ->
        valid = true
        validInput = @_validateInput(@sort)
        valid &= validInput

        validInput = @_validateInput(@width)
        valid &= validInput

        validInput = @_validateInput(@height)
        valid &= validInput

        validInput = @_validateInput(@innerWidth)
        valid &= validInput

        validInput = @_validateInput(@price)
        valid &= validInput

        validInput = @_validateInput(@sort)
        valid &= validInput
        return valid

    _customHTML: () ->
        return "<div class='col-7 m-auto p-5 flex'>
                    <div class='container container-padding w-50'>
                        <h5>Opste</h5>     
                        <br>
                        <div class='form-group'>
                            <label>Vrsta praga</label>
                            <select class='js--sort'>
                                <option selected>---</option>
                                #{@_printOptionsHTML(@orderTypes['THRESHOLD_SORT'])}
                            </select>
                        </div>

                        <div class='form-group'>
                            <label>Kolicina*</label>
                            <input type='number' min='1' class='form-control js--quantity' value='1'>
                        </div>
                        <div class='form-group'>
                            <label>Cena*</label>
                            <input type='number' min='1' class='form-control js--price'>
                        </div>
                        <div class='form-group'>
                            <br> <hr>
                            <h5>Dimenzije</h5>     
                            <br>
                            <div class='form-group form-inline'>
                                <label class='mr-2 wc-10 left-label'>Sirina</label>
                                <input type='number' min='0' class='form-control js--width' placeholder='cm'>
                            </div>
                            <div class='form-group form-inline'>
                                <label class='mr-2 wc-10 left-label'>Visina</label>
                                <input type='number' min='0' class='form-control js--height' placeholder='cm'>
                            </div>
                            <div class='form-group form-inline'>
                                <label class='mr-2 wc-10 left-label'>Unutrasnja sirina</label>
                                <input type='number' min='0' class='form-control js--inner--width' placeholder='cm'>
                            </div>
                        </div>
                    </div>
                </div>"