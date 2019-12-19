class @ShutterBidDialog extends AbstractDialog

    @BID_TYPE = 'SHUTTER'

    constructor: () ->
        super()

    show: (@parentPage, updateItem = null) ->
        super()
        @customHTML()
        @sort     = @container.find('.js--sort')
        @box      = @container.find('.js--box')
        @boxType  = @container.find('.js--box--type')
        @openSide = @container.find('.js--open--side')
        @quantity = @container.find('.js--quantity')
        @width    = @container.find('.js--width')
        @height   = @container.find('.js--height')
        @quantity = @container.find('.js--quantity')
        @price    = @container.find('js--price')
        @id       = null

        @additionBoxOptions = @container.find('.js--box--type--option')
        @additionBoxActive  = false

        if updateItem
            @sort.val(updateItem.sort or '---')
            @box.val(updateItem.box or '---')
            @boxType.val(updateItem.boxType or '---')
            @openSide.val(updateItem.openSide or '---')
            @quantity.val(updateItem.quantity or '')
            @width.val(updateItem.width or '')
            @height.val(updateItem.height or '')
            @price.val(updateItem.price or '')
            @quantity.val(updateItem.quantity or '')
            @id = updateItem.id

            if updateItem.boxType
                @additionBoxOptions.removeClass('hide')
                @additionBoxActive = true
    hide: () ->
        super()

    destroy: () ->
        @parentPage = null
        @additionBoxOptions = null
        @additionBoxActive  = null

        @sort     = null
        @box      = null
        @boxType  = null
        @openSide = null
        @width    = null
        @height   = null
        @quantity = null
        @price    = null

        super()

    positiveAction: () ->
        if not @_validateForm()
            return
        formData = @_collectDataFromForm()
        @parentPage.bidDialogResult(formData)
        @hide()

    negativeAction: () ->
        super()

    _pageClickEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--box')
            @_checkBoxTypeOptions(target)

    _collectDataFromForm: () ->
        if @box.val() isnt 'Spoljasnja'
            boxType = null
        else 
            boxType = @_valueOf(@boxType.val()) 
        return {
            bidType    : ShutterBidDialog.BID_TYPE
            id         : @id
            sort       : @_valueOf(@sort.val())
            box        : @_valueOf(@box.val())
            boxType    : boxType
            openSide   : @_valueOf(@openSide.val())
            width      : @_valueOf(@width.val())
            height     : @_valueOf(@height.val())
            quantity   : @_valueOf(@quantity.val())
            price      : @_valueOf(@price.val())
        }   

    _validateForm: () ->
        valid = true
        validInput = @_validateInput(@sort)
        valid &= validInput
        
        validInput = @_validateInput(@box)
        valid &= validInput

        if @additionBoxActive
            validInput = @_validateInput(@boxType)
            valid &= validInput
        
        validInput = @_validateInput(@openSide)
        valid &= validInput

        validInput = @_validateInput(@width)
        valid &= validInput

        validInput = @_validateInput(@height)
        valid &= validInput

        validInput = @_validateInput(@price)
        valid &= validInput

        validInput = @_validateInput(@quantity)
        valid &= validInput
        return valid

    _checkBoxTypeOptions: (element) ->
        option = element[0].options
        if option[option.selectedIndex].value is 'Spoljasnja'
            @additionBoxOptions.removeClass('hide')
        else
            @additionBoxOptions.addClass('hide')

    _customHTML: () ->
        return "<div class='col-7 m-auto p-5 flex'>
                    <div class='container container-padding w-50'>
                        <h5>Opste</h5>     
                        <br>
                        <div class='form-group'>
                            <label>Vrsta roletne*</label>
                            <select class='js--sort'>
                                <option selected>---</option>
                                <option>Kais</option>
                                <option>Kurbla</option>
                                <option>Elektronski pogon</option>
                            </select>
                        </div>
                        <div class='form-group'>
                                <label>Vrsta kutije*</label>
                                <select class='js--box'>
                                    <option value='0'>---</option>
                                    <option value='Unutrasnja'>Unutrasnja</option>
                                    <option value='Spoljasnja'>Spoljasnja</option>
                                </select>
                        </div>
                        <div class='form-group js--box--type--option hide'>
                                <label>Tip kutije*</label>
                                <select class='js--box--type'>
                                    <option>---</option>
                                    <option>RONDO poluzaobljena</option>
                                    <option>ALU livena</option>
                                    <option>ALU zastorom</option>
                                </select>
                        </div>
                        <div class='form-group'>
                                <label>Strana otvora*</label>
                                <select class='js--open--side'>
                                    <option selected>---</option>
                                    <option>Levi otvor</option>
                                    <option>Desni otvor</option>
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
                                <label class='mr-2 wc-10 left-label'>Sirina</label>
                                <input type='number' class='form-control js--width' placeholder='cm'>
                            </div>
                            <div class='form-group form-inline'>
                                <label class='mr-2 wc-10 left-label'>Visina</label>
                                <input type='number' class='form-control js--height' placeholder='cm'>
                            </div>
                        </div>
                    </div>
                </div>
             </div>"