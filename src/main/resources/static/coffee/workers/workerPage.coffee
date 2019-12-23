class @WorkerPage extends AbstractPage

    constructor: (workerId) ->
        super()
        WorkerService.get(workerId, null, this, @_loadedWorker, ajaxCallbackPrintMessage)
        @createExpenseDialog = new CreateExpenseDialog()
    destroy: () ->
        super()

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

    _loadedWorker: (response) ->
        @worker = response.data
        @pageHTML()

    _toggleBlockUserText: () ->
        text = 'Aktiviraj'
        if @worker.active
            text = 'Deaktiviraj'
        return text

    _customHTML: () ->
        if @worker
            innerHTML = @_toggleBlockUserText()
            html = "<nav class='nav justify-content-end header pt-3'>
                        <span class='nav-link span-a back-button js--back--button'>Nazad</span>
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