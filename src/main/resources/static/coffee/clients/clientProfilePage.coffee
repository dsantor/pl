class @ClientProfilePage

    constructor: (clientId) ->
        @container = $('.js--page--container')

        # clientId = @_getClientIdFromURL()
        @clientId = Number(clientId)
        @client = null
        ClientService.get(clientId, null, this, @_loadedClient, @_loadedClientError)

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

    getPageTitle: () ->
        return 'Klijent profil'
        
    destroy: () ->
        @container.html('')

        @container.off 'click', @clickEvent
        @clickEvent = null

    _clickEventHandler: (event) ->
        target = $(event.target)
        if closest(target, '.js--create--bids')
            window.location.hash = 'bids/'+@clientId
            return
        
        if closest(target, '.js--back--button')
            window.location.hash = 'clients'
            return
            
    _getClientIdFromURL: () ->
        hash = window.location.hash
        return hash.substring(hash.indexOf('/'))

    _loadedClient:(response) ->
        @container.html(@_templateHTML(response.data))

    _loadedClientError: () ->
        console.log 'error'

    _templateHTML: (client) ->
        return "<div class='container '>
                <nav class='nav header justify-content-end pt-3'>
                    <span class='nav-link span-a back-button js--back--button'>Nazad</span>
                    <span class='nav-link span-a js--change--color'>Promeni oznaku</span>
                    <span class='nav-link span-a js--create--bids'>Kreiraj porudzbinu</span>
                </nav>
                <div class='col-7 h-75 pt-5 flex'>
                    <div class='container w-50'>
                        <div class='profile-image h-336'>
                        </div>
                    </div>
                    <div class='container w-50'>
                        <table class='table table-borderless'>
                            <tr>
                                <td>Ime</td>
                                <td>#{client.firstName or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td>Prezime</td>
                                <td>#{client.lastName or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td>Ulica</td>
                                <td>#{client.street or '/'}</td>
                            </tr>
                            
                            <tr>
                                <td>Broj stana</td>
                                <td>#{client.buildNumber or '/'}</td>
                            </tr>
                            <tr>
                                <td>Grad</td>
                                <td>#{client.city or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td>Telefon</td>
                                <td>#{client.phoneNumber or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td>Email</td>
                                <td>#{client.email or '/'}</td>
                            </tr>
                            <!-- <tr>
                                <td colspan='2'><input type='button' value='Izmeni' class='btn btn-lg btn-primary btn-block js--edit--profile'/></td>
                            </tr> -->
                                
                        </table>
                    </div>
                </div>
            </div>"