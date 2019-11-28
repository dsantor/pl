// Generated by CoffeeScript 1.12.7
(function() {
  this.UserProfile = (function() {
    function UserProfile() {
      this.container = $('.js--page--container');
      this.container.html(this._html());
      this.editProfilePage = new EditProfileDialog();
      this.activityDialog = new ActivityDialog();
      this.firstname = this.container.find(".js--firstname");
      this.lastname = this.container.find(".js--lastname");
      this.phone = this.container.find(".js--phone");
      this.email = this.container.find(".js--email");
      this.street = this.container.find(".js--street");
      this.city = this.container.find(".js--city");
      this.buildNumber = this.container.find(".js--buildNumber");
      this.loggedUser = window.loggedUserInfo;
      this._renderUserInfo(this.loggedUser);
      this.clickEvent = this._clickEventHandler.bind(this);
      this.container.on('click', this.clickEvent);
    }

    UserProfile.prototype.getPageTitle = function() {
      return 'Profile';
    };

    UserProfile.prototype.destroy = function() {
      this.container.off('click', this.clickEvent);
      this.clickEvent = null;
      this.loggedUser = null;
      this.editProfilePage.destroy();
      this.editProfilePage = null;
      return this.container.html('');
    };

    UserProfile.prototype._clickEventHandler = function(event) {
      var target;
      target = $(event.target);
      if (closest(target, '.js--edit--profile')) {
        this.editProfilePage.show(this, this.loggedUser);
        return;
      }
      if (closest(target, '.js--activity')) {
        this.activityDialog.show(this.loggedUser.id);
      }
    };

    UserProfile.prototype._renderUserInfo = function(user) {
      this.loggedUser = user;
      this.firstname.text(user.firstName);
      this.lastname.text(user.lastName);
      this.phone.text(user.phoneNumber);
      this.email.text(user.email);
      this.street.text(user.street);
      this.city.text(user.city);
      return this.buildNumber.text(user.buildNumber);
    };

    UserProfile.prototype.editProfileDialogSuccess = function(user) {
      this.loggedUser.firstName = user.firstName;
      this.loggedUser.lastName = user.lastName;
      this.loggedUser.street = user.street;
      this.loggedUser.buildNumber = user.buildNumber;
      this.loggedUser.city = user.city;
      this.loggedUser.phoneNumber = user.phoneNumber;
      window.loggedUserInfo = this.loggedUser;
      return this._renderUserInfo(this.loggedUser);
    };

    UserProfile.prototype._html = function() {
      return "<nav class='nav justify-content-start header pt-3'> <span class='nav-link span-a js--edit--profile'>Izmeni</span> <span class='nav-link span-a js--activity'>Aktivnosti</span> </nav> <div class='col-7 h-75 pt-5 flex'> <div class='container w-50'> <div class='profile-image'> </div> </div> <div class='container w-50'> <table class='table table-borderless'> <tr> <td>Ime</td> <td class='js--firstname'></td> </tr> <tr> <td>Prezime</td> <td class='js--lastname'></td> </tr> <tr> <td>Ulica</td> <td class='js--street'></td> </tr> <tr> <td>Broj stana</td> <td class='js--buildNumber'></td> </tr> <tr> <td>Grad</td> <td class='js--city'></td> </tr> <tr> <td>Telefon</td> <td class='js--phone'></td> </tr> <tr> <td>Email</td> <td class='js--email'></td> </tr> </table> </div> </div>";
    };

    return UserProfile;

  })();

}).call(this);
