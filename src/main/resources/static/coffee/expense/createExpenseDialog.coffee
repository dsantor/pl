class @CreateExpenseDialog extends AbstractDialog

    constructor: () ->
        super()
        @users   = []
        @worker  = null
        @workers = []
        

        
    destroy: () ->  
        @moneyGivenBy = null
        @moneyTook    = null
        @purpose      = null
        @moneyGivenAt = null
        @sum          = null
        @users        = null
        @worker       = null     
        @workers      = null   
        @container.off 'keyup', @keyDownEvent
        @keyDownEvent = null

        @userAutoSuggestions    = null
        @workersAutoSuggestions = null

        super()

    show: (worker) ->
        super()
        @customHTML()

        @keyDownEvent = @_keyDownEventHandler.bind(this)
        @container.on 'keyup', @keyDownEvent

        @moneyGivenBy = @container.find('.js--money--given--by')
        @moneyTook    = @container.find('.js--money--took')
        @purpose      = @container.find('.js--purpose')
        @moneyGivenAt = @container.find('.js--money--given--at')
        @sum          = @container.find('.js--sum')

        @worker = worker
        if @worker
            @moneyTook.attr('data-worker-id', @worker.id)
            @moneyTook.val(@worker.fullName)
            @moneyTook.attr('disabled', 'disabled')
        else
            WorkerService.getAllActive(null, this, @_workersLoaded, ajaxCallbackPrintMessage)

        UserService.getUsersIncludedMe(null, this, @_usersLoaded, ajaxCallbackPrintMessage)

        @userAutoSuggestions    = @container.find('.js--user--suggestions')
        @workersAutoSuggestions = @container.find('.js--worker--suggestions')

    _workersLoaded: (response) ->
        @workers = response.data

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
            moneyTook        : @worker.id
            purpose          : @purpose.val()
            moneyGivenAt     : new Date(@moneyGivenAt.val()).getTime()
            sum              : @sum.val()
        }

        ExpenseService.create(data, null, this, @_createSuccess, ajaxCallbackPrintMessage)
        @hide()

    _createSuccess: (response) ->
        FloatingMessage.success("Dažbina uspešno kreirana")
        EventUtils.triggerCreatedNewExpense(response.data)

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
        
        validInput = @_validateInput(@moneyTook)
        valid &= validInput

        if @worker
            valid &= true
        else
            valid = false

        return valid

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
                             <div class='pos-rel'>
                                <label>Novac primio*</label>
                                <input type='text' class='form-control js--money--took' placeholder='ime i prezime'/>
                                <div class='pos-rel'>
                                    <div class='suggestion-container js--worker--suggestions pos-abs hide'></div>
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

        if closest(target, '.js--worker--suggestions')
            @_selectWorkerFromAutoSuggestion(target)
            return

        @userAutoSuggestions.addClass('hide')

    _keyDownEventHandler: (event) ->
        target = $(event.target)
        if closest(target, '.js--money--given--by')
            @_handlerUserSuggestion()
            return
        
        if closest(target, '.js--money--took')
            @_handlerWorkerSuggestion()
            return

    _selectUserFromAutoSuggestion: (target) ->
        ComponentsUtils.selectFromAutoSuggestion(target, @moneyGivenBy, 'data-user-id', @users, @userAutoSuggestions)

    _handlerUserSuggestion: () ->
        ComponentsUtils.handleAutoSuggestion(@moneyGivenBy, 'data-user-id', @users, @userAutoSuggestions)

    _selectWorkerFromAutoSuggestion: (target) ->
        ComponentsUtils.selectFromAutoSuggestion(target,  @moneyTook, 'data-worker-id', @workers, @workersAutoSuggestions)
        workerId = Number(@moneyTook.attr('data-worker-id'))
        @worker = null
        for worker in @workers
            if worker.id is workerId
                @worker = worker
                break

    _handlerWorkerSuggestion: () ->
        ComponentsUtils.handleAutoSuggestion(@moneyTook, 'data-worker-id', @workers, @workersAutoSuggestions)
