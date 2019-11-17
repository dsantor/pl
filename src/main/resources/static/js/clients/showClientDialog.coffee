class @ShowClientDialog extends @AbstractDialog

    constructor: () ->
        super()

    show: (clientId) ->
        ClientService.getClient(clientId, null, this, @_loadedClient, @_loadedClientError)
        super()
        
    hide: () ->
        super()
        
    destroy: () ->
        super()

    save: () ->
        @_collectDataFromForm()
        super()

    cancel: () ->
        super()

    _loadedClient: (response) ->
        @client = response.data
        profileHTML = @_generateClientProfileHTML(@client)
        @container.html(profileHTML)
        

    _loadedClientError: (error) ->
        console.log error


    _generateClientProfileHTML: (client) ->
    
        return "<div class='col-7 h-75 pt-5 flex'>
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
                </div>"