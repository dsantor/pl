class @EditProfileDialog extends AbstractDialog

    constructor: () ->
        super()


    
    show: (@parentController, user) ->
        super()
        @customHTML()

        # Buttons
        @negativeButton = @container.find(".#{ComponentsUtils.NEGATIVE_BUTTON}")
        @positiveButton = @container.find(".#{ComponentsUtils.POSITIVE_BUTTON}")

        @firstName = @container.find('.js--firstName')
        @lastName = @container.find('.js--lastName')
        @street = @container.find('.js--street')
        @buildNumber = @container.find('.js--buildNumber')
        @city = @container.find('.js--city')
        @phoneNumber = @container.find('.js--phoneNumber')
        @email = @container.find('.js--email')
        @password = @container.find('.js--password')
        @password2 = @container.find('.js--password--2')

                
        @firstName.val(user.firstName)
        @lastName.val(user.lastName)
        @street.val(user.street)
        @buildNumber.val(user.buildNumber)
        @city.val(user.city)
        @phoneNumber.val(user.phoneNumber)
        @email.val(user.email)


    negativeAction: () ->
        super()
    
    positiveAction: () ->

        valid = true

        firstName   = @firstName.val().trim()
        lastName    = @lastName.val().trim()
        street      = @street.val().trim()
        buildNumber = @buildNumber.val().trim()
        city        = @city.val().trim()
        phoneNumber = @phoneNumber.val().trim()
        password    = @password.val().trim()
        password2   = @password2.val().trim()

        if firstName isnt ''
            @firstName.removeClass(ComponentsUtils.CSS_INVALID_INPUT)
        else
            valid = false
            @firstName.addClass(ComponentsUtils.CSS_INVALID_INPUT)

        if lastName isnt ''
            @lastName.removeClass(ComponentsUtils.CSS_INVALID_INPUT)
        else
            valid = false
            @lastName.addClass(ComponentsUtils.CSS_INVALID_INPUT)

        if Validation.phone(phoneNumber)
            @phoneNumber.removeClass(ComponentsUtils.CSS_INVALID_INPUT)
        else
            valid = false
            @phoneNumber.addClass(ComponentsUtils.CSS_INVALID_INPUT)

        passwordValid = true
        if password isnt password2
            passwordValid = false
        
        if passwordValid and password isnt ''
            passwordValid = Validation.password(password)
        
        if passwordValid
            @password.removeClass(ComponentsUtils.CSS_INVALID_INPUT)
            @password2.removeClass(ComponentsUtils.CSS_INVALID_INPUT)
        else
            valid = false
            @password.addClass(ComponentsUtils.CSS_INVALID_INPUT)
            @password2.addClass(ComponentsUtils.CSS_INVALID_INPUT)


        if not valid
            return

        data = {
            firstName   : firstName
            lastName    : lastName
            street      : street
            buildNumber : buildNumber
            city        : city
            phoneNumber : phoneNumber
            password    : password
        }

        if @parentController and @parentController.editProfileDialogSuccess
            @parentController.editProfileDialogSuccess(data)
        UserService.changeUserInfo(data, null, this, @_saveSuccess, @_saveError)
        @hide()


    destroy: () ->
        super()
        @parentController = null

    _customHTML: () ->
        "<div class='col-7 m-auto h-75 pt-5 flex'>
            <div class='container w-50'>
        
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

                <div class='form-group'>
                    <label>Sifra</label>
                    <input type='password' class='form-control js--password' placeholder='********'/>
                </div>

                <div class='form-group'>
                    <label>Potvrdi sifru</label>
                    <input type='password' class='form-control js--password--2' placeholder='********'/>
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
                
                <div class='form-group'>
                    <label>Email*</label>
                    <input type='email' class='form-control js--email' disabled='disabled' placeholder='email'/>
                </div>
            </div>
    	</div>"

    _saveSuccess: (data) ->
        FloatingMessage.success(data.message)

    _saveError: (data) ->
        FloatingMessage.error(data.message)