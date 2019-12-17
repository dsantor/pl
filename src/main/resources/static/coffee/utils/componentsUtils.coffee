class @ComponentsUtils
    @CSS_INVALID_INPUT = 'alert-danger'
    @POSITIVE_BUTTON = 'js--positive--button'
    @NEGATIVE_BUTTON = 'js--negative--button'

    window.closest = (target, closestTo) ->
        return target.closest(closestTo).length > 0

    window.ajaxCallbackPrintMessage = (response) ->
        console.log response.message
        
    @userDetailsHTML: () ->
        return "<div class='col-7 h-75 pt-5 flex'>
                    <div class='container w-50'>
                        <div class='profile-image h-336'>
                        </div>
                    </div>
                    <div class='container w-50'>
                        <table class='table table-borderless'>
                            <tr>
                                <td>Ime</td>
                                <td class='js--first--name'></td>
                            </tr>
                                
                            <tr>
                                <td>Prezime</td>
                                 <td class='js--last--name'></td>
                            </tr>
                                
                            <tr>
                                <td>Ulica</td>
                                 <td class='js--street'></td>
                            </tr>
                            
                            <tr>
                                <td>Broj stana</td>
                                <td class='js--build--number'></td>
                            </tr>
                            <tr>
                                <td>Grad</td>
                                 <td class='js--city'></td>
                            </tr>
                                
                            <tr>
                                <td>Telefon</td>
                                 <td class='js--phone--number'></td>
                            </tr>
                                
                            <tr>
                                <td>Email</td>
                                 <td class='js--email'></td>
                            </tr>
                        </table>
                    </div>
                </div>"

    @userDetailsFilledHTML: (user) ->
         return "<div class='col-7 h-75 pt-5 flex'>
                    <div class='container w-50'>
                        <div class='profile-image h-336'>
                        </div>
                    </div>
                    <div class='container w-50'>
                        <table class='table table-borderless'>
                            <tr>
                                <td>Ime</td>
                                <td>#{user.firstName or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td>Prezime</td>
                                 <td>#{user.lastName or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td>Ulica</td>
                                 <td>#{user.street or '/'}</td>
                            </tr>
                            
                            <tr>
                                <td>Broj stana</td>
                                <td>#{user.buildNumber or '/'}</td>
                            </tr>
                            <tr>
                                <td>Grad</td>
                                 <td>#{user.city or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td>Telefon</td>
                                 <td>#{user.phoneNumber or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td>Email</td>
                                 <td>#{user.email or '/'}</td>
                            </tr>
                        </table>
                    </div>
                </div>"

    @emptyState: (message, innerHtml = '') ->
        return "<div class='col-5 m-auto h-75 pt-5 text-center'>#{message}</div>
                <div class='pt-3'>#{innerHtml}</div>"

    @loadingPage: () ->
        return "<div class='js--loading--page'><span class='loader-icon'></span></div>"

    @getTimeFromMillis: (millis) ->
        date = new Date(millis)
        year = date.getFullYear()
        month = date.getMonth()
        day  = date.getDate()

        hour = date.getHours()
        minutes = date.getMinutes()
        seconds = date.getSeconds()

        return "#{day}-#{month}-#{year} (#{hour}:#{minutes}:#{seconds})"

    
    @selectFromAutoSuggestion: (target, array, dataAttribute, input, container) ->
        id = Number(target.attr('data-user-id'))
        for a in array
            if a.id == id
                input.attr('data-user-id', id)
                input.val(a.firstName + ' ' + a.lastName)
                container.addClass('hide')
                break

    @handleAutoSuggestion: (input, dataAttribute, array, container) ->
        inputValue = input.val()
        input.removeAttr(dataAttribute)
        if inputValue.length < 1
            container.addClass('hide')
            return

        helpArray = []
        for a in array
            inputValue = inputValue.toLowerCase()
            firstName = a.firstName.toLowerCase()
            lastName = a.lastName.toLowerCase()
            if firstName.startsWith(inputValue) or lastName.startsWith(inputValue)
                helpArray.push(a)
        if helpArray.length > 0
            html = ''
            for a in helpArray
                html += "<span class='suggestion-item' data-user-id='#{a.id}'>#{a.firstName} #{a.lastName}</span>"
            container.html(html)
            container.removeClass('hide')
        else 
            container.addClass('hide')