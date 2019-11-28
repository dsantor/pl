class @BidsPage

    constructor: (clientId) ->
        @clientId = clientId
        @bidCurrentId = 1
        @container = $('.js--page--container')
        @choseBidActive = true
        @allowedSaveBidsButton = false
        @_renderChoseBidHTML()
        
        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

        @doorBidDialog             = new DoorBidDialog()
        @thresholdBidDialog        = new ThresholdBidDialog()
        @windowBidDialog           = new WindowBidDialog()
        @shutterBidDialog          = new ShutterBidDialog()
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

    getPageTitle: () ->
        return "Porudzbine"
    
    _renderChoseBidHTML: () ->
        @choseBidActive = true
        bodyHTML = "<div class='container'>
                        #{@_getNavHTML()}
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

    _getNavHTML: () ->
        choseBidCss = ''
        overviewCss = 'hide'
        if @choseBidActive
            choseBidCss = 'hide'
            overviewCss = ''
        saveBidsCss = 'disabled'
        if @allowedSaveBidsButton
            saveBidsCss = ''
            
        return "<nav class='nav header justify-content-end pt-3'>
                    <span class='nav-link span-a js--chose--bids #{choseBidCss}'>Odaberi proizvod</span>
                    <span class='nav-link span-a js--bids-overview #{overviewCss}'>Pregled porudzbine</span>
                    <span class='nav-link span-a #{@_createClientButtonClass()} js--chose--client'>Unesi klijenta</span>
                    <span class='nav-link span-a #{saveBidsCss} js--save--bids'>Poruči</span>
                </nav>"

    _renderOverviewHTML: (innerHTML) ->
        navHTML = @_getNavHTML()
        bodyHTML = "<div class='container'>
                        #{navHTML}
                        <div class=' pt-3 flex flex-column'>              
                            #{innerHTML}
                        </div>
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
            @_showBids()
            return
        
        if closest(target, '.js--chose--bids')
            @_renderChoseBidHTML()
            return

        if closest(target, '.js--chose--client')

            return

        if closest(target, '.js--save--bids')
            return

        if closest(target, '.js--remove--bid')
            @_removeBid(target)
            return

        if closest(target, '.js--edit--bid')
            @_editBid(target)
            return

    _editBid: (element) ->
        bidId = Number(element.attr('data-bid-id'))
        bidRow = $(".js--bid--row[data-bid-id='#{bidId}']")
        bidType = bidRow.attr('data-bid-type')
        data = null
        for item in @cartList[bidType]
            if item.id is bidId
                data = item
                break
        @_openEditDialog(bidType, data)
    
    _openEditDialog: (bidType, data) ->
        switch bidType
            when DoorBidDialog.BID_TYPE
                @doorBidDialog.show(this, data)
                break

            when ThresholdBidDialog.BID_TYPE
                @thresholdBidDialog.show(this, data)
                break

            when MosquitoRepellerBidDialog.BID_TYPE
                @mosquitoBidDialog.show(this, data)
                break

            when WindowBidDialog.BID_TYPE
                @windowBidDialog.show(this, data)
                break

            when ShutterBidDialog.BID_TYPE
                @shutterBidDialog.show(this, data)
                break

            else 
                console.log 'Dialog is not supported'       
        

    _removeBid: (target) ->
        bidId = Number(target.attr('data-bid-id'))
        bidRow = $(".js--bid--row[data-bid-id='#{bidId}']")
        bidType = bidRow.attr('data-bid-type')
        bidRow.remove()
        
        for bid, index in @cartList[bidType]
            if bid.id is bidId
                @cartList[bidType].splice(index, 1)
                break
        
        @_updateResultSections()

    _updateResultSections: () ->
        keys = Object.keys(@cartList)
        for key in keys
            if @cartList[key].length is 0
                keyLowecase = key.toLowerCase()
                sectionName = ".js--section--#{keyLowecase}"
                $(sectionName).remove()
                delete @cartList[key]

        keys = Object.keys(@cartList)
        if keys.length is 0
            @allowedSaveBidsButton = false
            @_renderOverviewHTML(BidSectionsHTML.emptyState())

    _getClientIdFromURL: () ->
        hash = window.location.hash
        return hash.substring(hash.indexOf('/'))

    
    bidDialogResult: (data) ->
        @allowedSaveBidsButton = true
        $('.js--save--bids').removeClass('disabled')
        if @cartList[data.bidType] is undefined
            @cartList[data.bidType] = []

        if data.id is null
            @_addItemToCartList(data)
        else
            @_updateItemFromCartList(data)

    _addItemToCartList: (data) ->
        data.id = @bidCurrentId++
        @cartList[data.bidType].push(data)

    _updateItemFromCartList: (data) ->
        for item, index in @cartList[data.bidType]
            if item.id is data.id
                @cartList[data.bidType][index] = data
                break
        @_showBids()

    _showBids: () ->
        keys = Object.keys(@cartList)

        @choseBidActive = false
        if keys.length is 0
            @allowedSaveBidsButton = false
            @_renderOverviewHTML(BidSectionsHTML.emptyState())
            @save
            return

        html = ''    
        for key in keys
            if @cartList[key].length > 0
                html += @_renderOverviewBidSection(key)
        
        @_renderOverviewHTML(html)
        
    _renderOverviewBidSection: (bidType) ->
        switch bidType
            when DoorBidDialog.BID_TYPE
                return BidSectionsHTML.doorSectionHTML(@cartList[bidType])

            when ThresholdBidDialog.BID_TYPE
                return BidSectionsHTML.thresholdSectionHTML(@cartList[bidType])

            when MosquitoRepellerBidDialog.BID_TYPE
                return BidSectionsHTML.mosquitoRepellerSectionHTML(@cartList[bidType])

            when WindowBidDialog.BID_TYPE
                return BidSectionsHTML.windowSectionHTML(@cartList[bidType])
                
            when ShutterBidDialog.BID_TYPE
                return BidSectionsHTML.shutterSectionHTML(@cartList[bidType])
            else 
                return ''             

    _createClientButtonClass: () ->
        if @clientId then return 'disabled' else return ''
