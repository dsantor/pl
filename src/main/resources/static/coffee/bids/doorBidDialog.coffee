class @DoorBidDialog extends AbstractDialog

    @BID_TYPE = 'DOOR'

    constructor: () ->
        super()

    show: (@parentPage, updateItem = null) ->
        super()
        @customHTML()
        @sort       = @container.find('.js--sort')
        @type       = @container.find('.js--type')
        @openSide   = @container.find('.js--open--side')
        @glass      = @container.find('.js--glass')
        @width      = @container.find('.js--width')
        @height     = @container.find('.js--height')
        @innerWidth = @container.find('.js--inner-width')
        @price      = @container.find('.js--price')
        @quantity   = @container.find('.js--quantity')
        @id         = null

        if updateItem
            @sort.val(updateItem.sort or '---')
            @type.val(updateItem.type or '---')
            @openSide.val(updateItem.openSide or '---')
            @glass.val(updateItem.glass or '---')
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

    setData: (@orderTypes) ->

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
            bidType    : DoorBidDialog.BID_TYPE
            id         : @id
            sort       : @_valueOf(@sort.val())
            type       : @_valueOf(@type.val())
            openSide   : @_valueOf(@openSide.val())
            glass      : @_valueOf(@glass.val())
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
        
        validInput = @_validateInput(@type)
        valid &= validInput
        
        validInput = @_validateInput(@openSide)
        valid &= validInput

        validInput = @_validateInput(@glass)
        valid &= validInput

        validInput = @_validateInput(@width)
        valid &= validInput

        validInput = @_validateInput(@height)
        valid &= validInput

        validInput = @_validateInput(@innerWidth)
        valid &= validInput

        validInput = @_validateInput(@price)
        valid &= validInput

        validInput = @_validateInput(@quantity)
        valid &= validInput
        return valid

    _customHTML: () ->
        return "<div class='col-7 m-auto p-5 flex'>
                    <div class='container container-padding w-50'>
                            <h5>Opste</h5>     
                            <br>
                            <div class='form-group'>
                                <label>Vrsta vrata*</label>
                                <select class='select--input js--sort'>
                                    <option selected>---</option>
                                    #{@_printOptionsHTML(@orderTypes['DOOR_SORT'])}
                                </select>
                            </div>
                            
                            <div class='form-group'>
                                <label>Tip vrata*</label>
                                <select class='select--input js--type'>
                                    <option selected>---</option>
                                    #{@_printOptionsHTML(@orderTypes['DOOR_TYPE'])}
                                </select>
                            </div>                    
                            <div class='form-group'>
                                    <label>Strana otvora*</label>
                                    <select class='select--input js--open--side'>
                                        <option selected>---</option>
                                        <option>Levi otvor</option>
                                        <option>Desni otvor</option>
                                    </select>
                            </div>

                            <div class='form-group'>
                                <label>Staklo*</label>
                                <select class='select--input js--glass'>
                                    <option selected>---</option>
                                    #{@_printOptionsHTML(@orderTypes['DOOR_GLASS'])}
                                </select>
                            </div>

                            <div class='form-group'>
                                <label>Kolicina*</label>
                                <input type='number' min='1' class='form-control js--quantity' value='1'>
                            </div>
                            <div class='form-group'>
                                <label>Cena*</label>
                                <input type='number' min='1' class='form-control js--price' placeholder='din'>
                            </div>

                            <div class='form-group'>
                                <br> <hr>
                                <h5>Dimenzije</h5>     
                                <br>
                                <div class='form-group form-inline'>
                                    <label class='mr-2 wc-10 left-label'>Sirina*</label>
                                    <input type='number' min='0' class='form-control js--width' placeholder='cm'>
                                </div>
                                <div class='form-group form-inline'>
                                    <label class='mr-2 wc-10 left-label'>Visina*</label>
                                    <input type='number' min='0' class='form-control js--height' placeholder='cm'>
                                </div>
                                <div class='form-group form-inline'>
                                    <label class='mr-2 wc-10 left-label'>Unutrasnja sirina*</label>
                                    <input type='number' min='0' class='form-control js--inner-width' placeholder='cm'>
                                </div>
                            </div>
                    </div>
             </div>"