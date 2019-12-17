class @CreateExpenseDialog extends AbstractDialog

    constructor: () ->
        super()

    destroy: () ->
        super()
        @moneyGivenBy = null
        @moneyTook    = null
        @purpose      = null
        @moneyGivenAt = null
        @sum          = null
        @parentPage   = null
        
        @container.off 'keyup', @keyDownEvent
        @keyDownEvent = null

        @userAutoSuggestions = null

    show: (@parentPage) ->
        super()
        @customHTML()

        @moneyGivenBy = @container.find('.js--money--given--by')
        @moneyTook    = @container.find('.js--money--took')
        @purpose      = @container.find('.js--purpose')
        @moneyGivenAt = @container.find('.js--money--given--at')
        @sum          = @container.find('.js--sum')

        UserService.getUsers(null, this, @_usersLoaded, ajaxCallbackPrintMessage)
        
        @keyDownEvent = @_keyDownEventHandler.bind(this)
        @container.on 'keyup', @keyDownEvent

        @userAutoSuggestions   = @container.find('.js--user--suggestions')

    _usersLoaded: (response) ->
        @users = response.data

    hide: () ->
        super()

    negativeAction: () ->
        super()

    positiveAction: () ->
        if not @_validateForm()
            return

        data = {
            moneyGivenBy     : @moneyGivenBy.attr('data-user-id')
            moneyTook        : @parentPage.worker.id
            purpose          : @purpose.val()
            moneyGivenAt     : new Date(@moneyGivenAt.val()).getTime()
            sum              : @sum.val()
        }

        ExpenseService.create(data, null, this, @_createSuccess, ajaxCallbackPrintMessage)
        @hide()

    _createSuccess: () ->
        FloatingMessage.success("Dažbina uspešno kreirana")

    _validateForm: () ->
        valid = true
        validInput = @_validateInput(@moneyGivenBy)
        valid &= validInput
        
        validInput = @_validateInput(@purpose)
        valid &= validInput
        
        validInput = @_validateInput(@moneyGivenAt)
        valid &= validInput

        validInput = @_validateInput(@sum)
        valid &= validInput

        return valid

    _validateInput: (input) ->
        valid = true
        if @_valueOf(input.val())
            input.removeClass(ComponentsUtils.CSS_INVALID_INPUT)
        else
            valid = false
            input.addClass(ComponentsUtils.CSS_INVALID_INPUT)
        return valid
    
    _valueOf: (value) ->
        value = value.trim()
        if not value or value is '---'
            return null
        return value

    _customHTML: () ->
        return "<div class='col-7 m-auto p-5 flex'>
                    <div class='container container-padding w-50'>
                        <div class='form-group'>
                            <div class='pos-rel'>
                                <label>Novac uručio*</label>
                                <input type='text' class='form-control js--money--given--by' placeholder='ime i prezime'/>
                                <div class='pos-rel'>
                                    <div class='suggestion-container js--user--suggestions pos-abs hide'></div>
                                </div>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label>Namena*</label>
                            <textarea class='form-control js--purpose' placeholder='Novac namenjen za...'/>
                        </div>
                        <div class='form-group'>
                            <label>Suma*</label>
                            <input type='number' class='form-control js--sum' placeholder='din'/>
                        </div>
                        <div class='form-group'>
                            <label>Novac uručen*</label>
                            <input type='date' class='form-control js--money--given--at'/>
                        </div>
                    </div>
                </div>"
    
    _pageClickEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--user--suggestions')
            @_selectUserFromAutoSuggestion(target)
            return

        @userAutoSuggestions.addClass('hide')

    _keyDownEventHandler: (event) ->
        target = $(event.target)
        if closest(target, '.js--money--given--by')
            @_handlerUserSuggestion()
            return

    _selectUserFromAutoSuggestion: (target) ->
        ComponentsUtils.selectFromAutoSuggestion(target, @users, 'data-user-id', @moneyGivenBy, @userAutoSuggestions)

    _handlerUserSuggestion: () ->
        ComponentsUtils.handleAutoSuggestion(@moneyGivenBy, 'data-user-id', @users, @userAutoSuggestions)