class @AutoSuggestion

    @BASE_FILTER = 'base_filter'

    constructor: (@parentPage, @container, @emptyStateContainer, filterType) ->
        @container.html(@_getHTMLByFilterType(filterType))

        @keyupEvent = @_keyupEventHandler.bind(this)
        @container.on 'keyup', @keyupEvent

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

        @changeEvent = @_changeEventHander.bind(this)
        $('.js--change').on 'change', @changeEvent

    destroy: () ->
        @container.off 'keyup', @keyupEvent
        @keyupEvent = null
        
        @container.off 'click', @clickEvent
        @clickEvent = null

        $('.js--change').off 'change', @changeEvent
        @changeEvent = null

        @container = null
        @parentPage = null
        @emptyStateContainer = null

    _keyupEventHandler: (event) ->
        @parentPage.AutoSuggestionKeyUpEventHander(event)

    _changeEventHander: (event) ->
        @parentPage.AutoSuggestionChangeEventHander(event)

    _clickEventHandler: (event) ->
        @parentPage.AutoSuggestionClickEventHander(event)

    _getHTMLByFilterType: (filterType) ->
        switch filterType
            when AutoSuggestion.BASE_FILTER
                return @_baseFilter()       
            else 
                console.log 'ops ops'

    emptyState: () ->
        @emptyStateContainer.html("<div class='col-5 m-auto h-75 pt-5 text-center'>Prazna pretraga :(</div>")

    _baseFilter: () ->
        return @_filterWrapperHTML(@_filterBaseHTML())

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

    _filterBaseHTML: () ->
        return "<div class='flex-column w-100'>
                    <div class='flex flex-row justify-content-around pb-3'>
                        <div class='flex flex-row w-40'>
                            <label class='mr-2 w-25 d-inline-block'>Pretraži</label>
                            <div class='pos-rel w-100'>
                                <input type='text' class='form-control w-100 input-icon-icon-24 js--filter--as'/>
                                <i class='input-icon-24 search-icon cursor-initial'></i>
                                <div class='suggestion-container js--filter--suggestions pos-abs hide'></div>
                            </div>        
                        </div>                                    
                    
                        <div class='flex flex-row w-40'>
                        <label class='mr-2 wc-10'>Status</label>
                            <select class='js--change js--filter--status'>
                                <option value='all' selected>Svi</option>
                                <option value='active'>Zaposlen</option>
                                <option value='deactive'>Otpušten</option>
                            </select>
                        </div>
                    </div>
                    <div class='w-100 flex justify-content-center'>
                        <input type='button' class='btn btn-primary js--filter--reset' value='Restart filter'/>
                    </div>
                </div>"