// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.ShowClientDialog = (function(superClass) {
    extend(ShowClientDialog, superClass);

    function ShowClientDialog() {
      ShowClientDialog.__super__.constructor.call(this);
      this.negativeButtonVisibility(false);
      this.positiveButtonText("Zatvori");
    }

    ShowClientDialog.prototype.show = function(clientId) {
      ClientService.getClient(clientId, null, this, this._loadedClient, this._loadedClientError);
      return ShowClientDialog.__super__.show.call(this);
    };

    ShowClientDialog.prototype.hide = function() {
      return ShowClientDialog.__super__.hide.call(this);
    };

    ShowClientDialog.prototype.destroy = function() {
      return ShowClientDialog.__super__.destroy.call(this);
    };

    ShowClientDialog.prototype.positiveAction = function() {
      return this.hide();
    };

    ShowClientDialog.prototype.negativeAction = function() {
      return this.hide();
    };

    ShowClientDialog.prototype.save = function() {
      this._collectDataFromForm();
      return ShowClientDialog.__super__.save.call(this);
    };

    ShowClientDialog.prototype.cancel = function() {
      return ShowClientDialog.__super__.cancel.call(this);
    };

    ShowClientDialog.prototype._loadedClient = function(response) {
      var profileHTML;
      this.client = response.data;
      profileHTML = this._generateClientProfileHTML(this.client);
      return this.container.append(profileHTML);
    };

    ShowClientDialog.prototype._loadedClientError = function(error) {
      return console.log(error);
    };

    ShowClientDialog.prototype._generateClientProfileHTML = function(client) {
      return "<div class='container '> <nav class='nav header justify-content-end pt-3'> <span class='nav-link span-a js--create--client'>Promeni oznaku</span> <span class='nav-link span-a js--create--client'>Kreiraj porudzbinu</span> </nav> <div class='col-7 h-75 pt-5 flex'> <div class='container w-50'> <div class='profile-image h-336'> </div> </div> <div class='container w-50'> <table class='table table-borderless'> <tr> <td>Ime</td> <td>" + (client.firstName || '/') + "</td> </tr> <tr> <td>Prezime</td> <td>" + (client.lastName || '/') + "</td> </tr> <tr> <td>Ulica</td> <td>" + (client.street || '/') + "</td> </tr> <tr> <td>Broj stana</td> <td>" + (client.buildNumber || '/') + "</td> </tr> <tr> <td>Grad</td> <td>" + (client.city || '/') + "</td> </tr> <tr> <td>Telefon</td> <td>" + (client.phoneNumber || '/') + "</td> </tr> <tr> <td>Email</td> <td>" + (client.email || '/') + "</td> </tr> <!-- <tr> <td colspan='2'><input type='button' value='Izmeni' class='btn btn-lg btn-primary btn-block js--edit--profile'/></td> </tr> --> </table> </div> </div> </div>";
    };

    return ShowClientDialog;

  })(this.AbstractDialog);

}).call(this);
