// Generated by CoffeeScript 1.12.7
(function() {
  this.ClientProfilePage = (function() {
    function ClientProfilePage(clientId) {
      this.container = $('.js--page--container');
      this.clientId = Number(clientId);
      this.client = null;
      ClientService.get(clientId, null, this, this._loadedClient, this._loadedClientError);
      this.clickEvent = this._clickEventHandler.bind(this);
      this.container.on('click', this.clickEvent);
    }

    ClientProfilePage.prototype.getPageTitle = function() {
      return 'Klijent profil';
    };

    ClientProfilePage.prototype.destroy = function() {
      this.container.html('');
      this.container.off('click', this.clickEvent);
      return this.clickEvent = null;
    };

    ClientProfilePage.prototype._clickEventHandler = function(event) {
      var target;
      target = $(event.target);
      if (closest(target, '.js--create--bids')) {
        window.location.hash = 'bids/' + this.clientId;
        return;
      }
      if (closest(target, '.js--back--button')) {
        window.location.hash = 'clients';
      }
    };

    ClientProfilePage.prototype._getClientIdFromURL = function() {
      var hash;
      hash = window.location.hash;
      return hash.substring(hash.indexOf('/'));
    };

    ClientProfilePage.prototype._loadedClient = function(response) {
      return this.container.html(this._templateHTML(response.data));
    };

    ClientProfilePage.prototype._loadedClientError = function() {
      return console.log('error');
    };

    ClientProfilePage.prototype._templateHTML = function(client) {
      return "<div class='container '> <nav class='nav header justify-content-end pt-3'> <span class='nav-link span-a back-button js--back--button'>Nazad</span> <span class='nav-link span-a js--change--color'>Promeni oznaku</span> <span class='nav-link span-a js--create--bids'>Kreiraj porudzbinu</span> </nav> <div class='col-7 h-75 pt-5 flex'> <div class='container w-50'> <div class='profile-image h-336'> </div> </div> <div class='container w-50'> <table class='table table-borderless'> <tr> <td>Ime</td> <td>" + (client.firstName || '/') + "</td> </tr> <tr> <td>Prezime</td> <td>" + (client.lastName || '/') + "</td> </tr> <tr> <td>Ulica</td> <td>" + (client.street || '/') + "</td> </tr> <tr> <td>Broj stana</td> <td>" + (client.buildNumber || '/') + "</td> </tr> <tr> <td>Grad</td> <td>" + (client.city || '/') + "</td> </tr> <tr> <td>Telefon</td> <td>" + (client.phoneNumber || '/') + "</td> </tr> <tr> <td>Email</td> <td>" + (client.email || '/') + "</td> </tr> <!-- <tr> <td colspan='2'><input type='button' value='Izmeni' class='btn btn-lg btn-primary btn-block js--edit--profile'/></td> </tr> --> </table> </div> </div> </div>";
    };

    return ClientProfilePage;

  })();

}).call(this);
