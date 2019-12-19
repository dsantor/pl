class @BidSectionsHTML

    @emptyState: () ->
        return "<div class='col-5 m-auto h-75 pt-5 text-center'>Korpa je prazna :(</div>"
        
    @doorSectionHTML: (items) ->
        innerHtml = ""
        for item in items
            dimension = '/'
            if item.width and item.height and item.innerWidth
                dimension = item.width + 'x' + item.height + 'x' + item.innerWidth
            innerHtml += "<div class='flex-table js--bid--row' data-bid-id=#{item.id} data-bid-type=#{item.bidType}>
                            <div class='flex-table-cell w-20'>#{item.sort}</div>
                            <div class='flex-table-cell w-20'>#{item.type}</div>
                            <div class='flex-table-cell w-10'>#{item.openSide}</div>
                            <div class='flex-table-cell w-10'>#{item.glass}</div>
                            <div class='flex-table-cell w-10'>#{dimension}</div>
                            <div class='flex-table-cell w-10'>#{item.quantity}</div>
                            <div class='flex-table-cell w-10'>
                                <span class='edit-icon js--edit--bid' data-bid-id=#{item.id}></span>
                            </div>
                            <div class='flex-table-cell w-10'>
                                <span class='remove-icon js--remove--bid' data-bid-id=#{item.id}></span>
                            </div>
                         </div>"

        html = "<div class='container js--section--door'><h4>Vrata</h4></div>
                <div class='flex-table'>
                    <div class='flex-table-cell w-20'>Vrsta</div>
                    <div class='flex-table-cell w-20'>Tip</div>
                    <div class='flex-table-cell w-10'>Otvor</div>
                    <div class='flex-table-cell w-10'>Staklo</div>
                    <div class='flex-table-cell w-10'>Dimenzije</div>
                    <div class='flex-table-cell w-10'>Količina</div>
                    <div class='flex-table-cell w-10'>Izmeni</div>
                    <div class='flex-table-cell w-10'>Obriši</div>
                </div>
                #{innerHtml}
                </div>"
        return html

    @thresholdSectionHTML: (items) ->
        innerHtml = ''
        for item in items
            innerHtml += "<div class='flex-table js--bid--row' data-bid-id=#{item.id} data-bid-type=#{item.bidType}>
                            <div class='flex-table-cell w-20'>#{item.sort}</div>
                            <div class='flex-table-cell w-20'>#{item.width or '/'}</div>
                            <div class='flex-table-cell w-10'>#{item.height or '/'}</div>
                            <div class='flex-table-cell w-20'>#{item.innerWidth or '/'}</div>
                            <div class='flex-table-cell w-10'>#{item.quantity}</div>
                            <div class='flex-table-cell w-10'>
                                <span class='edit-icon js--edit--bid' data-bid-id=#{item.id}></span>
                            </div>
                            <div class='flex-table-cell w-10'>
                                <span class='remove-icon js--remove--bid' data-bid-id=#{item.id}></span>
                            </div>
                         </div>"

        html = "<div class='container js--section--divreshold'><h4>Prag</h4></div>
                <div class='flex-table'>
                    <div class='flex-table-cell w-20'>Vrsta</div>
                    <div class='flex-table-cell w-20'>Širina</div>
                    <div class='flex-table-cell w-10'>Visina</div>
                    <div class='flex-table-cell w-20'>Unudivašnja širina</div>
                    <div class='flex-table-cell w-10'>Količina</div>
                    <div class='flex-table-cell w-10'>Promeni</div>
                    <div class='flex-table-cell w-10'>Obriši</div>
                </div>
                #{innerHtml}
                </div>"
        return html

    @mosquitoRepellerSectionHTML: (items) ->
        innerHtml = ''
        for item in items
            dimension = '/'
            if item.width and item.height and item.innerWidth
                dimension = item.width + 'x' + item.height + 'x' + item.innerWidth
            innerHtml += "<div class='flex-table js--bid--row' data-bid-id=#{item.id} data-bid-type=#{item.bidType}>
                            <div class='flex-table-cell w-20'>#{item.sort}</div>
                            <div class='flex-table-cell w-20'>#{item.type}</div>
                            <div class='flex-table-cell w-20'>#{item.openSide}</div>
                            <div class='flex-table-cell w-10'>#{dimension}</div>
                            <div class='flex-table-cell w-10'>#{item.quantity}</div>
                            <div class='flex-table-cell w-10'>
                                <span class='edit-icon js--edit--bid' data-bid-id=#{item.id}></span>
                            </div>
                            <div class='flex-table-cell w-10'>
                                <span class='remove-icon js--remove--bid' data-bid-id=#{item.id}></span>
                            </div>
                         </div>"

        html = "<div class='container js--section--mosquito--repeller'><h4>Komarnik</h4></div>
                <div class='flex-table'>
                    <div class='flex-table-cell w-20'>Vrsta</div>
                    <div class='flex-table-cell w-20'>Tip</div>
                    <div class='flex-table-cell w-20'>Otvor</div>
                    <div class='flex-table-cell w-10'>Dimenzije</div>
                    <div class='flex-table-cell w-10'>Količina</div>
                    <div class='flex-table-cell w-10'>Izmeni</div>
                    <div class='flex-table-cell w-10'>Obriši</div>
                </div>
                #{innerHtml}
                </div>"
        return html


    @windowSectionHTML: (items) ->
        innerHtml = ''
        for item in items
            dimension = '/'
            if item.width and item.height and item.innerWidth
                dimension = item.width + 'x' + item.height + 'x' + item.innerWidth
            innerHtml += "<div class='flex-table js--bid--row' data-bid-id=#{item.id} data-bid-type=#{item.bidType}>
                            <div class='flex-table-cell w-20'>#{item.sort}</div>
                            <div class='flex-table-cell w-15'>#{item.openSide}</div>
                            <div class='flex-table-cell w-15'>#{item.glass}</div>
                            <div class='flex-table-cell w-10'>#{item.tipper}</div>
                            <div class='flex-table-cell w-10'>#{dimension}</div>
                            <div class='flex-table-cell w-10'>#{item.quantity}</div>
                            <div class='flex-table-cell w-10'>
                                <span class='edit-icon js--edit--bid' data-bid-id=#{item.id}></span>
                            </div>
                            <div class='flex-table-cell w-10'>
                                <span class='remove-icon js--remove--bid' data-bid-id=#{item.id}></span>
                            </div>
                         </div>"

        html = "<div class='container js--section--window'><h4>Prozor</h4></div>
                <div class='flex-table'>
                    <div class='flex-table-cell w-20'>Vrsta</div>
                    <div class='flex-table-cell w-15'>Otvor</div>
                    <div class='flex-table-cell w-15'>Staklo</div>
                    <div class='flex-table-cell w-10'>Kipanje</div>
                    <div class='flex-table-cell w-10'>Dimenzije</div>
                    <div class='flex-table-cell w-10'>Količina</div>
                    <div class='flex-table-cell w-10'>Izmeni</div>
                    <div class='flex-table-cell w-10'>Obriši</div>
                </div>
                #{innerHtml}
                </div>"
        return html
    
    @shutterSectionHTML: (items) ->
        innerHtml = ''
        for item in items
            dimension = '/'
            if item.width and item.height
                dimension = item.width + 'x' + item.height
            innerHtml += "<div class='flex-table js--bid--row' data-bid-id=#{item.id} data-bid-type=#{item.bidType}>
                            <div class='flex-table-cell w-15'>#{item.sort}</div>
                            <div class='flex-table-cell w-15'>#{item.box}</div>
                            <div class='flex-table-cell w-20'>#{item.boxType or '/'}</div>
                            <div class='flex-table-cell w-10'>#{item.openSide}</div>
                            <div class='flex-table-cell w-10'>#{dimension}</div>
                            <div class='flex-table-cell w-10'>#{item.quantity}</div>
                            <div class='flex-table-cell w-10'>
                                <span class='edit-icon js--edit--bid' data-bid-id=#{item.id}></span>
                            </div>
                            <div class='flex-table-cell w-10'>
                                <span class='remove-icon js--remove--bid' data-bid-id=#{item.id}></span>
                            </div>
                         </div>"

        html = "<div class='container js--section--shutter'><h4>Prozor</h4></div>
                <div class='flex-table'>
                    <div class='flex-table-cell w-15'>Vrsta</div>
                    <div class='flex-table-cell w-15'>Kutija</div>
                    <div class='flex-table-cell w-20'>Tip kutije</div>
                    <div class='flex-table-cell w-10'>Otvor</div>
                    <div class='flex-table-cell w-10'>Dimenzije</div>
                    <div class='flex-table-cell w-10'>Količina</div>
                    <div class='flex-table-cell w-10'>Izmeni</div>
                    <div class='flex-table-cell w-10'>Obriši</div>
                </div>
                #{innerHtml}
                </div>"
        return html