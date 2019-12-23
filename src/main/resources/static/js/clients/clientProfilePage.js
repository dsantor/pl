// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.ClientProfilePage = (function(superClass) {
    extend(ClientProfilePage, superClass);

    function ClientProfilePage(clientId) {
      ClientProfilePage.__super__.constructor.call(this);
      this.clientId = Number(clientId);
      this.client = null;
      ClientService.get(clientId, null, this, this._loadedClient, this._loadedClientError);
    }

    ClientProfilePage.prototype.getPageTitle = function() {
      return 'Klijent profil';
    };

    ClientProfilePage.prototype.destroy = function() {
      return ClientProfilePage.__super__.destroy.call(this);
    };

    ClientProfilePage.prototype._clickEventHandler = function(event) {
      var target;
      target = $(event.target);
      if (closest(target, '.js--create--bids')) {
        window.location.hash = 'bids/' + this.clientId;
        return;
      }
      if (closest(target, '.js--back--button')) {
        MainNavigation.back();
        return;
      }
      if (closest(target, '.js--show--orders')) {
        window.location.hash = "client/" + this.clientId + "/orders";
      }
    };

    ClientProfilePage.prototype._loadedClient = function(response) {
      return this.container.html(this._templateHTML(response.data));
    };

    ClientProfilePage.prototype._loadedClientError = function() {
      return console.log('error');
    };

    ClientProfilePage.prototype._templateHTML = function(client) {
      return "<div class='container '> <nav class='nav header justify-content-end pt-3'> <span class='nav-link span-a back-button js--back--button'>Nazad</span> <span class='nav-link span-a js--show--orders'>Porudžbine</span> <span class='nav-link span-a js--create--bids'>Kreiraj porudzbinu</span> </nav> <div class='col-7 h-75 pt-5 flex'> <div class='container w-50'> <div class='profile-image h-336'> </div> </div> <div class='container w-50'> <table class='table table-borderless'> <tr> <td>Ime</td> <td>" + (client.firstName || '/') + "</td> </tr> <tr> <td>Prezime</td> <td>" + (client.lastName || '/') + "</td> </tr> <tr> <td>Ulica</td> <td>" + (client.street || '/') + "</td> </tr> <tr> <td>Broj stana</td> <td>" + (client.buildNumber || '/') + "</td> </tr> <tr> <td>Grad</td> <td>" + (client.city || '/') + "</td> </tr> <tr> <td>Telefon</td> <td>" + (client.phoneNumber || '/') + "</td> </tr> <tr> <td>Email</td> <td>" + (client.email || '/') + "</td> </tr> <!-- <tr> <td colspan='2'><input type='button' value='Izmeni' class='btn btn-lg btn-primary btn-block js--edit--profile'/></td> </tr> --> </table> </div> </div> </div>";
    };

    return ClientProfilePage;

  })(AbstractPage);

}).call(this);
