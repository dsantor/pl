class @AjaxRequest

    @GET: (url, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        $.ajax({
            url: url,
            method: 'GET',
            contentType: 'application/json;  charset=utf-8',
            success: (data) ->
                if data.error and callbackError
                    callbackError.call(callbackContext, data)
                if callBackFunction
            	    callBackFunction.call(callbackContext, data)
            error: (data) -> 
                if callbackError
                    callbackError.call(callbackContext, data)
        });

    @POST: (url, data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        $.ajax({
            url: url,
            method: 'POST',
            data: JSON.stringify(data),
            contentType: 'application/json;  charset=utf-8',
            success: (data) ->
                if data.error and callbackError
                    callbackError.call(callbackContext, data)
                    return
                if callBackFunction
            	    callBackFunction.call(callbackContext, data)
            error: () -> 
                if callbackError
                    callbackError.call(callbackContext, data)
        });