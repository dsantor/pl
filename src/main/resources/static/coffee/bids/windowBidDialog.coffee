class @WindowBidDialog extends AbstractDialog

    @BID_TYPE = 'WINDOW'

    constructor: () ->
        super()

    show: (@parentPage, updateItem = null) ->
        super()
        @customHTML()
        @sort       = @container.find('.js--sort')
        @openSide   = @container.find('.js--open--side')
        @glass      = @container.find('.js--glass')
        @tipper     = @container.find('.js--tipper')
        @width      = @container.find('.js--width')
        @height     = @container.find('.js--height')
        @innerWidth = @container.find('.js--inner--width')
        @price      = @container.find('.js--price')
        @quantity   = @container.find('.js--quantity')
        @id         = null

        if updateItem
            @sort.val(updateItem.sort or '---')
            @openSide.val(updateItem.openSide or '---')
            @glass.val(updateItem.glass or '---')
            @tipper.val(updateItem.tipper or '---')
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

        @sort       = null
        @openSide   = null
        @glass      = null
        @tipper     = null
        @width      = null
        @height     = null
        @innerWidth = null    
        @price      = null
        @quantity   = null

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
            bidType    : WindowBidDialog.BID_TYPE
            id         : @id
            sort       : @_valueOf(@sort.val())
            openSide   : @_valueOf(@openSide.val())
            glass      : @_valueOf(@glass.val())
            tipper     : @_valueOf(@tipper.val())
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
        
        validInput = @_validateInput(@openSide)
        valid &= validInput
        
        validInput = @_validateInput(@glass)
        valid &= validInput

        validInput = @_validateInput(@tipper)
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
                            <label>Vrsta prozora*</label>
                            <select class='js--sort'>
                                <option selected>---</option>
                                <option>Jednokrilni</option>
                                <option>Dvokrlni</option>
                                <option>Trokrilni</option>
                                <option>Fiks</option>
                            </select>
                        </div>
                        
                        <div class='form-group'>
                                <label>Otvor*</label>
                                <select class='js--open--side'>
                                    <option selected>---</option>
                                    <option>Levi</option>
                                    <option>Desni</option>
                                </select>
                        </div>
                        <div class='form-group'>
                            <label>Staklo*</label>
                            <select class='js--glass'>
                                <option selected>---</option>
                                <option>Providno</option>
                                <option>Griz</option>
                            </select>
                        </div>

                        <div class='form-group'>
                            <label>Kipovanje*</label>
                            <select class='js--tipper'>
                                <option selected>---</option>
                                    <option>Da</option>
                                    <option>Ne</option>
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
                            <br>
                            <hr>
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
                            <div class='form-group form-inline'>
                                <label class='mr-2 wc-10 left-label'>Unutrasnja sirina</label>
                                <input type='number' class='form-control js--inner--width' placeholder='cm'>
                            </div>
                        </div>
                    </div>
                </div>"