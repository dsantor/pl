class @BidsResultPage extends AbstractDialog

    constructor: () ->
        super()
        @negativeButtonVisibility(false)
        @positiveButtonText('Zatvori')

        @bidsCounter = {
            'DOOR': 0
            'WINDOW': 0
            'SHUTTER': 0
            'THRESHOLD': 0
            'MOSQUITO_REPELLER': 0
        }
        doorCounter = 0
        windowCounter = 0
        shutterCounter = 0
        thresholdCounter = 0
        posquitoRepellerCounter = 0
        @cartList = {}
        @cartList['DOOR'] = []
        @cartList['WINDOW'] = []
        @cartList['SHUTTER'] = []
        @cartList['THRESHOLD'] = []
        @cartList['MOSQUITO_REPELLER'] = []

    destroy: () ->
        @cartList = null
        @parentPage = null
        super()

    show: (@parentPage, @parentCartList) ->
        @container.html('')

        if @parentCartList['DOOR']
            @bidsCounter['DOOR'] = @parentCartList['DOOR'].length
            # @cartList['DOOR'] = @parentCartList['DOOR']

        if @parentCartList['WINDOW']
            @bidsCounter['WINDOW'] = @parentCartList['WINDOW'].length

        if @parentCartList['SHUTTER']
           @bidsCounter['SHUTTER'] = @parentCartList['SHUTTER'].length

        if @parentCartList['THRESHOLD']
            @bidsCounter['THRESHOLD'] = @parentCartList['THRESHOLD'].length

        if @parentCartList['MOSQUITO_REPELLER']
            @bidsCounter['MOSQUITO_REPELLER'] = @parentCartList['MOSQUITO_REPELLER'].length
        super()

    hide: () ->
        super()

    _customHTML: () ->
    
        doors = @parentCartList['DOOR']
        html = ''
        if doors.length > 0
            html = @_renderDoorSectionHTML(doors)
            
            return html
        else
            return @_emptyStateHTML()

    
    _emptyStateHTML: () ->
        return "<div class='col-5 m-auto h-75 pt-5 text-center'>Nema porudžbina u korpi :(</div>"


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
                    <td class='table-text w-5'>
                        <span class='edit-icon js--show--client' data-bid-id=#{item.id}></span>
                    </td>
                    <td class='table-text w-5'>
                        <span class='remove-icon js--remove--bid' data-bid-id=#{item.id}></span>
                    </td>
            </tr>"

    _renderDoorSectionHTML: (items) ->
        html = ''
        html += @_getSectionNameHTML('Vrata', 'js--door--section')
        html += @_getDoorSectionHTML(items)
        return html

    _getSectionNameHTML: (sectionName, jsSelector) ->
        return "<div class='container #{jsSelector}'><h4>#{sectionName}</h4></div>
                <table class='table mb-0'>
                    <tr>
                        <th class='table-text w-15'>Vrsta</th>
                        <th class='table-text w-15'>Tip</th>
                        <th class='table-text w-10'>Otvor</th>
                        <th class='table-text w-10'>Staklo</th>
                        <th class='table-text w-10'>Dimenzije</th>
                        <th class='table-text w-10'>Količina</th>
                        <th class='table-text w-5'>Izmeni</th>
                        <th class='table-text w-5'>Obriši</th>
                    </tr>
                </table>"

    _getDoorSectionHTML: (items) ->
        html = "<table class='table table-striped'>"
        for item in items
            html += @_renderTable(item)
        
        html += '</table>'
        return html


    _pageClientEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--remove--bid')
            @_removeBid(target)
            return

    _removeBid: (target) ->
        bidId = target.attr('data-bid-id')
        bidRow = $(".js--bid--row[data-bid-id='#{bidId}']")
        bidType = bidRow.attr('data-bid-type')
        @bidsCounter[bidType] -= 1
        if @bidsCounter[bidType] <= 0
            $('.js--door--section').remove()
        @parentPage.removeBid(bidId, bidType)
        bidRow.remove()
