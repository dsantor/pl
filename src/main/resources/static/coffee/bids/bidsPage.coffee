class @BidsPage

    constructor: (clientId) ->
        @clientId = clientId
        @client = null
        @clients = []
        @newClient = null
        @worker = null
        @workerIds = []
        @allWorkers = []
        @bidCurrentId = 1
        @container = $('.js--page--container')
        @allowedSaveBidsButton = false
        @oldClientIsChosen     = true
        @_renderChoseBidHTML()

        WorkerService.getAll(null, this, @_loadWorkersSuccess, @_loadWorkersError)

        if @clientId
            ClientService.get(clientId, null, this, @_loadedClientSuccess, @_loadWorkersError)
        else
            ClientService.getAll(null, this, @_loadedClientsSuccess, @_loadWorkersError)

        @bidsContainer              = @container.find('.bids--container')        
        @overviewContainer          = @container.find('.overview--container')

        @autoSuggestInputs          = @container.find('.js--autosuggest--input')  
        @workerInput                = @container.find('.js--worker--input')   
        @workersChosenContainer     = @container.find('.js--workers--chosen')
        @workerSuggestionsContainer = @container.find('.js--worker--suggestions')

        @clientInput                = @container.find('.js--client--input')   
        @clientSuggestionsContainer = @container.find('.js--client--suggestions')
        
        @saveOrderErrorMessage      = @container.find('.js--order--error--message')

        @newClientContainer = @container.find('.js--radio--button--new--client--container')
        @oldClientContainer = @container.find('.js--radio--button--old--client--container')
        @oldClientButton    = @container.find('.js--radio--button--old--client')
        @newClientButton    = @container.find('.js--radio--button--new--client')
        @orderStatus        = @container.find('.js--order--status')
        @orderDownPlayment  = @container.find('.js--down--payment')

        @firstName    = @container.find('.js--firstName')
        @lastName     = @container.find('.js--lastName')
        @street       = @container.find('.js--street')
        @buildNumber  = @container.find('.js--buildNumber')
        @city         = @container.find('.js--city')
        @phoneNumber  = @container.find('.js--phoneNumber')
        @email        = @container.find('.js--email')

        @buildDate    = @container.find('.js--build--date')
        @clickEvent   = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

        @autoSuggestInputEvent = @_autoSuggestInputEventHandler.bind(this)
        @autoSuggestInputs.on 'keyup', @autoSuggestInputEvent

        @doorBidDialog             = new DoorBidDialog()
        @thresholdBidDialog        = new ThresholdBidDialog()
        @windowBidDialog           = new WindowBidDialog()
        @shutterBidDialog          = new ShutterBidDialog()
        @mosquitoRepellerBidDialog = new MosquitoRepellerBidDialog()

        @cartList = {}
        
    destroy: () ->
        
        @doorBidDialog.destroy()
        @doorBidDialog = null
        
        @windowBidDialog.destroy()
        @windowBidDialog = null

        @shutterBidDialog.destroy()
        @shutterBidDialog = null
        
        @thresholdBidDialog.destroy()
        @thresholdBidDialog = null

        @mosquitoRepellerBidDialog.destroy()
        @mosquitoRepellerBidDialog = null

        @container.off 'click', @clickEvent
        @clickEvent= null

        @autoSuggestInputs.off 'keyup', @autoSuggestInputEvent
        @autoSuggestInputEvent = null

        @bidsContainer              = null
        @overviewContainer          = null
        @autoSuggestInputs          = null
        @workerSuggestionsContainer = null
        @clientInput                = null
        @clientSuggestionsContainer = null
        @buildDate                  = null
        @orderStatus                = null
        @orderDownPlayment          = null

        @container.html('')
        @clientId              = null
        @client                = null
        @clients               = null
        @newClient             = null
        @worker                = null
        @workerIds             = null
        @bidCurrentId          = null
        @cartList              = null
        @allowedSaveBidsButton = null
        @oldClientIsChosen     = null 

        @firstName             = null
        @lastName              = null
        @street                = null
        @buildNumber           = null
        @city                  = null
        @phoneNumber           = null
        @email                 = null


    getPageTitle: () ->
        return "Porudzbine"
    
    _renderChoseBidHTML: () ->
        bodyHTML = "<div class='container bids--container bids-container' data-page='bids'>
                        <nav class='nav header justify-content-end pt-3'>
                            <span class='nav-link span-a js--chose--bids nav--bids active'>Odaberi proizvod</span>
                            <span class='nav-link span-a js--bids--overview nav--overview nav--empty'>Pregled porudzbine</span>
                            <span class='nav-link span-a #{@_createClientButtonClass()} js--chose--client nav--client'>Unesi klijenta</span>
                            <span class='nav-link span-a js--bids--order nav--order'>Poruči</span>
                        </nav>
                        <div class='col-7 m-auto w-100 pt-3 flex flex-column bidsPage' data-page='bids'>
                            <div class='flex flex-row justify-content-center'>
                                <div class='item-order text-center mb-5'>
                                        <div class='js--create--door'>
                                            <img class='item-order pointer' draggable=false src='/images/door.png'>
                                        </div>
                                        <label>Vrata</label>
                                    </div>
                                    <div class='item-order text-center'>
                                        <div class='js--create--threshold'>
                                            <img class='item-order pointer' draggable=false src='/images/threshold.png'>
                                        </div>
                                        <label>Prag</label>
                                    </div>
                                    <div class='item-order text-center'>
                                        <div class='js--create--mosquito--repeller'>
                                            <img class='item-order pointer' draggable=false src='/images/mosquitoRepeller.png'>
                                        </div>
                                        <label>Komarnik</label>
                                    </div>
                            </div>
                            <div class='flex flex-row justify-content-center'>
                            <div class='item-order text-center mb-5'>
                                    <div class='js--create--window'>
                                        <img class='item-order pointer' draggable=false src='/images/window.png'>
                                    </div>
                                    <label>Prozor</label>
                                </div>
                                <div class='item-order text-center'>
                                    <div class='js--create--shutter'>
                                        <img class='item-order pointer' draggable=false src='/images/shutter.png'>
                                    </div>
                                    <label>Roletne</label>
                                </div>
                            </div>
                        </div>
                        <div class='bidsClient' data-page='client'>
                            <div class='col-7 m-auto h-75 pt-5 flex'>
                                <div class='form-group w-50'>
                                    <div class='container'>
                                        <label class='js--radio--button--old--client switch-section active'>Postojeci klijent</label>
                                        <div class='js--radio--button--old--client--container'>
                                            <input type='text' class='form-control js--autosuggest--input js--client--input' placeholder='klijent'>
                                            <div class='suggestion-container js--client--suggestions hide'>
                                            </div>    
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class='col-7 m-auto h-75 pt-5 flex'> 
                                <div class='container'>
                                    <label class='js--radio--button--new--client switch-section'>Kreiraj klijenta</label>
                                </div>
                            </div>
                            <div class='col-7 m-auto h-75 flex js--radio--button--new--client--container disabled'>
                                
                                <div class='container w-50'>
                                    
                                    <div class='form-group'>
                                        <label>Email</label>
                                        <input type='email' class='form-control js--email' placeholder='email'/>
                                    </div>

                                    <div class='form-group'>
                                        <label>Ime*</label>
                                        <input type='text' class='form-control js--firstName' placeholder='ime'/>
                                        </div>
                                    <div class='form-group'>
                                        <label>Prezime*</label>
                                        <input type='text' class='form-control js--lastName' placeholder='prezime'/>
                                    </div>
                                
                                    <div class='form-group'>
                                        <label>Ulica</label>
                                        <input type='text' class='form-control js--street' placeholder='ulica'/>
                                    </div>
                                </div>
                                <div class='container w-50'>
                                    <div class='form-group'>
                                        <label>Broj stana</label>
                                        <input type='text' class='form-control js--buildNumber' placeholder='broj kuce/stana'/>
                                    </div>
                                    <div class='form-group'>
                                        <label>Grad</label>
                                        <input type='text' class='form-control js--city' placeholder='grad'/>
                                    </div>
                                    
                                    <div class='form-group'>
                                        <label>Telefon*</label>
                                        <input type='tel' class='form-control js--phoneNumber' placeholder='telefon'/>
                                    </div>               
                                </div>
                            </div>
                        </div>
                        <div class='pt-3 flex flex-column overview--container bidsOverview' data-page='overview'></div>
                        <div class='pt-3 flex flex-column bidsEmptyState' data-page='empty'>
                            #{BidSectionsHTML.emptyState()}
                        </div>
                        <div class='col-7 m-auto p-5 flex bidsOrder' data-page='order'>
                            <div class='container container-padding w-50'>
                                <div class='form-group'>
                                    <label>Datum ugradnje</label>
                                    <input type='date' class='form-control js--build--date'>
                                </div>
                                <div class='form-group'>
                                    <label>Radnik</label>
                                     <input type='text' hidden='hidden'>
                                    <input type='text' class='form-control js--autosuggest--input js--worker--input' placeholder='radnik'>
                                    <div class='suggestion-container js--worker--suggestions hide'>
                                    </div>
                                    <div class='mt-3 js--workers--chosen'>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label>Status porudzbine</label>
                                    <select class='js--order--status'>
                                        <option value='WAITING' selected>Na čekanju</option>
                                        <option value='ACCEPTED'>Prihvaćen</option>
                                        <option value='DECLINED'>Odbijen</option>
                                    </select>
                                </div>
                                <div class='form-group'>
                                    <label>Kapara</label>
                                    <input type='number' class='form-control js--down--payment' placeholder='din'/>
                                </div>
                                <div class='form-group'>
                                    <button class='btn btn-lg btn-primary btn-block js--save--order'>Poruči</button>
                                    <span class='text-danger js--order--error--message hide'>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>"
        @container.html(bodyHTML)

    _clickEventHandler: (event) ->
        target = $(event.target)
        
        if closest(target, ".js--create--door")
            @doorBidDialog.show(this)
            return

        if closest(target, ".js--create--threshold")
            @thresholdBidDialog.show(this)
            return
        
        if closest(target, ".js--create--mosquito--repeller")
            @mosquitoRepellerBidDialog.show(this)
            return

        if closest(target, ".js--create--window")
            @windowBidDialog.show(this)
            return

        if closest(target, ".js--create--shutter")
            @shutterBidDialog.show(this)
            return
       
        if closest(target, '.js--bids--overview')
            @_showBids()
            return
        
        if closest(target, '.js--chose--bids')
            @_activePage('bids')
            return

        if closest(target, '.js--chose--client')
            @_activePage('client')
            return

        if closest(target, '.js--bids--order')
            @saveOrderErrorMessage.addClass('hide')
            @_activePage('order')
            return

        if closest(target, '.js--remove--bid')
            @_removeBid(target)
            return

        if closest(target, '.js--edit--bid')
            @_editBid(target)
            return

        if closest(target, '.js--worker--suggestions')
            @_selectWorkerFromAutoSuggestion(target)
            return
        
        if closest(target, '.js--client--suggestions')
            @_selectClientFromAutoSuggestion(target)
            return
        if closest(target, '.js--save--order')
            @_saveOrder()
            return
        
        if closest(target, '.js--radio--button--old--client')
            @_setNewClientContainer(false)
            return

        if closest(target, '.js--radio--button--new--client')
            @_setNewClientContainer(true)
            return
        
        if closest(target, '.remove--worker')
            @_removeWorkerFromSelectedList(target)
            return
    
    _setNewClientContainer: (newClient) ->
        if newClient
            @newClientContainer.removeClass('disabled')
            @oldClientContainer.addClass('disabled')
            @oldClientButton.removeClass('active')
            @newClientButton.addClass('active')
            @oldClientIsChosen = false
        else
            @oldClientContainer.removeClass('disabled')
            @newClientContainer.addClass('disabled')
            @newClientButton.removeClass('active')
            @oldClientButton.addClass('active')
            @oldClientIsChosen = true


    _autoSuggestInputEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--worker--input')
            @_workerAutoSuggestion()
            return
        if closest(target, '.js--client--input')
            @_clientAutoSuggestion()
            return

    _workerAutoSuggestion: () ->
        input = @workerInput.val()
        if input.length < 1
            @workerSuggestionsContainer.addClass('hide')
            return

        workers = []
        for w in @allWorkers
            input = input.toLowerCase()
            firstName = w.firstName.toLowerCase()
            lastName = w.lastName.toLowerCase()
            if firstName.startsWith(input) or lastName.startsWith(input)
                workers.push(w)
        if workers.length > 0
            html = ''
            for worker in workers
                html += "<span class='suggestion-item' data-worker-id='#{worker.id}'>#{worker.firstName} #{worker.lastName}</span>"
            @workerSuggestionsContainer.html(html)
            @workerSuggestionsContainer.removeClass('hide')
        else 
            @workerSuggestionsContainer.addClass('hide')

    _clientAutoSuggestion: () ->
        input = @clientInput.val()
        if input.length < 1
         @clientSuggestionsContainer.addClass('hide')
         return

        clients = []
        phoneNumbers = []
        for client in @clients
            input = input.toLowerCase()
            firstName = client.firstName.toLowerCase()
            lastName = client.lastName.toLowerCase()
            if firstName.startsWith(input) or lastName.startsWith(input)
                clients.push(client)
            else if client.phoneNumber.startsWith(input)
                phoneNumbers.push(client)
        
        html = ''
        if clients.length > 0
            for client in clients
                html += "<span class='suggestion-item' data-client-id='#{client.id}'>#{client.firstName} #{client.lastName}</span>"
        
        if phoneNumbers.length > 0
            for phoneNumber in phoneNumbers
                html += "<span class='suggestion-item' data-client-id='#{phoneNumber.id}'>#{phoneNumber.phoneNumber}</span>"
        
        if clients.length > 0 or phoneNumbers.length > 0
            @clientSuggestionsContainer.html(html)
            @clientSuggestionsContainer.removeClass('hide')
        else 
            @clientSuggestionsContainer.addClass('hide')

    _activePage: (page) ->
        @bidsContainer.attr('data-page', page)
        @bidsContainer.find('.nav-link').removeClass('active')
        @bidsContainer.find(".nav--#{page}").addClass('active')


    _editBid: (element) ->
        bidId = Number(element.attr('data-bid-id'))
        bidRow = $(".js--bid--row[data-bid-id='#{bidId}']")
        bidType = bidRow.attr('data-bid-type')
        data = null
        for item in @cartList[bidType]
            if item.id is bidId
                data = item
                break
        @_openEditDialog(bidType, data)
    
    _openEditDialog: (bidType, data) ->
        switch bidType
            when DoorBidDialog.BID_TYPE
                @doorBidDialog.show(this, data)
                break

            when ThresholdBidDialog.BID_TYPE
                @thresholdBidDialog.show(this, data)
                break

            when MosquitoRepellerBidDialog.BID_TYPE
                @mosquitoBidDialog.show(this, data)
                break

            when WindowBidDialog.BID_TYPE
                @windowBidDialog.show(this, data)
                break

            when ShutterBidDialog.BID_TYPE
                @shutterBidDialog.show(this, data)
                break

            else 
                console.log 'Dialog is not supported'       
        

    _removeBid: (target) ->
        bidId = Number(target.attr('data-bid-id'))
        bidRow = $(".js--bid--row[data-bid-id='#{bidId}']")
        bidType = bidRow.attr('data-bid-type')
        bidRow.remove()
        
        for bid, index in @cartList[bidType]
            if bid.id is bidId
                @cartList[bidType].splice(index, 1)
                break
        
        @_updateResultSections()

    _updateResultSections: () ->
        keys = Object.keys(@cartList)
        for key in keys
            if @cartList[key].length is 0
                keyLowecase = key.toLowerCase()
                sectionName = ".js--section--#{keyLowecase}"
                $(sectionName).remove()
                delete @cartList[key]

        keys = Object.keys(@cartList)
        if keys.length is 0
            @allowedSaveBidsButton = false
            @_activePage('empty')

    _getClientIdFromURL: () ->
        hash = window.location.hash
        return hash.substring(hash.indexOf('/'))

    
    bidDialogResult: (data) ->
        @allowedSaveBidsButton = true
        $('.js--save--bids').removeClass('disabled')
        if @cartList[data.bidType] is undefined
            @cartList[data.bidType] = []

        if data.id is null
            @_addItemToCartList(data)
        else
            @_updateItemFromCartList(data)

    _addItemToCartList: (data) ->
        data.id = @bidCurrentId++
        @cartList[data.bidType].push(data)

    _updateItemFromCartList: (data) ->
        for item, index in @cartList[data.bidType]
            if item.id is data.id
                @cartList[data.bidType][index] = data
                break
        @_showBids()

    _showBids: () ->
        keys = Object.keys(@cartList)

        if keys.length is 0
            @allowedSaveBidsButton = false
            @_activePage('empty')
            return

        html = ''    
        for key in keys
            if @cartList[key].length > 0
                html += @_renderOverviewBidSection(key)
        
        @overviewContainer.html(html)
        @_activePage('overview')
        
    _renderOverviewBidSection: (bidType) ->
        switch bidType
            when DoorBidDialog.BID_TYPE
                return BidSectionsHTML.doorSectionHTML(@cartList[bidType])

            when ThresholdBidDialog.BID_TYPE
                return BidSectionsHTML.thresholdSectionHTML(@cartList[bidType])

            when MosquitoRepellerBidDialog.BID_TYPE
                return BidSectionsHTML.mosquitoRepellerSectionHTML(@cartList[bidType])

            when WindowBidDialog.BID_TYPE
                return BidSectionsHTML.windowSectionHTML(@cartList[bidType])
                
            when ShutterBidDialog.BID_TYPE
                return BidSectionsHTML.shutterSectionHTML(@cartList[bidType])
            else 
                return ''             

    _createClientButtonClass: () ->
        if @clientId then return 'disabled' else return ''

    _loadWorkersSuccess: (response) ->
        @allWorkers = response.data

    _loadWorkersError: (response) ->
        console.log response.message

    _selectWorkerFromAutoSuggestion: (target) ->
        id = Number(target.attr('data-worker-id'))
        addHtml = false
        for worker in @allWorkers
            if worker.id is id
                if not @workerIds.includes(id)
                    @workerIds.push(worker.id)
                    addHtml = true
                break
        if addHtml
            workerHTML = "<div class='w-100 br-8 nav-link nav-tabs border remove--worker--container' data-worker-id='#{id}'>
                            <span>#{worker.firstName + ' ' + worker.lastName.charAt(0)}</span>
                            <span class='remove-icon close remove--worker'>
                            </span>
                            </div>"
            @workersChosenContainer.append(workerHTML)
        @workerInput.val('')
        @workerSuggestionsContainer.addClass('hide')

    _removeWorkerFromSelectedList: (target) ->
        id = Number(target.closest('.remove--worker--container').attr('data-worker-id'))
        for worker in @allWorkers
            if worker.id is id
                @allWorkers.splice(worker, 1)
                $(".remove--worker--container[data-worker-id='#{id}']").remove()
                break
    _selectClientFromAutoSuggestion: (target) ->
        id = Number(target.attr('data-client-id'))
        for client in @clients
            if client.id is id
                @client = client
                break
        
        @clientInput.val(@client.firstName + ' ' + @client.lastName)
        @clientSuggestionsContainer.addClass('hide')

    _loadedClientSuccess: (response) ->
        @client = response.data

    _loadedClientsSuccess: (response) ->
        @clients = response.data

    _saveOrder: () ->
        keys = Object.keys(@cartList)
        if keys.length is 0
            @saveOrderErrorMessage.html('Korpa je prazna!').removeClass('hide')
            return
        
        clientId = null
        newClient = null
        if @oldClientIsChosen
            if @client is null
                @saveOrderErrorMessage.html('Klijent nije odabran!').removeClass('hide')
                return
            clientId = @client.id
        else
            valid       = true
            firstName    = @firstName.val().trim()
            lastName     = @lastName.val().trim()
            street       = @street.val().trim()
            buildNumber  = @buildNumber.val().trim()
            city         = @city.val().trim()
            phoneNumber  = @phoneNumber.val().trim()
            email        = @email.val().trim()

            if firstName is ''
                @firstName.addClass(ComponentsUtils.CSS_INVALID_INPUT)
                valid = false
            else
                @firstName.removeClass(ComponentsUtils.CSS_INVALID_INPUT)
                
            if lastName is ''
                @lastName.addClass(ComponentsUtils.CSS_INVALID_INPUT)
                valid = false
            else
                @lastName.removeClass(ComponentsUtils.CSS_INVALID_INPUT)

            if Validation.phone(phoneNumber)
                @phoneNumber.removeClass(ComponentsUtils.CSS_INVALID_INPUT)
            else
                valid = false
                @phoneNumber.addClass(ComponentsUtils.CSS_INVALID_INPUT)
    
            if not valid
                return
            else 
                newClient = {
                    firstName   : firstName
                    lastName    : lastName
                    street      : street
                    buildNumber : buildNumber
                    city        : city
                    phoneNumber : phoneNumber
                    email       : email
                }
        if @workerIds.length == 0
            @saveOrderErrorMessage.html('Radnik nije odabran!').removeClass('hide')
            return

        if @buildDate.val() is ''
            @saveOrderErrorMessage.html('Vreme ugradnje nije odabrano!').removeClass('hide')
            return
        
        orderDownPlayment = @orderDownPlayment.val()
        if orderDownPlayment is ''
            orderDownPlayment = 0
        else if orderDownPlayment < 0
            @saveOrderErrorMessage.html('Kapara ne moze biti negativna!').removeClass('hide')
            return

        @saveOrderErrorMessage.addClass('hide')

        buildDate = new Date(@buildDate.val()).getTime()
        data = {
            doors             : @cartList[DoorBidDialog.BID_TYPE]
            thresholds        : @cartList[ThresholdBidDialog.BID_TYPE]
            mosquitos         : @cartList[MosquitoRepellerBidDialog.BID_TYPE]
            windows           : @cartList[WindowBidDialog.BID_TYPE]
            shutters          : @cartList[ShutterBidDialog.BID_TYPE]
            clientId          : clientId
            createClient      : newClient
            workerIds         : @workerIds
            buildDate         : buildDate
            oldClientIsChosen : @oldClientIsChosen
            orderStatus       : @orderStatus.val()
            downPlayment      : orderDownPlayment
        }

        OrderService.create(data, null, this, @_orderSavedSuccess, @_loadWorkersError)

    _orderSavedSuccess: (response)->
        console.log response