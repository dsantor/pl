class @BidsPage

    constructor: (@container) ->
        @container.html(@_html())

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

        @doorBidDialog = new DoorBidDialog()
        @windowBidDialog = new WindowBidDialog()
        @shutterBidDialog = new ShutterBidDialog()
    destroy: () ->


    show: () ->

    getPageTitle: () ->
        return "Porudzbine"
    _html: () ->
        return "<div class='col-7 m-auto w-100 pt-5 flex flex-column'>
                <div class='flex flex-row justify-content-center'>
                    <div class='item-order text-center mb-5'>
                            <div class='js--create--door'>
                                <img class='item-order pointer' src='images/door.png'>
                            </div>
                            <label>Vrata</label>
                        </div>
                        <div class='item-order text-center'>
                            <div class='js--create--threshold'>
                                <img class='item-order pointer' src='images/threshold.png'>
                            </div>
                            <label>Prag</label>
                        </div>
                        <div class='item-order text-center'>
                            <div class='js--create--mosquito--repeller'>
                                <img class='item-order pointer' src='images/mosquitoRepeller.png'>
                            </div>
                            <label>Komarnik</label>
                        </div>
                </div>
                 <div class='flex flex-row justify-content-center'>
                   <div class='item-order text-center mb-5'>
                        <div class='js--create--window'>
                            <img class='item-order pointer' src='images/window.png'>
                        </div>
                        <label>Prozor</label>
                    </div>
                    <div class='item-order text-center'>
                        <div class='js--create--shutter'>
                            <img class='item-order pointer' src='images/shutter.png'>
                        </div>
                        <label>Roletne</label>
                    </div>
              </div>
        </div>"



    _clickEventHandler: (event) ->
        target = $(event.target)

        element = target.closest(".js--create--door")
        if element.length > 0
            @doorBidDialog.show()
            return
        element = target.closest(".js--create--threshold")
        if element.length > 0
            alert("th")
            return
        element = target.closest(".js--create--window")
        if element.length > 0
            @windowBidDialog.show()
            return
        element = target.closest(".js--create--shutter")
        if element.length > 0
            @shutterBidDialog.show()
            return
        element = target.closest(".js--create--mosquito--repeller")
        if element.length > 0
            @shutterBidDialog.show()
            return