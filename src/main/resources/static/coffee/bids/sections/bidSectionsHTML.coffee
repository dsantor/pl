class @BidSectionsHTML

    @doorSectionHTML: (items) ->
        innerHtml = ""
        for item in items
            dimension = '/'
            if item.doorWidth and item.doorHeight and item.doorInnerWidth
                dimension = item.doorWidth + 'x' + item.doorHeight + 'x' + item.doorInnerWidth
            innerHtml += "<tr class='js--bid--row' data-bid-id=#{item.id} data-bid-type=#{item.bidType}>
                            <td class='table-text w-15'>#{item.doorSort}</td>
                            <td class='table-text w-15'>#{item.doorType}</td>
                            <td class='table-text w-10'>#{item.doorOpenSide}</td>
                            <td class='table-text w-10'>#{item.doorGlass}</td>
                            <td class='table-text w-10'>#{dimension}</td>
                            <td class='table-text w-10'>#{item.doorCount}</td>
                            <td class='table-text w-10'>
                                <span class='edit-icon js--show--client' data-bid-id=#{item.id}></span>
                            </td>
                            <td class='table-text w-10'>
                                <span class='remove-icon js--remove--bid' data-bid-id=#{item.id}></span>
                            </td>
                         </tr>"

        html = "<div class='container'><h4>Vrata</h4></div>
                <table class='table mb-0'>
                    <tr>
                        <th class='table-text w-15'>Vrsta</th>
                        <th class='table-text w-15'>Tip</th>
                        <th class='table-text w-10'>Otvor</th>
                        <th class='table-text w-10'>Staklo</th>
                        <th class='table-text w-10'>Dimenzije</th>
                        <th class='table-text w-10'>Količina</th>
                        <th class='table-text w-10'>Izmeni</th>
                        <th class='table-text w-10'>Obriši</th>
                    </tr>
                </table>
                <table class='table table-striped'>
                    #{innerHtml}
                </table>"
        return html

    @thresholdSectionHTML: (items) ->
        innerHtml = ''
        for item in items
            innerHtml += "<tr class='js--bid--row' data-bid-id=#{item.id} data-bid-type=#{item.bidType}>
                            <td class='table-text w-20'>#{item.sort}</td>
                            <td class='table-text w-20'>#{item.width or '/'}</td>
                            <td class='table-text w-10'>#{item.height or '/'}</td>
                            <td class='table-text w-20'>#{item.innerWidth or '/'}</td>
                            <td class='table-text w-10'>#{item.count}</td>
                            <td class='table-text w-10'>
                                <span class='edit-icon js--edit--bid' data-bid-id=#{item.id}></span>
                            </td>
                            <td class='table-text w-10'>
                                <span class='remove-icon js--remove--bid' data-bid-id=#{item.id}></span>
                            </td>
                         </tr>"

        html = "<div class='container'><h4>Prag</h4></div>
                <table class='table mb-0'>
                    <tr>
                        <th class='table-text w-20'>Vrsta</th>
                        <th class='table-text w-20'>Širina</th>
                        <th class='table-text w-10'>Visina</th>
                        <th class='table-text w-20'>Unutrašnja širina</th>
                        <th class='table-text w-10'>Količina</th>
                        <th class='table-text w-10'>Promeni</th>
                        <th class='table-text w-10'>Obriši</th>
                    </tr>
                </table>
                <table class='table table-striped'>
                    #{innerHtml}
                </table>"
        return html

    @mosquitoRepellerSectionHTML: (items) ->
        innerHtml = ''
        for item in items
            dimension = '/'
            if item.width and item.height and item.innerWidth
                dimension = item.width + 'x' + item.height + 'x' + item.innerWidth
            innerHtml += "<tr class='js--bid--row' data-bid-id=#{item.id} data-bid-type=#{item.bidType}>
                            <td class='table-text w-20'>#{item.sort}</td>
                            <td class='table-text w-20'>#{item.type}</td>
                            <td class='table-text w-20'>#{item.openSide}</td>
                            <td class='table-text w-10'>#{dimension}</td>
                            <td class='table-text w-10'>#{item.count}</td>
                            <td class='table-text w-10'>
                                <span class='edit-icon js--show--client' data-bid-id=#{item.id}></span>
                            </td>
                            <td class='table-text w-10'>
                                <span class='remove-icon js--remove--bid' data-bid-id=#{item.id}></span>
                            </td>
                         </tr>"

        html = "<div class='container'><h4>Komarnik</h4></div>
                <table class='table mb-0'>
                    <tr>
                        <th class='table-text w-20'>Vrsta</th>
                        <th class='table-text w-20'>Tip</th>
                        <th class='table-text w-20'>Otvor</th>
                        <th class='table-text w-10'>Dimenzije</th>
                        <th class='table-text w-10'>Količina</th>
                        <th class='table-text w-10'>Izmeni</th>
                        <th class='table-text w-10'>Obriši</th>
                    </tr>
                </table>
                <table class='table table-striped pt-3'>
                #{innerHtml}
                </table>"
        return html


    @windowSectionHTML: (items) ->
        innerHtml = ''
        for item in items
            dimension = '/'
            if item.width and item.height and item.innerWidth
                dimension = item.width + 'x' + item.height + 'x' + item.innerWidth
            innerHtml += "<tr class='js--bid--row' data-bid-id=#{item.id} data-bid-type=#{item.bidType}>
                            <td class='table-text w-20'>#{item.sort}</td>
                            <td class='table-text w-15'>#{item.openSide}</td>
                            <td class='table-text w-15'>#{item.glass}</td>
                            <td class='table-text w-10'>#{item.tipper}</td>
                            <td class='table-text w-10'>#{dimension}</td>
                            <td class='table-text w-10'>#{item.count}</td>
                            <td class='table-text w-10'>
                                <span class='edit-icon js--show--client' data-bid-id=#{item.id}></span>
                            </td>
                            <td class='table-text w-10'>
                                <span class='remove-icon js--remove--bid' data-bid-id=#{item.id}></span>
                            </td>
                         </tr>"

        html = "<div class='container'><h4>Prozor</h4></div>
                <table class='table mb-0'>
                    <tr>
                        <th class='table-text w-20'>Vrsta</th>
                        <th class='table-text w-15'>Otvor</th>
                        <th class='table-text w-15'>Staklo</th>
                        <th class='table-text w-10'>Kipanje</th>
                        <th class='table-text w-10'>Dimenzije</th>
                        <th class='table-text w-10'>Količina</th>
                        <th class='table-text w-10'>Izmeni</th>
                        <th class='table-text w-10'>Obriši</th>
                    </tr>
                </table>
                <table class='table table-striped'>
                #{innerHtml}
                </table>"
        return html
    
    @shutterSectionHTML: (items) ->
        innerHtml = ''
        for item in items
            dimension = '/'
            if item.width and item.height
                dimension = item.width + 'x' + item.height
            innerHtml += "<tr class='js--bid--row' data-bid-id=#{item.id} data-bid-type=#{item.bidType}>
                            <td class='table-text w-15'>#{item.sort}</td>
                            <td class='table-text w-15'>#{item.box}</td>
                            <td class='table-text w-20'>#{item.boxType or '/'}</td>
                            <td class='table-text w-10'>#{item.openSide}</td>
                            <td class='table-text w-10'>#{dimension}</td>
                            <td class='table-text w-10'>#{item.count}</td>
                            <td class='table-text w-10'>
                                <span class='edit-icon js--show--client' data-bid-id=#{item.id}></span>
                            </td>
                            <td class='table-text w-10'>
                                <span class='remove-icon js--remove--bid' data-bid-id=#{item.id}></span>
                            </td>
                         </tr>"

        html = "<div class='container'><h4>Prozor</h4></div>
                <table class='table mb-0'>
                    <tr>
                        <th class='table-text w-15'>Vrsta</th>
                        <th class='table-text w-15'>Kutija</th>
                        <th class='table-text w-20'>Tip kutije</th>
                        <th class='table-text w-10'>Otvor</th>
                        <th class='table-text w-10'>Dimenzije</th>
                        <th class='table-text w-10'>Količina</th>
                        <th class='table-text w-10'>Izmeni</th>
                        <th class='table-text w-10'>Obriši</th>
                    </tr>
                </table>
                <table class='table table-striped'>
                #{innerHtml}
                </table>"
        return html