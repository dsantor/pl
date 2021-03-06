// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.CreateUserDialog = (function(superClass) {
    extend(CreateUserDialog, superClass);

    function CreateUserDialog() {
      CreateUserDialog.__super__.constructor.call(this);
    }

    CreateUserDialog.prototype.show = function() {
      CreateUserDialog.__super__.show.call(this);
      this.customHTML();
      this.firstName = this.container.find('.js--firstName');
      this.lastName = this.container.find('.js--lastName');
      this.street = this.container.find('.js--street');
      this.buildNumber = this.container.find('.js--buildNumber');
      this.city = this.container.find('.js--city');
      this.phoneNumber = this.container.find('.js--phoneNumber');
      this.email = this.container.find('.js--email');
      return this.password = this.container.find('.js--password');
    };

    CreateUserDialog.prototype.hide = function() {
      return CreateUserDialog.__super__.hide.call(this);
    };

    CreateUserDialog.prototype.getPageTitle = function() {
      return 'Create user';
    };

    CreateUserDialog.prototype.destroy = function() {
      CreateUserDialog.__super__.destroy.call(this);
      this.negativeButton = null;
      this.positiveButton = null;
      this.firstName = null;
      this.lastName = null;
      this.street = null;
      this.buildNumber = null;
      this.city = null;
      this.phoneNumber = null;
      this.email = null;
      return this.password = null;
    };

    CreateUserDialog.prototype._customHTML = function() {
      return "<div class='col-7 m-auto h-75 pt-5 flex'> <div class='container w-50'> <div class='form-group'> <label>Email*</label> <input type='email' class='form-control js--email' placeholder='email'/> </div> <div class='form-group'> <label>Ime</label> <input type='text' class='form-control js--firstName' placeholder='ime'/> </div> <div class='form-group'> <label>Prezime</label> <input type='text' class='form-control js--lastName' placeholder='prezime'/> </div> <div class='form-group'> <label>Sifra</label> <input type='password' class='form-control js--password' disabled='disabled' placeholder='Password1'/> </div> </div> <div class='container w-50'> <div class='form-group'> <label>Ulica</label> <input type='text' class='form-control js--street' placeholder='ulica'/> </div> <div class='form-group'> <label>Broj stana</label> <input type='text' class='form-control js--buildNumber' placeholder='broj kuce/stana'/> </div> <div class='form-group'> <label>Grad</label> <input type='text' class='form-control js--city' placeholder='grad'/> </div> <div class='form-group'> <label>Telefon</label> <input type='tel' class='form-control js--phoneNumber' placeholder='telefon'/> </div> </div> </div>";
    };

    CreateUserDialog.prototype.negativeAction = function() {
      return this.hide();
    };

    CreateUserDialog.prototype.positiveAction = function() {
      var buildNumber, city, data, email, firstName, lastName, password, phoneNumber, street, valid;
      valid = true;
      firstName = this.firstName.val().trim();
      lastName = this.lastName.val().trim();
      street = this.street.val().trim();
      buildNumber = this.buildNumber.val().trim();
      city = this.city.val().trim();
      phoneNumber = this.phoneNumber.val().trim();
      email = this.email.val().trim();
      password = this.password.val().trim();
      if (email !== '') {
        this.email.removeClass(ComponentsUtils.CSS_INVALID_INPUT);
      } else {
        valid = false;
        this.email.addClass(ComponentsUtils.CSS_INVALID_INPUT);
      }
      if (Validation.email(email)) {
        this.email.removeClass(ComponentsUtils.CSS_INVALID_INPUT);
      } else {
        valid = false;
        this.email.addClass(ComponentsUtils.CSS_INVALID_INPUT);
      }
      if (!valid) {
        return;
      }
      data = {
        firstName: firstName,
        lastName: lastName,
        street: street,
        buildNumber: buildNumber,
        city: city,
        phoneNumber: phoneNumber,
        email: email,
        password: ''
      };
      UserService.save(data, null, this, this._saveUserSuccess, this._saveUserError);
      return this.hide();
    };

    CreateUserDialog.prototype._saveUserSuccess = function(response) {
      FloatingMessage.success("Kreiran korisnik " + response.data.email);
      return EventUtils.triggerCreatedNewUser(response.data);
    };

    CreateUserDialog.prototype._saveUserError = function(response) {
      return FloatingMessage.error(response.message);
    };

    CreateUserDialog.prototype._redirectPage = function() {
      return window.location.hash = 'users';
    };

    return CreateUserDialog;

  })(AbstractDialog);

}).call(this);
