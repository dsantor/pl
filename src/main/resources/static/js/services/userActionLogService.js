// Generated by CoffeeScript 1.12.7
(function() {
  this.UserActionLogService = (function() {
    function UserActionLogService() {}

    UserActionLogService.apiUrl = '/api/userActivityLog';

    UserActionLogService.getUserActivityLogForUser = function(data, onTheFlyData, callbackContext, callBackFunction, callbackError) {
      var url;
      url = this.apiUrl + '/getUserActivityLogForUser/' + data;
      return AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError);
    };

    return UserActionLogService;

  })();

}).call(this);
