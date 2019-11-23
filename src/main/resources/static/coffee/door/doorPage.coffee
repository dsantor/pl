class @DoorPage

    constructor: (@item) ->

    destroy: () ->

    _templateHTML: () ->
        return "<div class='col-7 h-75 pt-5 flex'>
                    <div class='container w-50'>
                        <div class='profile-image h-336'>
                        </div>
                    </div>
                    <div class='container w-50'>
                        <table class='table table-borderless'>
                            <tr>
                                <td>Vrsta</td>
                                <td>#{@item.doorSort}</td>
                            </tr>
                                
                            <tr>
                                <td>Tip</td>
                                <td>#{@item.doorType}</td>
                            </tr>
                                
                            <tr>
                                <td>Otvor</td>
                                <td>#{@item.doorOpenSide}</td>
                            </tr>
                            
                            <tr>
                                <td>Staklo</td>
                                <td>#{@item.doorGlass}</td>
                            </tr>
                            <tr>
                                <td>Sirina</td>
                                 <td>#{@item.doorWidth or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td>Visina</td>
                                <td>#{@item.doorHeight or '/'}</td>
                            </tr>
                                
                            <tr>
                                <td>Unutrasnja sirina</td>
                                <td>#{@item.doorInnerWidth or '/'}</td>
                            </tr>

                            <tr>
                                <td>Kolicina</td>
                                <td>#{@item.doorCount}</td>
                            </tr>
                        </table>
                    </div>
                </div>"