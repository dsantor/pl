// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.UserDetailsDialog = (function(superClass) {
    extend(UserDetailsDialog, superClass);

    function UserDetailsDialog(userId) {
      UserDetailsDialog.__super__.constructor.call(this);
      UserService.getUser(userId, null, this, this.show, null);
      this.activityDialog = new ActivityDialog();
    }

    UserDetailsDialog.prototype.show = function(respone) {
      this.user = respone.data;
      return this.pageHTML();
    };

    UserDetailsDialog.prototype.hide = function() {
      UserDetailsDialog.__super__.hide.call(this);
      if (this.updatedUser) {
        return this.parentPage.userDialogClosed();
      }
    };

    UserDetailsDialog.prototype.destroy = function() {
      UserDetailsDialog.__super__.destroy.call(this);
      this.firstName = null;
      this.lastName = null;
      this.street = null;
      this.buildNumber = null;
      this.city = null;
      this.phoneNumber = null;
      this.email = null;
      this.user = null;
      this.parentPage = null;
      return this.updatedUser = null;
    };

    UserDetailsDialog.prototype._customHTML = function() {
      var html, innerHTML;
      if (this.user) {
        innerHTML = this._toggleBlockUserText();
        html = "<nav class='nav justify-content-end header pt-3'> <span class='nav-link span-a back-button js--back--button'>Nazad</span> <span class='nav-link span-a js--reset--password'>Restartuj šifru</span> <span class='nav-link span-a js--block--user'>" + innerHTML + "</span> <span class='nav-link span-a js--user--activity'>Aktivnosti</span> </nav>";
        html += ComponentsUtils.userDetailsFilledHTML(this.user);
        return html;
      } else {
        return ComponentsUtils.emptyState('Korisnik nije pronadjen :(');
      }
    };

    UserDetailsDialog.prototype.positiveAction = function() {
      return this.hide();
    };

    UserDetailsDialog.prototype._clickEventHandler = function(event) {
      var target;
      target = $(event.target);
      if (closest(target, '.js--back--button')) {
        window.history.back();
        return;
      }
      if (closest(target, '.js--reset--password')) {
        this._resetPassword();
        return;
      }
      if (closest(target, '.js--block--user')) {
        this._toggleBlockUser();
      }
      if (closest(target, '.js--user--activity')) {
        this.activityDialog.show(this.user.id);
      }
    };

    UserDetailsDialog.prototype._resetPassword = function() {
      return UserService.defaultPassword(this.user.id, null, this, this._globalSuccessMessage, this._globalErrorMessage);
    };

    UserDetailsDialog.prototype._globalSuccessMessage = function(response) {
      return FloatingMessage.success(response.message);
    };

    UserDetailsDialog.prototype._globalErrorMessage = function(response) {
      return FloatingMessage.error(response.message);
    };

    UserDetailsDialog.prototype._toggleBlockUserText = function() {
      var text;
      text = 'Aktiviraj';
      if (this.user.active) {
        text = 'Deaktiviraj';
      }
      return text;
    };

    UserDetailsDialog.prototype._toggleBlockUser = function() {
      this.user.active = !this.user.active;
      this.updatedUser = true;
      $(".js--block--user").html(this._toggleBlockUserText());
      return UserService.toggleBlockUser(this.user.id, null, this, this._globalSuccessMessage, this._globalErrorMessage);
    };

    return UserDetailsDialog;

  })(AbstractPage);

}).call(this);
