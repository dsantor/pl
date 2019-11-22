class @BidsPage

    constructor: (clientId) ->
        @clientId = clientId
        @container = $('.js--page--container')
        @container.html(@_html())

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

        @doorBidDialog = new DoorBidDialog()
        @windowBidDialog = new WindowBidDialog()
        @shutterBidDialog = new ShutterBidDialog()
        @thresholdBidDialog = new ThresholdBidDialog()
        @mosquitoRepellerBidDialog = new MosquitoRepellerBidDialog()

        @bidsResultPage = new BidsResultPage()
        
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

        @bidsResultPage.destroy()
        @bidsResultPage = null

        @container.off 'click', @clickEvent
        @clickEvent= null

        @container.html('')
        @clientId = null


    show: () ->

    getPageTitle: () ->
        return "Porudzbine"
        
    _html: () ->
        createClientButton = ''
        if @clientId
            createClientButton = 'hide'

        return "
                <div class='container '>
                    <nav class='nav header justify-content-end pt-3'>
                        <span class='nav-link span-a js--change--color'>Pregled porudzbine</span>
                        <span class='nav-link span-a #{createClientButton} js--create--bids'>Unesi klijenta</span>
                    </nav>
                    <div class='col-7 m-auto w-100 pt-3 flex flex-column'>
                        <div class='flex flex-row justify-content-center'>
                            <div class='item-order text-center mb-5'>
                                    <div class='js--create--door'>
                                        <img class='item-order pointer' src='/images/door.png'>
                                    </div>
                                    <label>Vrata</label>
                                </div>
                                <div class='item-order text-center'>
                                    <div class='js--create--threshold'>
                                        <img class='item-order pointer' src='/images/threshold.png'>
                                    </div>
                                    <label>Prag</label>
                                </div>
                                <div class='item-order text-center'>
                                    <div class='js--create--mosquito--repeller'>
                                        <img class='item-order pointer' src='/images/mosquitoRepeller.png'>
                                    </div>
                                    <label>Komarnik</label>
                                </div>
                        </div>
                        <div class='flex flex-row justify-content-center'>
                        <div class='item-order text-center mb-5'>
                                <div class='js--create--window'>
                                    <img class='item-order pointer' src='/images/window.png'>
                                </div>
                                <label>Prozor</label>
                            </div>
                            <div class='item-order text-center'>
                                <div class='js--create--shutter'>
                                    <img class='item-order pointer' src='/images/shutter.png'>
                                </div>
                                <label>Roletne</label>
                            </div>
                        </div>
                    </div>
                </div>"


    _closest: (target, closestTo) ->
        return target.closest(closestTo).length > 0

    _clickEventHandler: (event) ->
        target = $(event.target)
        
        if @_closest(target, ".js--create--door")
            @doorBidDialog.show()
            return

        if @_closest(target, ".js--create--threshold")
            @thresholdBidDialog.show()
            return
        
        if @_closest(target, ".js--create--mosquito--repeller")
            @mosquitoRepellerBidDialog.show()
            return

        if @_closest(target, ".js--create--window")
            @windowBidDialog.show()
            return

        if @_closest(target, ".js--create--shutter")
            @shutterBidDialog.show()
            return

        if @_closest(target, '.js--change--color')
            @bidsResultPage.show()
            return

    _getClientIdFromURL: () ->
        hash = window.location.hash
        return hash.substring(hash.indexOf('/'))