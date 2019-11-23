class @DoorBidDialog extends AbstractDialog

    @BID_TYPE = 'DOOR'

    constructor: () ->
        super()

    _pageClientEventHandler: (event) ->
        super()
        target = $(event.target)
        
        if closest(target, '.select--input')
            @_validateInput(target)

    show: (@parentPage) ->
        super()

        @doorSort       = @container.find('.js--door--sort')
        @doorType       = @container.find('.js--door--type')
        @doorOpenSide   = @container.find('.js--door--open--side')
        @doorGlass      = @container.find('.js--door--glass')
        @doorWidth      = @container.find('.js--door--width')
        @doorHeight     = @container.find('.js--door--height')
        @doorInnerWidth = @container.find('.js--door--inner-width')
        @doorCount      = @container.find('.js--door--count')

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
            bidType        : DoorBidDialog.BID_TYPE
            doorSort       : @_valueOf(@doorSort.val())
            doorType       : @_valueOf(@doorType.val())
            doorOpenSide   : @_valueOf(@doorOpenSide.val())
            doorGlass      : @_valueOf(@doorGlass.val())
            doorWidth      : @_valueOf(@doorWidth.val())
            doorHeight     : @_valueOf(@doorHeight.val())
            doorInnerWidth : @_valueOf(@doorInnerWidth.val())
            doorCount      : @_valueOf(@doorCount.val())
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
        validInput = @_validateInput(@doorSort)
        valid &= validInput
        
        validInput = @_validateInput(@doorType)
        valid &= validInput
        
        validInput = @_validateInput(@doorOpenSide)
        valid &= validInput

        validInput = @_validateInput(@doorGlass)
        valid &= validInput

        return valid

    _customHTML: () ->
        return "<div class='col-7 m-auto p-5 flex'>
                    <div class='container container-padding w-50'>
                            <h5>Opste</h5>     
                            <br>
                            <div class='form-group'>
                                <label>Vrsta vrata*</label>
                                <select class='select--input js--door--sort'>
                                    <option selected>---</option>
                                    <option>Ulazna</option>
                                    <option>Sobna</option>
                                    <option>Jednokrilna balkonska</option>
                                    <option>Dvokrilna balkonska</option>
                                    <option>Garažna</option>
                                    <option>segmentna garazna</option>
                                    <option>Rolo</option>
                                </select>
                            </div>
                            
                            <div class='form-group'>
                                <label>Tip vrata*</label>
                                <select class='select--input js--door--type'>
                                    <option selected>---</option>
                                    <option>Sa staklom</option>
                                    <option>Pun panel</option>
                                    <option>Panel/staklo</option>
                                    <option>Dekorativni modeli</option>
                                </select>
                            </div>                    
                            <div class='form-group'>
                                    <label>Strana otvora*</label>
                                    <select class='select--input js--door--open--side'>
                                        <option selected>---</option>
                                        <option>Levi otvor</option>
                                        <option>Desni otvor</option>
                                    </select>
                            </div>

                            <div class='form-group'>
                                <label>Staklo*</label>
                                <select class='select--input js--door--glass'>
                                    <option selected>---</option>
                                    <option>Providno</option>
                                    <option>Griz</option>
                                    <option>Delta</option>
                                    <option>Vitraz</option>
                                </select>
                            </div>

                             <div class='form-group'>
                                <label>Kolicina*</label>
                                <input type='number' min='1' class='form-control js--door--count' value='1'>
                            </div>

                            <div class='form-group'>
                                <br> <hr>
                                <h5>Dimenzije</h5>     
                                <br>
                                <div class='form-group form-inline'>
                                    <label class='mr-2 wh-10 left-label'>Sirina*</label>
                                    <input type='number' min='0' class='form-control js--door--width' placeholder='cm'>
                                </div>
                                <div class='form-group form-inline'>
                                    <label class='mr-2 wh-10 left-label'>Visina*</label>
                                    <input type='number' min='0' class='form-control js--door--height' placeholder='cm'>
                                </div>
                                <div class='form-group form-inline'>
                                    <label class='mr-2 wh-10 left-label'>Unutrasnja sirina*</label>
                                    <input type='number' min='0' class='form-control js--door--inner-width' placeholder='cm'>
                                </div>
                            </div>
                    </div>
             </div>"