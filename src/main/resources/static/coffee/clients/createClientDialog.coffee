	class @CreateClientDialog extends AbstractDialog

    constructor: () ->
        super()

    getPageTitle: () ->
        return 'Kreiranje klijenta'    


    show: (@client, @parentPage) ->
        super()
        @customHTML()
        # Inputs
        @firstName    = @container.find('.js--firstName')
        @lastName     = @container.find('.js--lastName')
        @street       = @container.find('.js--street')
        @buildNumber  = @container.find('.js--buildNumber')
        @city         = @container.find('.js--city')
        @phoneNumber  = @container.find('.js--phoneNumber')
        @email        = @container.find('.js--email')
        
        if @client
            @firstName.val(@_prettyPrint(@client.firstName))
            @lastName.val(@_prettyPrint(@client.lastName))
            @street.val(@_prettyPrint(@client.street))
            @buildNumber.val(@_prettyPrint(@client.buildNumber))
            @city.val(@_prettyPrint(@client.city))
            @phoneNumber.val(@_prettyPrint(@client.phoneNumber))
            @email.val(@_prettyPrint(@client.email))

    hide: () ->
        super()

    destroy: () ->

        @firstName    = null
        @lastName     = null
        @street       = null
        @buildNumber  = null
        @city         = null
        @phoneNumber  = null
        @email        = null
        @client       = null
        @parentPage   = null


    _customHTML: () ->
        "<div class='col-7 m-auto h-75 pt-5 flex'>
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
    	</div>"

    negativeAction: () ->
        @hide()

    positiveAction: () ->
        valid       = true
        
        firstName    = @_removeShash(@firstName.val().trim())
        lastName     = @_removeShash(@lastName.val().trim())
        street       = @_removeShash(@street.val().trim())
        buildNumber  = @_removeShash(@buildNumber.val().trim())
        city         = @_removeShash(@city.val().trim())
        phoneNumber  = @_removeShash(@phoneNumber.val().trim())
        email        = @_removeShash(@email.val().trim())

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

        id = null
        if @client
            id = @client.id

        data = {
            id           : id
            firstName    : firstName
            lastName     : lastName
            street       : street
            buildNumber  : buildNumber
            city         : city
            phoneNumber  : phoneNumber
            email        : email
        }

        if @client
            ClientService.update(data, null, this, @_updateClientSuccess, @_updateClientError)
        else
            ClientService.save(data, null, this, @_saveClientSuccess, @_saveClientError)
        @hide()

    _updateClientSuccess: (response) ->
        if @parentPage and @parentPage.updatedClient
            @parentPage.updatedClient(response)

    _updateClientError: (response) ->
        FloatingMessage.error("Izmene nisu uspešno sačuvane, pokušajte ponovo.")

    _saveClientSuccess: (response) ->
        FloatingMessage.success("Kreiran klijent #{response.data.firstName}  #{response.data.lastName}" )
        EventUtils.triggerCreatedNewClient(response.data)

    _saveClientError: (response) ->
        FloatingMessage.error("Klijent nije uspešno kreiran, pokušajte ponovo.")

    _prettyPrint: (value) ->
        return value or '/'

    _removeShash: (value) ->
        if value is '/'
            return ''
        else
            return value
    