class @MosquitoRepellerBidDialog extends AbstractDialog

    @BID_TYPE = 'MOSQUITO_REPELLER'

    constructor: () ->
        super()

    show: (@parentPage, updateItem = null) ->
        super()
        @customHTML()
        @sort     = @container.find('.js--sort')
        @type     = @container.find('.js--type')
        @openSide = @container.find('.js--open--side')
        @width    = @container.find('.js--width')
        @height   = @container.find('.js--height')
        @count    = @container.find('.js--count')
        @id       = null

        if updateItem
            @sort.val(updateItem.sort or '---')
            @type.val(updateItem.type or '---')
            @openSide.val(updateItem.openSide or '---')
            @width.val(updateItem.width or '')
            @height.val(updateItem.height or '')
            @count.val(updateItem.count or '')
            @id = updateItem.id

    hide: () ->
        super()

    destroy: () ->
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
            bidType    : MosquitoRepellerBidDialog.BID_TYPE
            id         : @id
            sort       : @_valueOf(@sort.val())
            type       : @_valueOf(@type.val())
            openSide   : @_valueOf(@openSide.val())
            width      : @_valueOf(@width.val())
            height     : @_valueOf(@height.val())
            count      : @_valueOf(@count.val())
        }   

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

    _validateForm: () ->
        valid = true
        validInput = @_validateInput(@sort)
        valid &= validInput
        
        validInput = @_validateInput(@type)
        valid &= validInput
        
        validInput = @_validateInput(@openSide)
        valid &= validInput

        return valid

    _customHTML: () ->
        return "<div class='col-7 m-auto p-5 flex'>
                    <div class='container container-padding w-50'>
                         <h5>Opste</h5>     
                    <br>
                        <div class='form-group'>
                            <label>Vrsta komarnika*</label>
                            <select class='js--sort'>
                                <option selected>---</option>
                                <option>Fiksni</option>
                                <option>Rolo</option>
                            </select>
                        </div>
                        <div class='form-group'>
                                <label>Tip komarnika*</label>
                                <select class='js--type'>
                                    <option selected>---</option>
                                    <option>Vrata</option>
                                    <option>Rolo</option>
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
                            <input type='number' min='1' class='form-control js--count' value='1'>
                        </div>        

                        <div class='form-group'>
                            <br> <hr>
                            <h5>Dimenzije</h5>     
                            <br>
                            <div class='form-group form-inline'>
                                <label class='mr-2 wh-10 left-label'>Sirina</label>
                                <input type='number' class='form-control js--width' placeholder='cm'>
                            </div>
                            <div class='form-group form-inline'>
                                <label class='mr-2 wh-10 left-label'>Visina</label>
                                <input type='number' class='form-control js--height' placeholder='cm'>
                            </div>
                        </div>   
                    </div>
             </div>"