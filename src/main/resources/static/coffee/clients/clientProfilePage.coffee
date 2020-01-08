class @ClientProfilePage extends AbstractPage

    constructor: (clientId) ->
        super()
        @clientId = Number(clientId)
        @client = null
        ClientService.get(clientId, null, this, @_loadedClient, @_loadedClientError)
        @createClientDialog = new CreateClientDialog()

    getPageTitle: () ->
        return 'Klijent profil'
        
    destroy: () ->
        super()
        @createClientDialog.destroy()
        @createClientDialog = null

    _clickEventHandler: (event) ->
        target = $(event.target)
        if closest(target, '.js--create--bids')
            window.location.hash = 'bids/'+@clientId
            return
        
        if closest(target, '.js--back--button')
            MainNavigation.back()
            return
        
        if closest(target, '.js--show--orders')
            window.location.hash = "client/#{@clientId}/orders"
            return

        if closest(target, '.js--edit--profile')
            @createClientDialog.show(@client, this)
            return

    updatedClient: (response) ->
        @_loadedClient(response)

    _loadedClient: (response) ->
        @client = response.data
        @container.html(@_templateHTML(@client))

    _loadedClientError: () ->
        console.log 'error'

    _templateHTML: (client) ->
        return "<div class='container '>
                <nav class='nav header justify-content-end pt-3'>
                    <span class='nav-link span-a back-button js--back--button'>Nazad</span>
                    <span class='nav-link span-a js--edit--profile'>Izmeni</span>
                    <span class='nav-link span-a js--show--orders'>Porudžbine</span>
                    <span class='nav-link span-a js--create--bids'>Kreiraj porudzbinu</span>
                </nav>
                <div class='h-75 pt-5 flex'>
                    <div class='container w-40'>
                        <div class='profile-image h-336'>
                        </div>
                    </div>
                    <div class='container w-60'>
                        <table class='table table-borderless'>
                            <tr>
                                <td class='wc-15'>Ime</td>
                                <td>#{client.firstName or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td class='wc-15'>Prezime</td>
                                <td>#{client.lastName or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td class='wc-15'>Ulica</td>
                                <td>#{client.street or '/'}</td>
                            </tr>
                            
                            <tr>
                                <td class='wc-15'>Broj stana</td>
                                <td>#{client.buildNumber or '/'}</td>
                            </tr>
                            <tr>
                                <td class='wc-15'>Grad</td>
                                <td>#{client.city or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td class='wc-15'>Telefon</td>
                                <td>#{client.phoneNumber or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td class='wc-15'>Email</td>
                                <td>#{client.email or '/'}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>"