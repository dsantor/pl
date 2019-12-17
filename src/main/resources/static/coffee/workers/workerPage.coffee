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
            window.history.back()
            return

        if closest(target, '.js--block--user')
            @_toggleBlockUser()
            return
        
        if closest(target, '.js--create--expense')
            @createExpenseDialog.show(this)
            return
        # treba drugacija klasa koja ce prikazati
        # sta je sve radnik do sada uradio
        # if closest(target, '.js--user--activity')
        #     @activityDialog.show(@worker.id)
        #     return

    _loadedWorker: (response) ->
        @worker = response.data
        @pageHTML()

    _toggleBlockUserText: () ->
        text = 'Deaktiviraj'
        if @worker.deleted
            text = 'Aktiviraj'
        return text

    _customHTML: () ->
        if @worker
            innerHTML = @_toggleBlockUserText()
            html = "<nav class='nav justify-content-end header pt-3'>
                        <span class='nav-link span-a back-button js--back--button'>Nazad</span>
                        <span class='nav-link span-a js--block--user'>#{innerHTML}</span>
                        <span class='nav-link span-a js--user--activity'>Aktivnosti</span>
                        <span class='nav-link span-a js--create--expense'>Kreiraj rashod</span>
                    </nav>"
            html += ComponentsUtils.userDetailsFilledHTML(@worker)
            return html
        else
            ComponentsUtils.emptyState('Korisnik nije pronadjen :(')



    _toggleBlockUser: () ->
        # @user.active = !@user.active
        # @updatedUser = true
        # $(".js--block--user").html(@_toggleBlockUserText())
        # UserService.toggleBlockUser(@user.id, null, this, @_globalSuccessMessage, @_globalErrorMessage)