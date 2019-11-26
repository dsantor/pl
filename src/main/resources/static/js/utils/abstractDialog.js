// Generated by CoffeeScript 1.12.7
(function() {
  this.AbstractDialog = (function() {
    function AbstractDialog() {
      this.JS_NEGATIVE_BUTTON = '.' + ComponentsUtils.NEGATIVE_BUTTON;
      this.JS_POSITIVE_BUTTON = '.' + ComponentsUtils.POSITIVE_BUTTON;
      this.JS_NEGATIVE_BUTTON_TEXT = "Otkazi";
      this.JS_POSITIVE_BUTTON_TEXT = "Sacuvaj";
      this.JS_NEGATIVE_BUTTON_VISIBILITY = '';
      this.JS_POSITIVE_BUTTON_VISIBILITY = '';
      this.container = $('.js--side--dialog--container');
    }

    AbstractDialog.prototype.show = function() {
      this.clickEvent = this._clickEventHandler.bind(this);
      this.container.on('click', this.clickEvent);
      this.container.html(this._templateHTML());
      return this.container.attr('visibility', true);
    };

    AbstractDialog.prototype.hide = function() {
      this.container.attr('visibility', false);
      this.container.off('click', this.clickEvent);
      return this.clickEvent = null;
    };

    AbstractDialog.prototype.refresh = function() {
      return this.container.html(this._templateHTML());
    };

    AbstractDialog.prototype.destroy = function() {
      return this.container.html('');
    };

    AbstractDialog.prototype.positiveButtonVisibility = function(visible) {
      if (visible == null) {
        visible = true;
      }
      if (visible) {
        return this.JS_POSITIVE_BUTTON_VISIBILITY = '';
      } else {
        return this.JS_POSITIVE_BUTTON_VISIBILITY = 'hide';
      }
    };

    AbstractDialog.prototype.negativeButtonVisibility = function(visible) {
      if (visible == null) {
        visible = true;
      }
      if (visible) {
        return this.JS_NEGATIVE_BUTTON_VISIBILITY = '';
      } else {
        return this.JS_NEGATIVE_BUTTON_VISIBILITY = 'hide';
      }
    };

    AbstractDialog.prototype.positiveButtonText = function(text) {
      return this.JS_POSITIVE_BUTTON_TEXT = text;
    };

    AbstractDialog.prototype.negativeButtonText = function(text) {
      return this.JS_NEGATIVE_BUTTON_TEXT = text;
    };

    AbstractDialog.prototype.positiveAction = function() {
      return this.hide();
    };

    AbstractDialog.prototype.negativeAction = function() {
      return this.hide();
    };

    AbstractDialog.prototype._templateHTML = function() {
      return "<div style=background-color:white;> <div class='form-group form-inline header'> <div> <img src='https://www.dakiplast.rs/wp-content/uploads/2017/05/logo-small-01-300x75.png' style='max-width: 50%;'> </div> <div> <button class='cbtn btn-light " + ComponentsUtils.NEGATIVE_BUTTON + " " + this.JS_NEGATIVE_BUTTON_VISIBILITY + "'> " + this.JS_NEGATIVE_BUTTON_TEXT + " </button> <button class='cbtn btn-primary mr-15px " + ComponentsUtils.POSITIVE_BUTTON + " " + this.JS_POSITIVE_BUTTON_VISIBILITY + "'> " + this.JS_POSITIVE_BUTTON_TEXT + " </button> </div> </div> </div> " + (this._customHTML());
    };

    AbstractDialog.prototype._customHTML = function() {
      return '';
    };

    AbstractDialog.prototype._pageClientEventHandler = function(event) {};

    AbstractDialog.prototype._clickEventHandler = function(event) {
      var element, target;
      target = $(event.target);
      element = target.closest(this.JS_NEGATIVE_BUTTON);
      if (element.length > 0) {
        this.negativeAction();
        return;
      }
      element = target.closest(this.JS_POSITIVE_BUTTON);
      if (element.length > 0) {
        this.positiveAction();
        return;
      }
      return this._pageClientEventHandler(event);
    };

    return AbstractDialog;

  })();

}).call(this);
