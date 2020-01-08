class @AutoSuggestion

    @BASE_FILTER = 'base_filter'
    @ORDER_FILTER = 'order_filter'
    @EXPENSE_FILTER = 'expense_filter'
    # @asInput = @container.find('.js--filter--as')
    # @suggestionsContainer = @container.find('.js--filter--suggestions')
    # @status = @container.find('.js--filter--status')        
    # @filterToggleButton = @container.find('.js--filters--content')
    constructor: (@parentPage, @container, filterType, @status) ->
        @container.html(@_getHTMLByFilterType(filterType))

        @filterToggleButton = @container.find('.js--filters--content')
        @filterSuggestionsContainer = @container.find('.js--filter--suggestions')

        @keyupEvent = @_keyupEventHandler.bind(this)
        @container.on 'keyup', @keyupEvent

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

        @changeEvent = @_changeEventHander.bind(this)
        @container.on 'change', @changeEvent

    destroy: () ->
        @container.off 'keyup', @keyupEvent
        @keyupEvent = null
        
        @container.off 'click', @clickEvent
        @clickEvent = null

        @container.off 'change', @changeEvent
        @changeEvent = null

        @container = null
        @parentPage = null
        @filterToggleButton = null
        @status = null

    _keyupEventHandler: (event) ->
        target = $(event.target)
        if closest(target, '.js--filter--as')
            @parentPage.triggerFilterAs?(event)
            return

        @parentPage.AutoSuggestionKeyUpEventHander?(event)

    _changeEventHander: (event) ->
        target = $(event.target)
        if closest(target, '.js--filter--status')
            @parentPage.triggerFilterStatus?(event)
            return

        if closest(target, '.js--filter--from')
            @parentPage.triggerFilterFrom?(event)
            return

        if closest(target, '.js--filter--to')
            @parentPage.triggerFilterTo?(event)
            return

        if closest(target, '.js--filter--sum--from')
            @parentPage.triggerFiterSumFrom?()
            return
        
        if closest(target, '.js--filter--sum--to')
            @parentPage.triggerFiterSumTo?()
            return

        @parentPage.AutoSuggestionChangeEventHander?(event)

    _clickEventHandler: (event) ->
        target = $(event.target)
        if closest(target, '.js--filters--button')
            @filterToggleButton.toggleClass('show')
            return

        if closest(target, '.js--filter--suggestions')
            @parentPage.triggerFilterSuggestions?(event)
            return
        
        if closest(target, '.js--filter--reset')
            @parentPage.triggerFilterReset?(event)
            return
        
        @filterSuggestionsContainer.addClass('hide')
        @parentPage.AutoSuggestionClickEventHander?(event)

    # Override
    triggerFilterAs: (event) ->
    triggerFilterSuggestions: (event) ->
    triggerFilterStatus: (event) ->
    triggerFilterReset: (event) ->

    _getHTMLByFilterType: (filterType) ->
        switch filterType
            when AutoSuggestion.BASE_FILTER
                return @_baseFilter()       
            when AutoSuggestion.ORDER_FILTER
                return @_orderFilter()
            when AutoSuggestion.EXPENSE_FILTER
                return @_expenseFilter()
            else 
                console.log 'ops ops'

    emptyState: () ->
        return "<div class='col-5 m-auto h-75 pt-5 text-center'>Prazna pretraga :(</div>"

    _baseFilter: () ->
        return @_filterWrapperHTML(@_filterBaseHTML())
    
    _orderFilter: () ->
        return @_filterWrapperHTML(@_filterOrderHTML())

    _expenseFilter: () ->
        return @_filterWrapperHTML(@_expenseOrderHTML())

    _filterWrapperHTML: (innerHtml) ->
         return "<div class='card-header card bp-4'>
                    <h2 class='mb-0 text-center'>
                        <span  class='span-a btn pointer m-auto js--filters--button' data-toggle='collapse' data-target='#collapseOne'>Filteri</span>
                    </h2>
                    </div>
                        <div id='collapseOne' class='collapse card js--filters--content'>
                            <div class='card-body w-75 m-auto flex'>
                            #{innerHtml}
                            </div>
                        </div>
                    </div>
                </div>"

    _applyStatus: () ->
        statusHTML = ''
        if @status
            index = 1
            length = @status.length
            statusHTML += "<option value='#{@status[0].key}' selected>#{@status[0].value}</option>"
            while index < length
                statusHTML += "<option value='#{@status[index].key}'>#{@status[index].value}</option>"
                index++
        else
            statusHTML = " <option value='all' selected>Svi</option>
                            <option value='active'>Zaposlen</option>
                            <option value='deactive'>Otpušten</option>"
        return statusHTML

    _filterBaseHTML: () ->
        return "<div class='flex-column w-100'>
                    <div class='flex flex-row justify-content-around pb-3'>
                        <div class='flex flex-row w-40'>
                            <label class='flex mr-2 mb-0 align-self-center w-fit-content'>Pretraži</label>
                            <div class='pos-rel w-100 mb-2'>
                                <input type='text' class='form-control w-100 input-icon-icon-24 js--filter--as'/>
                                <i class='input-icon-24 search-icon cursor-initial'></i>
                                <div class='suggestion-container js--filter--suggestions pos-abs hide'></div>
                            </div>        
                        </div>                                    
                    
                        <div class='flex flex-row w-40 mb-2'>
                        <label class='mr-2 mb-0 align-self-center wc-10'>Status</label>
                            <select class='js--change js--filter--status'>
                               #{@_applyStatus()}
                            </select>
                        </div>
                    </div>
                    <div class='w-100 flex justify-content-center'>
                        <input type='button' class='btn btn-primary js--filter--reset' value='Reset filter'/>
                    </div>
                </div>"
    
    _filterOrderHTML: () ->
        return "<div class='flex-column w-100'>
                    <div class='flex flex-row justify-content-around pb-3'>
                        <div class='flex flex-column w-40'>
                            <label class='w-100 d-inline-block'>Ugradnja u opsegu</label>
                            <div class='flex flex-row w-100 mb-2'>
                                <label class='flex mr-2 mb-0 align-self-center'>Od</label>
                                <input type='date' class='form-control flex w-100 js--filter--from'/>
                            </div>
                            <div class='flex w-100'>
                                <label class='flex mr-2 mb-0 align-self-center'>Do</label>
                                <input type='date' class='form-control flex w-100 js--filter--to'/>
                            </div>
                        </div>                                    
                    
                        <div class='flex flex-row align-items-center mb-2 w-40'>
                        <label class='mr-2 wc-10 mb-0 align-self-center'>Status</label>
                            <select class='form-control js--change js--filter--status'>
                               #{@_applyStatus()}
                            </select>
                        </div>
                    </div>
                    <div class='w-100 flex justify-content-center'>
                        <input type='button' class='btn btn-primary js--filter--reset' value='Restart filter'/>
                    </div>
                </div>"

    _expenseOrderHTML: () ->
        return "<div class='flex-column w-100'>
                    <div class='flex flex-row justify-content-around pb-3'>
                        <div class='flex flex-column w-40'>
                            <div class='flex flex-row w-100'>
                                <label class='flex mr-2 mb-0 align-self-center w-fit-content'>Pretraži</label>
                                <div class='pos-rel w-100 mb-2'>
                                    <input type='text' class='form-control w-100 input-icon-icon-24 js--filter--as'/>
                                    <i class='input-icon-24 search-icon cursor-initial'></i>
                                    <div class='suggestion-container js--filter--suggestions pos-abs hide'></div>
                                </div>        
                            </div>

                            <label class='w-100 d-inline-block'>Pare izručene</label>
                            <div class='flex flex-row w-100 mb-2'>
                                <label class='flex mr-2 mb-0 align-self-center'>Od</label>
                                <input type='date' class='form-control flex w-100 js--filter--from'/>
                            </div>
                            <div class='flex w-100'>
                                <label class='flex mr-2 mb-0 align-self-center'>Do</label>
                                <input type='date' class='form-control flex w-100 js--filter--to'/>
                            </div>
                        </div>                                    
                    
                        <div class='flex flex-column w-40 align-self-end'>                            
                            <div class='flex flex-column w-100'>
                                <label class='w-100 d-inline-block'>Iznos novca</label>
                                <div class='flex flex-row w-100 mb-2'>
                                    <label class='flex mr-2 mb-0 align-self-center'>Od</label>
                                    <input type='number' class='form-control flex w-100 js--filter--sum--from'/>
                                </div>
                                <div class='flex w-100'>
                                    <label class='flex mr-2 mb-0 align-self-center'>Do</label>
                                    <input type='number' class='form-control flex w-100 js--filter--sum--to'/>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    <div class='w-100 flex justify-content-center'>
                        <input type='button' class='btn btn-primary js--filter--reset' value='Restart filter'/>
                    </div>
                </div>"
