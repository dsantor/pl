	class @CreateWorkerDialog extends AbstractDialog

    constructor: () ->
        super()

    getPageTitle: () ->
        return 'Kreiranje radnika'    


    show: () ->
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

    hide: () ->
        super()

    destroy: () ->
        super()
        @firstName    = null
        @lastName     = null
        @street       = null
        @buildNumber  = null
        @city         = null
        @phoneNumber  = null
        @email        = null

    _customHTML: () ->
        "<div class='col-7 m-auto h-75 pt-5 flex'>
            <div class='container w-50'>
                <div class='form-group'>
                    <label>Email    </label>
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
        phoneValid  = true
        mobileValid = true
        
        firstName    = @firstName.val().trim()
        lastName     = @lastName.val().trim()
        street       = @street.val().trim()
        buildNumber  = @buildNumber.val().trim()
        city         = @city.val().trim()
        phoneNumber  = @phoneNumber.val().trim()
        email        = @email.val().trim()

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

        data = {
            firstName    : firstName
            lastName     : lastName
            street       : street
            buildNumber  : buildNumber
            city         : city
            phoneNumber  : phoneNumber
            email        : email
        }

        WorkerService.save(data, null, this, @_saveWorkerSuccess, @_saveWorkerError)
        @hide()

    _saveWorkerSuccess: (response) ->
        FloatingMessage.success("Kreiran klijent #{response.data.firstName}  #{response.data.lastName}" )
        EventUtils.triggerCreatedNewWorker(response.data)

    _saveWorkerError: (response) ->
        FloatingMessage.error("Korisnik nije uspesno kreiran, pokusajte ponovo.")
