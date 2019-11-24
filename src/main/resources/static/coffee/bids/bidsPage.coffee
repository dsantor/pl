class @BidsPage

    constructor: (clientId) ->
        @clientId = clientId
        @bidCurrentId = 1
        @container = $('.js--page--container')
        @_choseBidHTML()
        
        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

        @doorBidDialog             = new DoorBidDialog()
        @thresholdBidDialog        = new ThresholdBidDialog()
        @windowBidDialog = new WindowBidDialog()
        @shutterBidDialog = new ShutterBidDialog()

        @mosquitoRepellerBidDialog = new MosquitoRepellerBidDialog()

        @cartList = {}
        
    destroy: () ->
        
        @doorBidDialog.destroy()
        @doorBidDialog = null
        
        @windowBidDialog.destroy()
        @windowBidDialog = null

        @shutterBidDialog.destroy()
        @shutterBidDialog = null
        
        @thresholdBidDialog.destroy()
        @thresholdBidDialog = null

        @mosquitoRepellerBidDialog.destroy()
        @mosquitoRepellerBidDialog = null

        @container.off 'click', @clickEvent
        @clickEvent= null

        @container.html('')
        @clientId = null


    show: () ->

    getPageTitle: () ->
        return "Porudzbine"
    
    _choseBidHTML: () ->
        bodyHTML = "<div class='container'>
                        <nav class='nav header justify-content-end pt-3'>
                            <span class='nav-link span-a js--bids-overview'>Pregled porudzbine</span>
                            <span class='nav-link span-a #{@_createClientButtonClass()} js--chose--client'>Unesi klijenta</span>
                            <span class='nav-link span-a js--save--bids'>Poruči</span>
                        </nav>
                        <div class='col-7 m-auto w-100 pt-3 flex flex-column'>
                            <div class='flex flex-row justify-content-center'>
                                <div class='item-order text-center mb-5'>
                                        <div class='js--create--door'>
                                            <img class='item-order pointer' draggable=false src='/images/door.png'>
                                        </div>
                                        <label>Vrata</label>
                                    </div>
                                    <div class='item-order text-center'>
                                        <div class='js--create--threshold'>
                                            <img class='item-order pointer' draggable=false src='/images/threshold.png'>
                                        </div>
                                        <label>Prag</label>
                                    </div>
                                    <div class='item-order text-center'>
                                        <div class='js--create--mosquito--repeller'>
                                            <img class='item-order pointer' draggable=false src='/images/mosquitoRepeller.png'>
                                        </div>
                                        <label>Komarnik</label>
                                    </div>
                            </div>
                            <div class='flex flex-row justify-content-center'>
                            <div class='item-order text-center mb-5'>
                                    <div class='js--create--window'>
                                        <img class='item-order pointer' draggable=false src='/images/window.png'>
                                    </div>
                                    <label>Prozor</label>
                                </div>
                                <div class='item-order text-center'>
                                    <div class='js--create--shutter'>
                                        <img class='item-order pointer' draggable=false src='/images/shutter.png'>
                                    </div>
                                    <label>Roletne</label>
                                </div>
                            </div>
                        </div>
                    </div>"
        @container.html(bodyHTML)

    _overviewBidsHTML: (html) ->
        bodyHTML = "<div class='container'>
                    <nav class='nav header justify-content-end pt-3'>
                        <span class='nav-link span-a js--chose--bids'>Odaberi proizvod</span>
                        <span class='nav-link span-a #{@_createClientButtonClass()} js--chose--client'>Unesi klijenta</span>
                        <span class='nav-link span-a js--save--bids'>Poruči</span>
                    </nav>
                    <div class=' pt-3 flex flex-column'>              
                        #{html}
                    </div>"
        @container.html(bodyHTML)

    _clickEventHandler: (event) ->
        target = $(event.target)
        
        if closest(target, ".js--create--door")
            @doorBidDialog.show(this)
            return

        if closest(target, ".js--create--threshold")
            @thresholdBidDialog.show(this)
            return
        
        if closest(target, ".js--create--mosquito--repeller")
            @mosquitoRepellerBidDialog.show(this)
            return

        if closest(target, ".js--create--window")
            @windowBidDialog.show(this)
            return

        if closest(target, ".js--create--shutter")
            @shutterBidDialog.show(this)
            return
       
        if closest(target, '.js--bids-overview')
            # @bidsResultPage.show(this, @cartList)
            @_showBids()
            return
        
        if closest(target, '.js--chose--bids')
            @_choseBidHTML()
            return

        if closest(target, '.js--chose--client')

            return

        if closest(target, '.js--save--bids')
            return

    _getClientIdFromURL: () ->
        hash = window.location.hash
        return hash.substring(hash.indexOf('/'))

    
    bidDialogResult: (data) ->
        if @cartList[data.bidType] is undefined
            @cartList[data.bidType] = []
        data.id = @bidCurrentId++
        @cartList[data.bidType].push(data)


    removeBid: (bidId, bidType) ->
        console.log bidId, bidType


    _showBids: () ->
        keys = Object.keys(@cartList)
        html = ''    
        for key in keys
            if @cartList[key].length > 0
                html += @_renderOverviewBidSection(key)
        
        if html is ''
            html = @_bidsEmptyStateHTML()
        @_overviewBidsHTML(html)
        
    _renderOverviewBidSection: (bidType) ->
        switch bidType
            when DoorBidDialog.BID_TYPE
                return @_renderDoorSectionHTML(@cartList[bidType])
            when ThresholdBidDialog.BID_TYPE
                return @_renderThresholdSectionHTML(@cartList[bidType])
            when MosquitoRepellerBidDialog.BID_TYPE
                return BidSectionsHTML.mosquitoRepellerSectionHTML(@cartList[bidType])
            when WindowBidDialog.BID_TYPE
                return BidSectionsHTML.windowSectionHTML(@cartList[bidType])
            else 
                return ''             



    _renderDoorSectionHTML: (items) ->
        html = "<div class='js--door--section'>"
        html += @_getSectionNameHTML('Vrata')
        html += @_getDoorSectionHTML(items)
        html += "</div>"
        return html

    _getSectionNameHTML: (sectionName) ->
        return "<div class='container'><h4>#{sectionName}</h4></div>
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
                </table>"

    _getDoorSectionHTML: (items) ->
        html = "<table class='table table-striped'>"
        for item in items
            html += @_renderTable(item)
        
        html += '</table>'
        return html

    _renderTable: (item) ->
        dimension = '/'
        if item.doorWidth and item.doorHeight and item.doorInnerWidth
            dimension = item.doorWidth + 'x' + item.doorHeight + 'x' + item.doorInnerWidth
        "<tr class='js--bid--row' data-bid-id=#{item.id} data-bid-type=#{item.bidType}>
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
    
    _createClientButtonClass: () ->
        if @clientId then return 'hide' else return ''


    _renderThresholdSectionHTML: (items) ->
        html = "<div class='js--door--section'>"
        html += "<div class='container'><h4>Prag</h4></div>
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
                </table>"
        html += @_geThresholdSectionHTML(items)
        html += "</div>"
        return html

    _geThresholdSectionHTML: (items) ->
        html = "<table class='table table-striped'>"
        for item in items
            html += @_renderThresholdTable(item)
        html += '</table>'
        return html

    _renderThresholdTable: (item) ->
        return   "<tr class='js--bid--row' data-bid-id=#{item.id} data-bid-type=#{item.bidType}>
                    <td class='table-text w-20'>#{item.sort}</td>
                    <td class='table-text w-20'>#{item.width or '/'}</td>
                    <td class='table-text w-10'>#{item.height or '/'}</td>
                    <td class='table-text w-20'>#{item.innerWidth or '/'}</td>
                    <td class='table-text w-10'>#{item.count}</td>
                    <td class='table-text w-10'>
                        <span class='edit-icon js--show--client' data-bid-id=#{item.id}></span>
                    </td>
                    <td class='table-text w-10'>
                        <span class='remove-icon js--remove--bid' data-bid-id=#{item.id}></span>
                    </td>
            </tr>"

    _bidsEmptyStateHTML: () ->
        return "<div class='col-5 m-auto h-75 pt-5 text-center'>Nema porudžbina u korpi :(</div>"