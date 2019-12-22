class @WorkersPage extends AbstractPage

    constructor: () ->
        super()
        @pageHTML()
        WorkerService.getAll(null, this, @_workersLoadedSuccess, @_workersLoadedError)
        @createWorkerDialog = new CreateWorkerDialog()

        @workersContainer = @container.find('.js--container--workers')
        @filterContainer = @container.find('.js--filter--container')

        # Auto suggestion        
        @autoSuggestion = new AutoSuggestion(this, @filterContainer, AutoSuggestion.BASE_FILTER)
        @workerASInput = @container.find('.js--filter--as')
        @suggestionsContainer = @container.find('.js--filter--suggestions')
        @workerStatus = @container.find('.js--filter--status')        

        @createdNewWorkerEvent = @_createdNewWorkerEventHandler.bind(this)
        EventUtils.bindCreatedNewWorker(@createdNewWorkerEvent)

    destroy: () ->
        super()
        @createWorkerDialog.destroy()
        @createWorkerDialog = null

        @autoSuggestion.destroy()
        @autoSuggestion = null

        @workersContainer     = null
        @filterContainer      = null
        @workerASInput        = null
        @suggestionsContainer = null
        @workerStatus         = null

        EventUtils.unbindCreatedNewWorker(@createdNewWorkerEvent)
        @createdNewWorkerEvent = null

    getPageTitle: () ->
        return "Radnici"

    _clickEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--create--worker')
            @createWorkerDialog.show()

        if closest(target, '.js--show--worker')
            id = target.attr('data-worker-id')
            window.location.hash = 'worker/' + id

        @suggestionsContainer.addClass('hide')


    _workersLoadedSuccess: (response) ->
        @workers = response.data        
        @_renderWorkersHTML(@workers)        

    _customHTML:() ->
        tableHtml = "<div>
                        <nav class='nav justify-content-end pt-3'>
                            <span class='nav-link span-a js--create--worker'>Dodaj radnika</span>
                        </nav>
                        <div class='js--filter--container'>
                        </div>
                        <div class='js--container--workers'>
                            #{ComponentsUtils.loadingPage()}
                        </div>
                    </div>"

        return tableHtml

    _renderWorkersHTML: (workers) ->
        if workers.length is 0
            @workersContainer.html(@emptyState())
            return

        tableHtml = "<table class='table mb-0'>
                <tr>
                    <th class='table-text w-10'>Profil</th>
                    <th class='table-text w-20'>Ime</th>
                    <th class='table-text w-20'>Prezime</th>
                    <th class='table-text w-20'>Telefon</th>
                    <th class='table-text w-30'>Email</th>
                </tr>
            </table>
            <table class='table table-striped'>"
        rowHtml = ""
        for w in workers
            if not w.active
                userIcon = 'blocked-user-icon'
            else
                userIcon = 'user-icon'
            rowHtml = "<tr class='js--user--row' data-worker-id=#{w.id}>
                        <td class='table-text w-10'><span class='#{userIcon} js--show--worker' data-worker-id=#{w.id}></span></td>
				        <td class='table-text w-20'>#{w.firstName or '/'}</td>
				        <td class='table-text w-20'>#{w.lastName or '/'}</td>
                        <td class='table-text w-20'>#{w.phoneNumber or '/'}</td>
                        <td class='table-text w-30'>#{w.email or '/'}</td>
			        </tr>"
            
            tableHtml += rowHtml
        tableHtml += "</table>"
        @workersContainer.html(tableHtml)
        
    _workersLoadedError: (response) ->

    emptyState: () ->
        ComponentsUtils.emptyState('Nema unetih radnika :(', "<input type='button' class='btn btn-primary d-block js--create--worker' value='Dodaj radnika'/>")

    _getFiltersHTML: () ->
        return ComponentsUtils.baseFilter()
    
    triggerFilterAs: (event) ->
        ComponentsUtils.handleAutoSuggestion(@workerASInput, 'data-worker-id', @workers, @suggestionsContainer, true, this, @_resetFilter)

    triggerFilterStatus: (event) ->
        @_applyFilter()                   

    triggerFilterSuggestions: (event) ->
        target = $(event.target)
        ComponentsUtils.selectFromAutoSuggestion(target, @workerASInput, 'data-worker-id', @workers, @suggestionsContainer)
        @_applyFilter()
        return

    triggerFilterReset: (event) ->
        @_resetFilter()
        return

    _applyFilter: () ->
        status = @workerStatus.val()
        # @workerASInput.val('') 
        workers = []
        if status == 'all'
            workers = @workers
        else if status == 'active'
            for worker in @workers
                if worker.active
                    workers.push(worker)
        else
            for worker in @workers
                if not worker.active
                    workers.push(worker)

        id = Number(@workerASInput.attr('data-worker-id'))
        if (! isNaN(id)) 
            filteredWorkers = []
            for worker in workers
                if worker.id == id 
                    filteredWorkers.push(worker)
            workers = filteredWorkers

        if workers.length is 0
            @workersContainer.html(@autoSuggestion.emptyState())
        else 
            @_renderWorkersHTML(workers)

    _resetFilter: () ->
        @workerASInput.val('')
        @workerASInput.removeAttr('data-worker-id')
        @workerStatus.val(@workerStatus[0].options[0].value)
        @_renderWorkersHTML(@workers)
    
    _createdNewWorkerEventHandler: (event, worker) ->
        @workers.push(worker)
        @_renderWorkersHTML(@workers)