class @ComponentsUtils
    @CSS_INVALID_INPUT = 'alert-danger'
    @POSITIVE_BUTTON = 'js--positive--button'
    @NEGATIVE_BUTTON = 'js--negative--button'

    
    @TAB_PAGES   = ['#profile', '#users', '#clients', '#bids']
    @OTHER_PAGES = ['#client/']

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

    
    @doorOverviewHTML: (item) ->
        return "<div class='col-7 h-75 pt-5 flex'>
                    <div class='container w-50'>
                        <table class='table table-borderless'>
                            <tr>
                                <td>Vrsta</td>
                                <td>#{item.doorSort}</td>
                            </tr>
                                
                            <tr>
                                <td>Tip</td>
                                <td>#{item.doorType}</td>
                            </tr>
                                
                            <tr>
                                <td>Otvor</td>
                                <td>#{item.doorOpenSide}</td>
                            </tr>
                            
                            <tr>
                                <td>Staklo</td>
                                <td>#{item.doorGlass}</td>
                            </tr>
                            <tr>
                                <td>Sirina</td>
                                 <td>#{item.doorWidth or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td>Visina</td>
                                <td>#{item.doorHeight or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td>Unutrasnja sirina</td>
                                <td>#{item.doorInnerWidth or '/'}</td>
                            </tr>

                            <tr>
                                <td>Kolicina</td>
                                <td>#{item.doorCount}</td>
                            </tr>
                        </table>
                    </div>
                </div>"