// Generated by CoffeeScript 1.12.7
(function() {
  this.MainNavigation = (function() {
    function MainNavigation() {
      this.currentPage = null;
      this.pageTitle = $('.js--page--title');
      this.navigationBar = $('.js--nav--bar');
      this.container = $('.js--page--container');
      this._restrictPage();
      $(window).on('hashchange', this._hashChangedHandler.bind(this));
      if (window.location.hash === '') {
        this._redirectToHomepage();
      } else {
        this._handleNavigationButtons();
        this._openPage(window.location.hash);
      }
    }

    MainNavigation.prototype._hashChangedHandler = function(event) {
      this._handleNavigationButtons();
      if (this.currentPage) {
        this.currentPage.destroy();
      }
      this._openPage(window.location.hash);
      return document.title = this.currentPage.getPageTitle();
    };

    MainNavigation.prototype._openPage = function(hash) {
      switch (hash) {
        case '#profile':
          this.currentPage = new UserProfile();
          break;
        case '#users':
          this.currentPage = new UserPage();
          break;
        case '#create-user':
          this.currentPage = new CreateUserPage(this.container);
          break;
        case '#clients':
          this.currentPage = new ClientsPage(this.container);
          break;
        case '#bids':
          this.currentPage = new BidsPage();
          break;
        default:
          this._redirectToErrorPage();
      }
    };

    MainNavigation.prototype._restrictPage = function() {
      var onlyAdmin;
      if (!window.isAdmin) {
        onlyAdmin = $('.js--admin--only');
        return onlyAdmin.remove();
      }
    };

    MainNavigation.prototype._handleNavigationButtons = function(element) {
      var tab;
      tab = window.location.hash;
      tab = tab.replace('#', '');
      $('.js--nav--item').removeClass('active');
      return $(".js--nav--item[data-tab=" + tab + "]").addClass('active');
    };

    MainNavigation.prototype._redirectToHomepage = function() {
      return window.location.hash = "#profile";
    };

    MainNavigation.prototype._redirectToErrorPage = function() {
      window.location.hash = '';
      return window.location.pathname = "/error-404";
    };

    return MainNavigation;

  })();

  $(document).ready(function() {
    return new MainNavigation();
  });

}).call(this);
