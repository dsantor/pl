class @ExpensesPage extends AbstractPage

    constructor: (workerId) ->
        super()
        @pageHTML()
        if workerId
            ExpenseService.getWorkerExpenses(workerId, null, this, @_expensesLoaded, @_expensesLoadedError)
        else
            ExpenseService.getAll(null, this, @_expensesLoaded, @_expensesLoadedError)

        @filterContainer = @container.find('.js--filter--container')
        @expensesContainer = @container.find('.js--expenses--container')
        @autoSuggestion = new AutoSuggestion(this, @filterContainer, AutoSuggestion.EXPENSE_FILTER)
        @filterAsInput = @container.find('.js--filter--as')
        @suggestionsContainer = @container.find('.js--filter--suggestions')
        @filterStatus = @container.find('.js--filter--status')

        @createExpenseDialog = new CreateExpenseDialog()
    destroy: () ->
        super()

        @autoSuggestion.destroy()
        autoSuggestion = null

        @createExpenseDialog.destroy()
        @createExpenseDialog = null

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

        html = "<div class='flex-table'>
                    <div class='flex-table-cell w-20'>Izručio novac</div>
                    <div class='flex-table-cell w-20'>Primio novac</div>
                    <div class='flex-table-cell w-20'>Datum</div>
                    <div class='flex-table-cell w-20'>Suma</div>
                    <div class='flex-table-cell w-20'>Svrha</div>
                </div>
                #{innerHtml}
                </div>"

        @expensesContainer.html(html)


        triggerFiterSumFrom: () ->
            @_triggerFilter()

        triggerFiterSumTo: () ->
            @_triggerFilter()

        
        _triggerFilter: () ->
