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
        @price      = @container.find('.js--pice')
        @count      = @container.find('.js--count')
        @id         = null
        if updateItem
            @sort.val(updateItem.sort or '---')
            @width.val(updateItem.width or '')
            @height.val(updateItem.height or '')
            @innerWidth.val(updateItem.innerWidth or '')
            @price.val(updateItem.price or '')
            @count.val(updateItem.count or '')
            @id = updateItem.id
        
    hide: () ->
        super()

    destroy: () ->
        @parentPage = null
        super()

    positiveAction: () ->
        if not @_validateForm()
            return
        formData = @_collectDataFromForm()
        @parentPage.bidDialogResult(formData)
        @hide()

    negativeAction: () ->
        super()


    _collectDataFromForm: () ->
        return {
            bidType    : ThresholdBidDialog.BID_TYPE
            id         : @id
            sort       : @_valueOf(@sort.val())
            width      : @_valueOf(@width.val())
            height     : @_valueOf(@height.val())
            innerWidth : @_valueOf(@innerWidth.val())
            price      : @_valueOf(@price.val())
            count      : @_valueOf(@count.val())
        }

    _validateForm: () ->
        return @_validateInput(@sort)

    _valueOf: (value) ->
        if not value or value is '---'
            return null
        return value.trim()


    _validateInput: (input) ->
        valid = true
        if @_valueOf(input.val())
            input.removeClass(ComponentsUtils.CSS_INVALID_INPUT)
        else
            valid = false
            input.addClass(ComponentsUtils.CSS_INVALID_INPUT)
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
                                <option>Alu prag</option>
                                <option>Stok</option>
                            </select>
                        </div>

                        <div class='form-group'>
                            <label>Kolicina*</label>
                            <input type='number' min='1' class='form-control js--count' value='1'>
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
                                <label class='mr-2 wh-10 left-label'>Sirina</label>
                                <input type='number' min='0' class='form-control js--width' placeholder='cm'>
                            </div>
                            <div class='form-group form-inline'>
                                <label class='mr-2 wh-10 left-label'>Visina</label>
                                <input type='number' min='0' class='form-control js--height' placeholder='cm'>
                            </div>
                            <div class='form-group form-inline'>
                                <label class='mr-2 wh-10 left-label'>Unutrasnja sirina</label>
                                <input type='number' min='0' class='form-control js--inner--width' placeholder='cm'>
                            </div>
                        </div>
                    </div>
                </div>"