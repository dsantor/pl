class @WorkersPage extends AbstractPage

    constructor: () ->
        super()
        @pageHTML()
        WorkerService.getAll(null, this, @_workersLoadedSuccess, @_workersLoadedError)
        @createWorkerDialog = new CreateWorkerDialog()

        @workersContainer = @container.find('.js--container--workers')
        @_workerStatusEvent = @_workerStatusEventHandler.bind(this)

        @createdNewWorkerEvent = @_createdNewWorkerEventHandler.bind(this)
        EventUtils.bindCreatedNewWorker(@createdNewWorkerEvent)

    destroy: () ->
        super()
        @createWorkerDialog.destroy()
        @createWorkerDialog = null

        if @_workerASInputEvent            
            @workerASInput.off 'keyup', @_workerASInputEvent
            @_workerASInputEvent = null
            @workerASInput = null
            @workerSuggestionsContainer = null

        if @_workerStatus
            @_workerStatus.off 'change', @_workerStatusEvent
            @_workerStatusEvent = null
            @_workerStatus = null

        EventUtils.unbindCreatedNewWorker(@workerStatusEvent)
        @workerStatusEvent = null

    getPageTitle: () ->
        return "Radnici"

    _clickEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--create--worker')
            @createWorkerDialog.show()

        if closest(target, '.js--show--worker')
            id = target.attr('data-worker-id')
            window.location.hash = 'worker/' + id
    
        if closest(target, '.js--filters--button')
            $('.js--filters--content').toggleClass('show')
            return
        
        if closest(target, '.js--worker--suggestions')
            @_choseWorkerFromAutoSuggestion(target)
            return

        if closest(target, '.js--filter--reset')
            @_resetFilter()
            return

        @workerSuggestionsContainer.addClass('hide')


    _workersLoadedSuccess: (response) ->
        @workers = response.data
        
        @_renderWorkersHTML(@workers)
        @workerASInput = @container.find('.js--worker--as')
        @workerSuggestionsContainer = @container.find('.js--worker--suggestions')
        @_workerASInputEvent = @_workerASInputEventHandler.bind(this)
        @workerASInput.on 'keyup', @_workerASInputEvent

        @workerStatus = @container.find('.js--filter--status')        
        @workerStatus.on 'change', @_workerStatusEvent

    _customHTML:(workers) ->
        tableHtml = "<div>
                        <nav class='nav justify-content-end pt-3'>
                            <span class='nav-link span-a js--create--worker'>Dodaj radnika</span>
                        </nav>
                        #{@_getFiltersHTML()}
                        <div class='js--container--workers'>
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
            if w.deleted
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
        return "<div class='card-header card bp-4'>
                    <h2 class='mb-0 text-center'>
                        <span  class='span-a btn pointer m-auto js--filters--button' data-toggle='collapse' data-target='#collapseOne'>Filteri</span>
                    </h2>
                    </div>
                        <div id='collapseOne' class='collapse card js--filters--content'>
                            <div class='card-body w-75 m-auto flex'>
                                <div class='flex-column w-100'>
                                    <div class='flex flex-row justify-content-around pb-3'>
                                        <div class='flex flex-row w-40'>
                                            <label class='mr-2 w-25 d-inline-block'>Pretraži</label>
                                            <div class='pos-rel w-100'>
                                                <input type='text' class='form-control w-100 input-icon-icon-24 js--worker--as'/>
                                                <i class='input-icon-24 search-icon cursor-initial'></i>
                                                <div class='suggestion-container js--worker--suggestions pos-abs hide'></div>
                                            </div>        
                                        </div>                                    
                                    
                                        <div class='flex flex-row w-40'>
                                        <label class='mr-2 wh-10'>Status</label>
                                            <select class='js--filter--status'>
                                                <option selected value='active'>Zaposlen</option>
                                                <option value='deactive'>Otpušten</option>
                                                <option value='all'>Svi</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class='w-100 flex justify-content-center'>
                                        <input type='button' class='btn btn-primary js--filter--reset' value='Restart filter'/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>"
    _workerASInputEventHandler: (event) ->
        ComponentsUtils.handleAutoSuggestion(@workerASInput, 'data-worker-id', @workers, @workerSuggestionsContainer, true, this, @_resetFilter)
    
    _choseWorkerFromAutoSuggestion: (target) ->
        ComponentsUtils.selectFromAutoSuggestion(target, @workerASInput, 'data-worker-id', @workers, @workerSuggestionsContainer)
        @_applyFilter()
    

    _workerStatusEventHandler: (event) ->
        @_applyFilter()

    _applyFilter: () ->
        status = @workerStatus.val()
        # @workerASInput.val('') 
        workers = []
        if status == 'all'
            workers = @workers
        else if status == 'active'
            for worker in @workers
                if not worker.deleted
                    workers.push(worker)
        else
            for worker in @workers
                if worker.deleted
                    workers.push(worker)

        id = Number(@workerASInput.attr('data-worker-id'))
        if (! isNaN(id)) 
            filteredWorkers = []
            for worker in workers
                if worker.id == id 
                    filteredWorkers.push(worker)
            workers = filteredWorkers
                 
        @_renderWorkersHTML(workers)

    _resetFilter: () ->
        @workerASInput.val('')
        @workerASInput.removeAttr('data-worker-id')
        @workerStatus.val('active')
        @_renderWorkersHTML(@workers)
    
    _createdNewWorkerEventHandler: (event, worker) ->
        @workers.push(worker)
        @_renderWorkersHTML(@workers)