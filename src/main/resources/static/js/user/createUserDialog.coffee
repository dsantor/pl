class @CreateUserDialog extends AbstractDialog

    constructor: () ->
        super()
        # @container.html(@_html())

        # @clickEvent = @_clickEventHandler.bind(this)
        # @container.on 'click', @clickEvent

        # # Buttons
        # @negativeButton = @container.find(".#{ComponentsUtils.NEGATIVE_BUTTON}")
        # @positiveButton = @container.find(".#{ComponentsUtils.POSITIVE_BUTTON}")

    show: () ->
        super()
        
        # Inputs
        @firstName   = @container.find('.js--firstName')
        @lastName    = @container.find('.js--lastName')
        @street      = @container.find('.js--street')
        @buildNumber = @container.find('.js--buildNumber')
        @city        = @container.find('.js--city')
        @phoneNumber = @container.find('.js--phoneNumber')
        @email       = @container.find('.js--email')
        @password    = @container.find('.js--password')

    hide: () ->
        super()

    getPageTitle: () ->
        return 'Create user'    

    destroy: () ->
        super()
        
        @negativeButton = null
        @positiveButton = null
        @firstName      = null
        @lastName       = null
        @street         = null
        @buildNumber    = null
        @city           = null
        @phoneNumber    = null
        @email          = null
        @password       = null

    _customHTML: () ->
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
                    <label>Sifra</label>
                    <input type='password' class='form-control js--password' disabled='disabled' placeholder='Password1'/>
                </div>

            </div>
            <div class='container w-50'>
                <div class='form-group'>
                    <label>Ulica</label>
                    <input type='text' class='form-control js--street' placeholder='ulica'/>
                </div>

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
            </div>
    	</div>"

    negativeAction: () ->
        @hide()

    positiveAction: () ->
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
        @hide()

    _saveUserSuccess: (response) ->
        FloatingMessage.success("Kreiran korisnik #{response.data.email}")
        EventUtils.triggerCreatedNewUser(response.data)

    _saveUserError: (response) ->
        FloatingMessage.error(response.message)

    
    _redirectPage: () ->
        window.location.hash = 'users'