class @ExpensesPage extends AbstractPage

    constructor: (workerId) ->
        super()
        @pageHTML()
        if workerId
            ExpenseService.getWorkerExpenses(workerId, null, this, @_expensesLoaded, @_expensesLoadedError)
        else
            ExpenseService.getAll(null, this, @_expensesLoaded, @_expensesLoadedError)

        @expenses          = []
        @clientsAndWorkers = []
        WorkerService.getAllActive(null, this, @_loadedClientsSuccess, @_loadedClientsError)
        @filterContainer = @container.find('.js--filter--container')
        @expensesContainer = @container.find('.js--expenses--container')
        @autoSuggestion = new AutoSuggestion(this, @filterContainer, AutoSuggestion.EXPENSE_FILTER)
        @filterAsInput = @container.find('.js--filter--as')
        @suggestionsContainer = @container.find('.js--filter--suggestions')

        @filterFrom    = @container.find('.js--filter--from')
        @filterTo      = @container.find('.js--filter--to')
        @filterSumFrom = @container.find('.js--filter--sum--from')
        @filterSumTo   = @container.find('.js--filter--sum--to')
        @createExpenseDialog = new CreateExpenseDialog()

        @createdNewExpenseEvent = @_createdNewExpenseHandler.bind(this)
        EventUtils.bindCreatedNewExpense(@createdNewExpenseEvent)
    destroy: () ->
        super()

        @autoSuggestion.destroy()
        @autoSuggestion = null

        @createExpenseDialog.destroy()
        @createExpenseDialog = null
        
        EventUtils.unbindCreatedNewExpense(@createdNewExpenseEvent)
        @createdNewExpenseEvent = null
        @expensesContainer      = null
        @suggestionsContainer   = null
        @filterContainer        = null
        @expenses               = null
        @clientsAndWorkers      = null

        @filterAsInput = null
        @filterFrom    = null
        @filterTo      = null
        @filterSumFrom = null
        @filterSumTo   = null

    _clickEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--create--expense')
            @createExpenseDialog.show()
            return
    
    _expensesLoaded: (response) ->
        @expenses = response.data

        if @expenses.length == 0
            @_renderEmptyState()
        else
            @_renderExpensesHTML(@expenses)

    _customHTML: () ->
        return  "<div>
                    <nav class='nav justify-content-end pt-3'>
                        <span class='nav-link span-a js--create--expense'>Kreiraj dažbinu</span>
                    </nav>
                    <div class='js--filter--container'>
                    </div>
                    <div class='js--expenses--container'>
                        #{ComponentsUtils.loadingPage()}
                    </div>
                </div>"
    
    _renderEmptyState: () ->
        @expensesContainer.html(ComponentsUtils.emptyState('Nema dažbina'))

    _renderExpensesHTML: (expenses) ->
        innerHtml = ""
        for expense in expenses
            innerHtml += "<div class='flex-table js--expense--row' data-bid-id=#{expense.id}>
                            <div class='flex-table-cell w-20'>
                                <a href='#worker/#{expense.expenseCreatedBy}'>#{expense.expenseCreatedByFullName}</a>
                            </div>
                            <div class='flex-table-cell w-20'>
                                <a href='#user/#{expense.moneyGivenBy}'>#{expense.moneyGivenByFullName}</a>
                            </div>
                            <div class='flex-table-cell w-20'>
                                #{ComponentsUtils.getTimeFromMillis(expense.moneyGivenAt)}
                            </div>
                            <div class='flex-table-cell w-20'>#{expense.sum}</div>
                            <div class='flex-table-cell w-20'>#{expense.purpose}</div>
                         </div>"

        html = "<div class='hide'></div>
                <div class='flex-table'>
                    <div class='flex-table-cell w-20'>Primio novac</div>
                    <div class='flex-table-cell w-20'>Uručio novac</div>
                    <div class='flex-table-cell w-20'>Datum</div>
                    <div class='flex-table-cell w-20'>Suma</div>
                    <div class='flex-table-cell w-20'>Svrha</div>
                </div>
                #{innerHtml}
                </div>"

        @expensesContainer.html(html)


    triggerFiterSumFrom: () ->
        @_applyFilter()

    triggerFiterSumTo: () ->
        @_applyFilter()

    triggerFilterFrom: () ->
        @_applyFilter()

    triggerFilterTo: () ->
        @_applyFilter()
    
    triggerFilterAs: (event) ->
        ComponentsUtils.handleAutoSuggestion(@filterAsInput, 'data-id', @clientsAndWorkers, @suggestionsContainer, true, this, @_resetFilter)

    triggerFilterSuggestions: (event) ->
        target = $(event.target)
        ComponentsUtils.selectFromAutoSuggestion(target, @filterAsInput, 'data-id', @clientsAndWorkers, @suggestionsContainer)
        @_applyFilter()
        return

    triggerFilterReset: () ->
        @_resetFilter()
    
    _resetFilter: () ->
        @filterSumFrom.val('')
        @filterSumTo.val('')
        @filterFrom.val('')
        @filterTo.val('')
        @filterAsInput.val('')
        @filterAsInput.removeAttr('data-id')
        @_applyFilter()
        
    _applyFilter: () ->
        sumFrom = @filterSumFrom.val()
        sumTo = @filterSumTo.val()
        filteredExpenses = []
        if sumFrom or sumTo
            if sumFrom
                sumFrom = sumFrom.trim()
            else
                sumFrom = 0
            
            if sumTo
                sumTo = sumTo.trim()
            else
                sumTo = Number.MAX_SAFE_INTEGER

            for expense in @expenses
                if expense.sum >= sumFrom and expense.sum <= sumTo
                    filteredExpenses.push(expense)

        else
            filteredExpenses = @expenses.slice()

        if @filterFrom.val() or @filterTo.val()
            if @filterFrom.val()
                dateFrom = new Date(@filterFrom.val()).getTime()
            else
                dateFrom = new Date('1970').getTime()
            
            if @filterTo.val()
                dateTo = new Date(@filterTo.val()).getTime()
            else
                dateTo = new Date().getTime()
            
            filteredByDate = []
            for expense in filteredExpenses
                if expense.moneyGivenAt >= dateFrom and expense.moneyGivenAt <= dateTo
                    filteredByDate.push(expense)
            filteredExpenses = filteredByDate

        filterAs = @filterAsInput.val().trim()
        # razdvojiti data att za usera i workera
        if filterAs
            filtered = []
            userId = Number(@filterAsInput.attr('data-id'))
            for expense in filteredExpenses
                if expense.moneyTook == userId
                    filtered.push(expense)
            
            filteredExpenses = filtered
        @_renderExpensesHTML(filteredExpenses)


    _loadedClientsSuccess: (response) ->
        @clientsAndWorkers = @clientsAndWorkers.concat(response.data)
    _loadedClientsError: (response) ->
        console.log 'error'

    _createdNewExpenseHandler: (event, expense) ->
        @expenses.push(expense)
        @_applyFilter()