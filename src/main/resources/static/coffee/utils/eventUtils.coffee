class @EventUtils

    @NEW_CLIENT_IS_CREATED = 'NEW_CLIENT_IS_CREATED'
    @NEW_USER_IS_CREATED   = 'NEW_USER_IS_CREATED'

    @triggerEvent: (eventName, data) ->
        $(document).trigger(eventName, data)
    

    @bindEventHandler: (eventName, handler) ->
        $(document).on(eventName, handler)
    

    @unbindEventHandler: (eventName, handler) ->
        $(document).off(eventName, handler)


    ### Client ###
    @triggerCreatedNewClient: (client) ->
        @triggerEvent(EventUtils.NEW_CLIENT_IS_CREATED, client)

    @bindCreatedNewClient: (handler) ->
        @bindEventHandler(EventUtils.NEW_CLIENT_IS_CREATED, handler)

    @unbindCreatedNewClient: (handler) ->
        @unbindEventHandler(EventUtils.NEW_CLIENT_IS_CREATED, handler)

    ### User ###
    @triggerCreatedNewUser: (client) ->
        @triggerEvent(EventUtils.NEW_USER_IS_CREATED, client)

    @bindCreatedNewUser: (handler) ->
        @bindEventHandler(EventUtils.NEW_USER_IS_CREATED, handler)

    @unbindCreatedNewUser: (handler) ->
        @unbindEventHandler(EventUtils.NEW_USER_IS_CREATED, handler)