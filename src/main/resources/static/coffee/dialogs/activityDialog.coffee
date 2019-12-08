class @ActivityDialog extends AbstractDialog

    constructor: () ->
        super()
        @negativeButtonVisibility(false)
        @positiveButtonText("Zatvori")
        @loadedActivity = false
    
    show:(userId) ->
        super()
        UserActionLogService.getUserActivityLogForUser(userId, null, this, @_activityLogSuccess, @_activityLogError)

    hide: () ->
        super()

    destory: () ->
        @actionLogs     = null
        @loadedActivity = null
        super()

    _customHTML: () ->
        actionLogs = @_prettyPrint(@actionLogs)
        tableHtml = "<div class='w-95 m-auto'>
                        <table class='table mb-0'>
                            <tr>
                                <th class='table-text w-20'>Akcija nad osobom</th>
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

    _emptyStateHTML: () ->
        return "<div class'container js--page--container'>
                    <div class='col-5 m-auto h-75 pt-5 text-center'>Nema zabeleženih aktivnosti</div>
                </div>"

    _prettyPrint:(actionLogs) ->
        items = []

        for actionLog in actionLogs
            item = {}
            if actionLog.user
                item.person = actionLog.user.firstName + ' ' + actionLog.user.lastName
            
            if actionLog.client
                item.person = actionLog.client.firstName + ' ' + actionLog.client.lastName
            
            item.action = actionLog.type
            item.time = @_getTime(actionLog.time)

            items.push(item)
        
        return items
        
    _getTime: (time) ->
        date = new Date(time)
        year = date.getFullYear()
        month = date.getMonth()
        day  = date.getDate()

        hour = date.getHours()
        minutes = date.getMinutes()
        seconds = date.getSeconds()

        return "#{day}-#{month}-#{year} (#{hour}:#{minutes}:#{seconds})"



    _activityLogSuccess: (data) ->
        @actionLogs = data.data
        
        if @actionLogs.length is 0
            @emptyStateHTML()
            return
        @customHTML()

    _activityLogError: (data) ->
        console.log data.message
        @loadedActivity = false