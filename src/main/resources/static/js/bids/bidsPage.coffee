class @BidsPage

    constructor: (@container) ->
        @container.html(@_html())

    destroy: () ->


    show: () ->

    getPageTitle: () ->
        return "Porudzbine"
    _html: () ->
        return "<div class='col-7 m-auto h-75 w-100 pt-5 flex justify-content'>
                <div class=''>
                    <div class='item-order text-center mb-5'>
                            <div>
                                <img class='item-order pointer' src='images/door.png'>
                            </div>
                            <label>Vrata</label>
                        </div>
                        <div class='item-order text-center'>
                            <div>
                                <img class='item-order pointer' src='images/threshold.png'>
                            </div>
                            <label>Prag</label>
                        </div>
                </div>
                 <div class=''>
                   <div class='item-order text-center mb-5'>
                        <div>
                            <img class='item-order pointer' src='images/window.png'>
                        </div>
                        <label>Prozor</label>
                    </div>
                    <div class='item-order text-center'>
                        <div>
                            <img class='item-order pointer' src='images/shutter.png'>
                        </div>
                        <label>Roletne</label>
                    </div>
              </div>
        </div>"