class @ActivityDialog extends AbstractDialog

    constructor: () ->
        super()
        @negativeButtonVisibility(false)
        @positiveButtonText("Zatvori")
        @loadedActivity = false
    
    show:(userId) ->
        super()
        if not @loadedActivity
            UserActionLogService.getUserActivityLogForUser(userId, null, this, @s, @e)

    hide: () ->
        super()

    destory: () ->
        @actionLogs     = null
        @loadedActivity = null
        super()

    _customHTML: () ->
        if not @loadedActivity
            return "<div>
                        <span class='loader-icon'></span>
                    </div>"

        if @actionLogs.length is 0
            return @_getEmptyState()

        actionLogs = @_prettyPrint(@actionLogs)
        tableHtml = "<div>
                        <table class='table mb-0'>
                            <tr>
                                <th class='table-text w-20'>Osoba</th>
                                <th class='table-text w-20'>Akcija</th>
                                <th class='table-text w-20'>Vreme</th>
                            </tr>
                        </table>
                        <table class='table table-striped'>"
        rowHtml = ""
        for al in actionLogs
            rowHtml = "<tr>
                        <td class='table-text w-20'>#{al.person}</td>
                        <td class='table-text w-20'>#{al.action}</td>
                        <td class='table-text w-20'>#{al.time}</td>
                    </tr>"
        
        tableHtml += rowHtml
        tableHtml += "</table></div>"
        
        return tableHtml

    _getEmptyState: () ->
        return "<div class'container js--page--container'>
                    <div class='col-5 m-auto h-75 pt-5 text-center'>Nema zabeleženih aktivnosti</div>
                </div>"

    _prettyPrint:(actionLogs) ->
        item = {}
        items = []

        for actionLog in actionLogs
            if actionLog.user
                item.person = actionLog.user.firstName + ' ' + actionLog.user.lastName
            
            if actionLog.client
                item.person = actionLog.client.firstName + ' ' + actionLog.client.lastName
            
            item.action = @_getTypeOfAction(actionLog.type)
            item.time = @_getTime(actionLog.time)

            items.push(item)
        
        return items

    _getTypeOfAction: (type) ->
        action = ''
        switch type
            when 'CREATED_USER'
                action = 'Kreiran korisnik'
                break
            when 'CREATED_CLIENT'
                action = 'Kreiran klijent'
                break
            when 'CREATED_BID'
                action = 'Kreirana porudzbina'
                break
            when 'RESET_PASSWORD'
                action = 'Restartovana sifra'
            else 
                action = '/'
        
        return action
        
    _getTime: (time) ->
        date = new Date(time)
        year = date.getFullYear()
        month = date.getMonth()
        day  = date.getDate()

        return day + '-' + month + '-' + year



    s: (data) ->
        @actionLogs = data.data
        @loadedActivity = true
        @refresh()

    e: (data) ->
        console.log data