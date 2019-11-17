class @CreateClientDialog

    constructor: () ->
        @container = $('.js--side--dialog--container')
       
        
        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent
        

    getPageTitle: () ->
        return 'Create user'    


    show: () ->
        @container.attr('visibility', true)

        @container.html(@_html())
        # Buttons
        @negativeButton = @container.find(".#{ComponentsUtils.NEGATIVE_BUTTON}")
        @positiveButton = @container.find(".#{ComponentsUtils.POSITIVE_BUTTON}")

        # Inputs
        @firstName    = @container.find('.js--firstName')
        @lastName     = @container.find('.js--lastName')
        @street       = @container.find('.js--street')
        @buildNumber  = @container.find('.js--buildNumber')
        @city         = @container.find('.js--city')
        @phoneNumber  = @container.find('.js--phoneNumber')
        @email        = @container.find('.js--email')
        @password     = @container.find('.js--password')
        # @mobileNumber = @container.find('.js--mobileNumber')

    hide: () ->
        @container.attr('visibility', false)

    destroy: () ->
        @container.off 'click', @clickEvent
        @clickEvent = null
        @negativeButton = null
        @positiveButton = null
        @container.html('')

        @firstName    = null
        @lastName     = null
        @street       = null
        @buildNumber  = null
        @city         = null
        @phoneNumber  = null
        @email        = null
        @password     = null
        # @mobileNumber = null

    _html: () ->
        "<div class='col-7 m-auto h-75 pt-5 flex'>
            <div class='container w-50'>

                    <div class='form-group'>
                        <label>Email*</label>
                        <input type='email' class='form-control js--email' placeholder='email'/>
                    </div>

                    <div class='form-group'>
                        <label>Ime</label>
                        <input type='text' class='form-control js--firstName' placeholder='ime'/>
                        </div>
                    <div class='form-group'>
                        <label>Prezime</label>
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
                        <label>Telefon</label>
                        <input type='tel' class='form-control js--phoneNumber' placeholder='telefon'/>
                    </div>

                    <div class='form-group form-inline form-inline-btns-mt'>
                        <button class='btn btn-lg btn-light btn-block w-50 #{ComponentsUtils.NEGATIVE_BUTTON}' value='Izmeni'>Otkazi</button>
                        <button class='btn btn-lg btn-primary btn-block w-50 #{ComponentsUtils.POSITIVE_BUTTON}' value='Izmeni'>Kreiraj</button>
                    </div>
                
            </div>
    	</div>"

#                   <div class='form-group'>
#                         <label>Telefon</label>
#                         <input type='tel' class='form-control js--mobileNumber' placeholder='mobilni'/>
#                     </div>
    
    _clickEventHandler: (event) ->
        target = $(event.target)

        element = target.closest(@negativeButton)
        if element.length != 0
            @hide()
            return

        element = target.closest(@positiveButton)
        if element.length != 0
            @_saveClient()
            return


    
    _saveClient: () ->
        valid       = true
        phoneValid  = true
        mobileValid = true
        
        firstName    = @firstName.val().trim()
        lastName     = @lastName.val().trim()
        street       = @street.val().trim()
        buildNumber  = @buildNumber.val().trim()
        city         = @city.val().trim()
        phoneNumber  = @phoneNumber.val().trim()
        email        = @email.val().trim()
        # mobileNumber = @mobileNumber.val().trim()

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

        # if Validation.phone(mobileNumber)
        #     @mobileNumber.removeClass(ComponentsUtils.CSS_INVALID_INPUT)
        # else
        #     mobileValid = false
        #     @mobileNumber.addClass(ComponentsUtils.CSS_INVALID_INPUT)
        
        # if not phoneValid or not mobileValid
        #     valid = false

        if not valid
            return

        data = {
            firstName    : firstName
            lastName     : lastName
            street       : street
            buildNumber  : buildNumber
            city         : city
            phoneNumber  : phoneNumber
            email        : email
        }

        ClientService.save(data, null, this, @_saveClientSuccess, @_saveClientError)
        @hide()

    _saveClientSuccess: (response) ->
        FloatingMessage.success("Kreiran klijent #{response.data.firstName}  #{response.data.lastName}" )
        EventUtils.triggerCreatedNewClient(response.data)

    _saveClientError: (response) ->
        FloatingMessage.error(response.message)
