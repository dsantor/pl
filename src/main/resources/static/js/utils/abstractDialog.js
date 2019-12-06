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
      this.loadingPageHTML();
      return this.container.attr('visibility', true);
    };

    AbstractDialog.prototype.hide = function() {
      this.container.attr('visibility', false);
      this.container.off('click', this.clickEvent);
      return this.clickEvent = null;
    };

    AbstractDialog.prototype.destroy = function() {
      this.hide();
      this.container.html('');
      return this.container = null;
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

    AbstractDialog.prototype._templateHTML = function(innerHtml) {
      var html;
      if (innerHtml == null) {
        innerHtml = '';
      }
      html = "<div style=background-color:white;> <div class='form-group form-inline header'> <div> <img src='https://www.dakiplast.rs/wp-content/uploads/2017/05/logo-small-01-300x75.png' style='max-width: 50%;'> </div> <div> <button class='cbtn btn-light " + ComponentsUtils.NEGATIVE_BUTTON + " " + this.JS_NEGATIVE_BUTTON_VISIBILITY + "'> " + this.JS_NEGATIVE_BUTTON_TEXT + " </button> <button class='cbtn btn-primary mr-15px " + ComponentsUtils.POSITIVE_BUTTON + " " + this.JS_POSITIVE_BUTTON_VISIBILITY + "'> " + this.JS_POSITIVE_BUTTON_TEXT + " </button> </div> </div> </div> " + innerHtml;
      return this.container.html(html);
    };

    AbstractDialog.prototype.customHTML = function() {
      return this._templateHTML(this._customHTML());
    };

    AbstractDialog.prototype._customHTML = function() {
      return '';
    };

    AbstractDialog.prototype.loadingPageHTML = function() {
      return this._templateHTML("<div><span class='loader-icon'></span></div>");
    };

    AbstractDialog.prototype.emptyStateHTML = function() {
      return this._templateHTML(this._emptyStateHTML());
    };

    AbstractDialog.prototype._emptyStateHTML = function() {
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
