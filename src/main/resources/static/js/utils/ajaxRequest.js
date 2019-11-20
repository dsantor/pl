// Generated by CoffeeScript 1.12.7
(function() {
  this.AjaxRequest = (function() {
    function AjaxRequest() {}

    AjaxRequest.GET = function(url, onTheFlyData, callbackContext, callBackFunction, callbackError) {
      return $.ajax({
        url: url,
        method: 'GET',
        contentType: 'application/json;  charset=utf-8',
        success: function(data) {
          if (data.error && callbackError) {
            callbackError.call(callbackContext, data);
          }
          if (callBackFunction) {
            return callBackFunction.call(callbackContext, data);
          }
        },
        error: function(jqXHR, textStatus, errorThrown) {
          if (jqXHR.status === 401 || jqXHR.status === 400) {
            location.reload();
            return;
          }
          if (callbackError) {
            return callbackError.call(callbackContext, data);
          }
        }
      });
    };

    AjaxRequest.POST = function(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError) {
      return $.ajax({
        url: url,
        method: 'POST',
        data: JSON.stringify(data),
        contentType: 'application/json;  charset=utf-8',
        success: function(data) {
          if (data.error && callbackError) {
            callbackError.call(callbackContext, data);
            return;
          }
          if (callBackFunction) {
            return callBackFunction.call(callbackContext, data);
          }
        },
        error: function() {
          if (callbackError) {
            return callbackError.call(callbackContext, data);
          }
        }
      });
    };

    return AjaxRequest;

  })();

}).call(this);
