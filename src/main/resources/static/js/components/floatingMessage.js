// Generated by CoffeeScript 1.12.7
(function() {
  this.FloatingMessage = (function() {
    function FloatingMessage() {}

    FloatingMessage.success = function(message, duration) {
      if (duration == null) {
        duration = 3;
      }
      return FloatingMessage._displayFloatingMessage(message, 'bg-success', duration * 1000);
    };

    FloatingMessage.info = function(message, duration) {
      if (duration == null) {
        duration = 3;
      }
      return FloatingMessage._displayFloatingMessage(message, 'bg-info', duration * 1000);
    };

    FloatingMessage.error = function(message, duration) {
      if (duration == null) {
        duration = 3;
      }
      return FloatingMessage._displayFloatingMessage(message, 'bg-danger', duration * 1000);
    };

    FloatingMessage._displayFloatingMessage = function(message, type, duration) {
      var container;
      container = $('.js--floating--message');
      container.attr('visibility', true);
      container.addClass(type);
      container.html(message);
      return setTimeout((function() {
        container.attr('visibility', false);
        container.removeClass(type);
        container.html('');
      }), duration);
    };

    return FloatingMessage;

  })();

}).call(this);
