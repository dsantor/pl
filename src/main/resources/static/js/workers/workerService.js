// Generated by CoffeeScript 1.12.7
(function() {
  this.WorkerService = (function() {
    function WorkerService() {}

    WorkerService.apiUrl = '../api/workers';

    WorkerService.save = function(data, onTheFlyData, callbackContext, callBackFunction, callbackError) {
      var url;
      url = this.apiUrl + '/save';
      return AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError);
    };

    WorkerService.get = function(workerId, onTheFlyData, callbackContext, callBackFunction, callbackError) {
      var url;
      url = this.apiUrl + '/get/' + workerId;
      return AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError);
    };

    WorkerService.getAll = function(onTheFlyData, callbackContext, callBackFunction, callbackError) {
      var url;
      url = this.apiUrl + '/all';
      return AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError);
    };

    WorkerService.toggleBlockWorker = function(workerId, onTheFlyData, callbackContext, callBackFunction, callbackError) {
      var url;
      url = this.apiUrl + '/toggleBlockUser/' + workerId;
      return AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError);
    };

    WorkerService.update = function(data, onTheFlyData, callbackContext, callBackFunction, callbackError) {
      var url;
      url = this.apiUrl + '/update';
      return AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError);
    };

    return WorkerService;

  })();

}).call(this);
