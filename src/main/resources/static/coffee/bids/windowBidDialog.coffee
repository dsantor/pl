class @WindowBidDialog extends AbstractDialog

    @BID_TYPE = 'WINDOW'

    constructor: () ->
        super()

    show: (@parentPage) ->
        super()
        @sort     = @container.find('.js--sort')
        @openSide = @container.find('.js--open--side')
        @glass    = @container.find('.js--glass')
        @tipper   = @container.find('.js--tipper')
        @width    = @container.find('.js--width')
        @height   = @container.find('.js--height')
        @count    = @container.find('.js--count')

    hide: () ->
        super()

    destroy: () ->
        @parentPage = null

        @sort     = null
        @openSide = null
        @glass    = null
        @tipper   = null
        @width    = null
        @height   = null    
        @count    = null

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
            sort       : @_valueOf(@sort.val())
            openSide   : @_valueOf(@openSide.val())
            glass      : @_valueOf(@glass.val())
            tipper     : @_valueOf(@tipper.val())
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
        
        validInput = @_validateInput(@openSide)
        valid &= validInput
        
        validInput = @_validateInput(@glass)
        valid &= validInput

        validInput = @_validateInput(@tipper)
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
                            <input type='number' min='1' class='form-control js--count' value='1'>
                        </div>

                        <div class='form-group'>
                            <br>
                            <hr>
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
                            <div class='form-group form-inline'>
                                <label class='mr-2 wh-10 left-label'>Unutrasnja sirina</label>
                                <input type='number' class='form-control js--inner--width' placeholder='cm'>
                            </div>
                        </div>
                    </div>
                </div>"