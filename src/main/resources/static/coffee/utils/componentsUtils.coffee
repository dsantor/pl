class @ComponentsUtils
    @CSS_INVALID_INPUT = 'alert-danger'
    @POSITIVE_BUTTON = 'js--positive--button'
    @NEGATIVE_BUTTON = 'js--negative--button'

    window.closest = (target, closestTo) ->
        return target.closest(closestTo).length > 0

    window.ajaxCallbackPrintMessage = (response) ->
        console.log response.message
        
    window.globalSuccessMessage = (response) ->
        FloatingMessage.success(response.message)

    window.globalErrorMessage =  (response) ->
        FloatingMessage.error(response.message)

    @userDetailsFilledHTML: (user) ->
        emailHTML = '/'
        if user.email
            emailHTML = "<a href='mailto:#{user.email}'>#{user.email}</a>"

         return "<div class='h-75 pt-5 flex'>
                    <div class='container w-40'>
                        <div class='profile-image h-336'>
                        </div>
                    </div>
                    <div class='container w-60'>
                        <table class='table table-borderless'>
                            <tr>
                                <td class='wc-15'>Ime</td>
                                <td>#{user.firstName or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td class='wc-15'>Prezime</td>
                                 <td>#{user.lastName or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td class='wc-15'>Ulica</td>
                                 <td>#{user.street or '/'}</td>
                            </tr>
                            
                            <tr>
                                <td class='wc-15'>Broj stana</td>
                                <td>#{user.buildNumber or '/'}</td>
                            </tr>
                            <tr>
                                <td class='wc-15'>Grad</td>
                                 <td>#{user.city or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td class='wc-15'>Telefon</td>
                                 <td>#{user.phoneNumber or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td class='wc-15'>Email</td>
                                 <td>#{emailHTML}</td>
                            </tr>
                        </table>
                    </div>
                </div>"

    @emptyState: (message, innerHtml = '') ->
        return "<div class='col-5 m-auto h-75 pt-5 text-center'>#{message}</div>
                <div class='pt-3'>#{innerHtml}</div>"

    @loadingPage: () ->
        return "<div><span class='loader-icon'></span></div>"

    @getTimeFromMillis: (millis) ->
        date = new Date(millis)
        year = date.getFullYear()
        month = date.getMonth() + 1
        if month < 10
            month = @_prependZero(month)
        day  = date.getDate()
        if day < 10
            day = @_prependZero(day)

        hour = date.getHours()
        if hour < 10
            hour = @_prependZero(hour)
        minutes = date.getMinutes()
        if minutes < 10
            minutes = @_prependZero(minutes)
        seconds = date.getSeconds()
        if seconds < 10
            seconds = @_prependZero(seconds)

        return "#{day}-#{month}-#{year} (#{hour}:#{minutes}:#{seconds})"

    @_prependZero: (value) ->
        return '0' + value
    @selectFromAutoSuggestion: (target, input, dataAttribute, array, container) ->
        id = Number(target.attr(dataAttribute))
        for a in array
            if a.id == id
                input.attr(dataAttribute, id)
                input.val(a.firstName + ' ' + a.lastName)
                container.addClass('hide')
                break

    @handleAutoSuggestion: (input, dataAttribute, array, container, includePhoneNumber = false, callbackContect, emptyInputCallbackFunction) ->
        inputValue = input.val()
        input.removeAttr(dataAttribute)
        if inputValue.length < 1
            container.addClass('hide')
            if emptyInputCallbackFunction then emptyInputCallbackFunction.call(callbackContect)
            return

        phoneNumberArray = []
        helpArray = []

        for a in array
            inputValue = inputValue.toLowerCase()
            firstName = a.firstName.toLowerCase()
            lastName = a.lastName.toLowerCase()
            if firstName.toLowerCase().startsWith(inputValue) or lastName.toLowerCase().startsWith(inputValue)
                helpArray.push(a)

            if includePhoneNumber and a.phoneNumber.startsWith(inputValue)
                phoneNumberArray.push(a)

        if helpArray.length == 0 and phoneNumberArray.length == 0
            container.addClass('hide') 
            return

        container.html('')
        if helpArray.length > 0
            html = ''
            for a in helpArray
                html += "<span class='suggestion-item' #{dataAttribute}='#{a.id}'>#{a.firstName} #{a.lastName}</span>"
            container.append(html)
        
        if phoneNumberArray.length > 0
            html = ''
            for a in phoneNumberArray
                html += "<span class='suggestion-item' #{dataAttribute}='#{a.id}'>#{a.phoneNumber}</span>"
            container.append(html)
        container.removeClass('hide')

    @baseFilter: () ->
        return ComponentsUtils.filterWrapperHTML(ComponentsUtils.filterBaseHTML())

    @filterWrapperHTML: (innerHtml) ->
         return "<div class='card-header card bp-4'>
                    <h2 class='mb-0 text-center'>
                        <span  class='span-a btn pointer m-auto js--filters--button' data-toggle='collapse' data-target='#collapseOne'>Filteri</span>
                    </h2>
                    </div>
                        <div id='collapseOne' class='collapse card js--filters--content'>
                            <div class='card-body w-75 m-auto flex'>
                            #{innerHtml}
                            </div>
                        </div>
                    </div>
                </div>"

    @filterBaseHTML: () ->
        return "<div class='flex-column w-100'>
                    <div class='flex flex-row justify-content-around pb-3'>
                        <div class='flex flex-row w-40'>
                            <label class='mr-2 w-25 d-inline-block'>Pretraži</label>
                            <div class='pos-rel w-100'>
                                <input type='text' class='form-control w-100 input-icon-icon-24 js--filter--as'/>
                                <i class='input-icon-24 search-icon cursor-initial'></i>
                                <div class='suggestion-container js--filter--suggestions pos-abs hide'></div>
                            </div>        
                        </div>                                    
                    
                        <div class='flex flex-row w-40'>
                        <label class='mr-2 wc-10'>Status</label>
                            <select class='js--filter--status'>
                                <option value='all' selected >Svi</option>
                                <option value='active'>Zaposlen</option>
                                <option value='deactive'>Otpušten</option>
                            </select>
                        </div>
                    </div>
                    <div class='w-100 flex justify-content-center'>
                        <input type='button' class='btn btn-primary js--filter--reset' value='Restart filter'/>
                    </div>
                </div>"