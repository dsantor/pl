// Generated by CoffeeScript 1.12.7
(function() {
  this.UserService = (function() {
    function UserService() {}

    UserService.loadEditProfileTemplate = function(onTheFlyData, callbackContext, callBackFunction, callbackError) {
      var url;
      url = '../templates/editProfile';
      return AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError);
    };

    UserService.getUser = function(userId, onTheFlyData, callbackContext, callBackFunction, callbackError) {
      var url;
      url = '../api/user/' + userId;
      return AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError);
    };

    UserService.getUsers = function(onTheFlyData, callbackContext, callBackFunction, callbackError) {
      var url;
      url = '../api/user/all';
      return AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError);
    };

    UserService.changeUserInfo = function(data, onTheFlyData, callbackContext, callBackFunction, callbackError) {
      var url;
      url = '../api/user/update';
      return AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError);
    };

    UserService.save = function(data, onTheFlyData, callbackContext, callBackFunction, callbackError) {
      var url;
      url = '../api/user/save';
      return AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError);
    };

    UserService.remove = function(userId, onTheFlyData, callbackContext, callBackFunction, callbackError) {
      var url;
      url = '../api/user/remove/' + userId;
      return AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError);
    };

    return UserService;

  })();

}).call(this);
