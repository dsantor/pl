class @CreateUserPage

    constructor: (@container) ->
        @container.html(@_html())

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

        # Buttons
        @negativeButton = @container.find(".#{ComponentsUtils.NEGATIVE_BUTTON}")
        @positiveButton = @container.find(".#{ComponentsUtils.POSITIVE_BUTTON}")


        # Inputs
        @firstName   = @container.find('.js--firstName')
        @lastName    = @container.find('.js--lastName')
        @street      = @container.find('.js--street')
        @buildNumber = @container.find('.js--buildNumber')
        @city        = @container.find('.js--city')
        @phoneNumber = @container.find('.js--phoneNumber')
        @email       = @container.find('.js--email')
        @password    = @container.find('.js--password')

    getPageTitle: () ->
        return 'Create user'    

    destroy: () ->
        @container.off 'click', @clickEvent
        @clickEvent = null

        @negativeButton = null
        @positiveButton = null
        @container.html('')

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

                    <div class='form-group'>
                        <label>Sifra</label>
                        <input type='password' class='form-control js--password' disabled='disabled' placeholder='Password1'/>
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


    
    _clickEventHandler: (event) ->
        target = $(event.target)

        element = target.closest(@negativeButton)
        if element.length != 0
            window.location.hash = 'users'
            return

        element = target.closest(@positiveButton)
        if element.length != 0
            @_saveUser()
            return


    
    _saveUser: () ->
        valid = true

        firstName   = @firstName.val().trim()
        lastName    = @lastName.val().trim()
        street      = @street.val().trim()
        buildNumber = @buildNumber.val().trim()
        city        = @city.val().trim()
        phoneNumber = @phoneNumber.val().trim()
        email       = @email.val().trim()
        password    = @password.val().trim()

        if email isnt ''
            @email.removeClass(ComponentsUtils.CSS_INVALID_INPUT)
        else
            valid = false
            @email.addClass(ComponentsUtils.CSS_INVALID_INPUT)

        if Validation.email(email)
            @email.removeClass(ComponentsUtils.CSS_INVALID_INPUT)
        else
            valid = false
            @email.addClass(ComponentsUtils.CSS_INVALID_INPUT)

        if not valid
            return

        data = {
            firstName   : firstName
            lastName    : lastName
            street      : street
            buildNumber : buildNumber
            city        : city
            phoneNumber : phoneNumber
            email       : email
            password    : password
        }

        UserService.save(data, null, this, @_saveUserSuccess, @_saveUserError)


    _saveUserSuccess: (response) ->
        FloatingMessage.success("Kreiran korisnik #{response.data.email}")
        @_redirectPage()
            
    _saveUserError: (response) ->
        FloatingMessage.error(response.message)

    
    _redirectPage: () ->
        window.location.hash = 'users'