// Generated by CoffeeScript 1.12.7
(function() {
  this.AbstractPage = (function() {
    function AbstractPage() {
      this.container = $('.js--page--container');
      this.clickEvent = this._clickEventHandler.bind(this);
      this.container.on('click', this.clickEvent);
    }

    AbstractPage.prototype.destroy = function() {
      this.container.off('click', this.clickEvent);
      this.clickEvent = null;
      return this.container = null;
    };

    AbstractPage.prototype.getPageTitle = function() {
      return 'Daki plast';
    };

    AbstractPage.prototype.pageHTML = function(data) {
      return this.container.html(this._customHTML(data));
    };

    AbstractPage.prototype._emptyState = function() {
      return '';
    };

    AbstractPage.prototype.emptyState = function() {
      return this.container.html(this._emptyState());
    };

    AbstractPage.prototype._customHTML = function(data) {
      return '';
    };

    AbstractPage.prototype._loadingPage = function() {
      return this.container.html(ComponentsUtils.loadingPage());
    };

    AbstractPage.prototype._clickEventHandler = function(event) {};

    return AbstractPage;

  })();

}).call(this);
