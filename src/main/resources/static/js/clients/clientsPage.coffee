class @ClientsPage

    constructor: (@container) ->
        @_renderEmptyState()

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent
    
    destroy: () ->
        @container.html('')


    _renderEmptyState: () ->
        html = "<div class='col-5 m-auto h-75 pt-5 text-center'>Nema registrovanih klijenata :(</div>
        <div class='pt-3'><input type='button' class='btn btn-primary d-block js--create--client' value='Dodaj klijenta'/>
		</div>"
        @container.html(html)


    
    _clickEventHandler: (event) ->

        target = $(event.target)

        element = target.closest(".js--create--client")
        if element.length > 0
            @createClintPage = new CreateClientPage()
            return