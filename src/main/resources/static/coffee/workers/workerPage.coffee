class @WorkerPage extends AbstractPage

    constructor: (workerId) ->
        super()
        @worker = null
        WorkerService.get(workerId, null, this, @_loadedWorker, ajaxCallbackPrintMessage)
        @createExpenseDialog = new CreateExpenseDialog()
        @createWorkerDialog  = new CreateWorkerDialog()

    destroy: () ->
        super()
        @createExpenseDialog.destroy()
        @createExpenseDialog = null

        @createWorkerDialog.destroy()
        @createWorkerDialog  = null
        @worker = null

    _clickEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--back--button')
            MainNavigation.back()
            return

        if closest(target, '.js--block--worker')
            @_toggleBlockUser()
            return
        
        if closest(target, '.js--create--expense')
            @createExpenseDialog.show(@worker)
            return

        if closest( target, '.js--worker--expenses')
            window.location.href = "#expenses/#{@worker.id}"
            return
        
        if closest(target, '.js--edit--worker')
            @createWorkerDialog.show(this, @worker)
            return

    _loadedWorker: (response) ->
        @worker = response.data
        @pageHTML()

    _toggleBlockUserText: () ->
        text = 'Neaktivan'
        if @worker.active
            text = 'Aktivan'
        return text

    _customHTML: () ->
        if @worker
            innerHTML = @_toggleBlockUserText()
            html = "<nav class='nav justify-content-end header pt-3'>
                        <span class='nav-link span-a back-button js--back--button'>Nazad</span>
                        <span class='nav-link span-a js--edit--worker'>Izmeni</span>
                        <span class='nav-link span-a js--block--worker'>#{innerHTML}</span>
                        <span class='nav-link span-a js--worker--expenses'>Rashodi</span>
                        <span class='nav-link span-a js--create--expense'>Kreiraj rashod</span>
                    </nav>"
            html += ComponentsUtils.userDetailsFilledHTML(@worker)
            return html
        else
            ComponentsUtils.emptyState('Korisnik nije pronadjen :(')



    _toggleBlockUser: () ->
        @worker.active = !@worker.active
        $(".js--block--worker").html(@_toggleBlockUserText())
        WorkerService.toggleBlockWorker(@worker.id, null, this, globalSuccessMessage, globalErrorMessage)
    
    createWorkerDialogPositiveAction: (worker) ->
        @worker = worker
        @pageHTML()