class @FloatingMessage

    @success: (message, duration = 3) ->
        FloatingMessage._displayFloatingMessage(message, 'bg-success', duration*1000)   

    @info: (message, duration = 3) ->
        FloatingMessage._displayFloatingMessage(message, 'bg-info', duration*1000)    

    @error: (message, duration = 3) ->
        FloatingMessage._displayFloatingMessage(message, 'bg-danger', duration*1000)    


    @_displayFloatingMessage: (message, type, duration) ->
        container = $('.js--floating--message')
        container.attr('visibility', true)
        container.addClass(type)
        container.html(message)
        
        setTimeout (->
            container.attr('visibility', false)
            container.removeClass(type)
            container.html('')
            return
        ), duration