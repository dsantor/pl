class @ComponentsUtils
    @CSS_INVALID_INPUT = 'alert-danger'
    @POSITIVE_BUTTON = 'js--positive--button'
    @NEGATIVE_BUTTON = 'js--negative--button'

    window.closest = (target, closestTo) ->
        return target.closest(closestTo).length > 0

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