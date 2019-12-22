// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.ClientsPage = (function(superClass) {
    extend(ClientsPage, superClass);

    function ClientsPage() {
      var filterStatus;
      ClientsPage.__super__.constructor.call(this);
      this.pageHTML();
      ClientService.getAll(null, this, this._renderClients, this._renderClientsError);
      this.filterContainer = this.container.find('.js--filter--container--wrapper');
      this.clientsContainer = this.container.find('.js--clients--container');
      filterStatus = [
        {
          key: 'all',
          value: 'Svi'
        }, {
          key: 'paid',
          value: 'Plaćeno'
        }, {
          key: 'unpaid',
          value: 'Neplaćeno'
        }
      ];
      this.autoSuggestion = new AutoSuggestion(this, this.filterContainer, AutoSuggestion.BASE_FILTER, filterStatus);
      this.filterAsInput = this.container.find('.js--filter--as');
      this.suggestionsContainer = this.container.find('.js--filter--suggestions');
      this.filterStatus = this.container.find('.js--filter--status');
      this.createdNewClient = this._createdNewClient.bind(this);
      EventUtils.bindCreatedNewClient(this.createdNewClient);
      this.createClientDialog = new CreateClientDialog();
      this.showClientDialog = new ShowClientDialog();
      this.clients = [];
    }

    ClientsPage.prototype.destroy = function() {
      EventUtils.unbindCreatedNewClient(this.createdNewClient);
      this.createdNewClient = null;
      this.createClientDialog.destroy();
      this.createClientDialog = null;
      this.showClientDialog.destroy();
      this.showClientDialog = null;
      this.clients = null;
      return this.container.html('');
    };

    ClientsPage.prototype.getPageTitle = function() {
      return "Klijenti";
    };

    ClientsPage.prototype._renderClients = function(response) {
      this.clients = response.data;
      if (this.clients && this.clients.length > 0) {
        return this._renderClientsHTML(this.clients);
      } else {
        return this._renderEmptyState();
      }
    };

    ClientsPage.prototype._renderClientsError = function(response) {
      return console.log(response);
    };

    ClientsPage.prototype._renderEmptyState = function() {
      var html;
      html = "<div class='col-5 m-auto h-75 pt-5 text-center'>Nema registrovanih klijenata :(</div> <div class='pt-3'><input type='button' class='btn btn-primary d-block js--create--client' value='Dodaj klijenta'/> </div>";
      return this.clientsContainer.html(html);
    };

    ClientsPage.prototype._customHTML = function() {
      return " <nav class='nav justify-content-end pt-3'> <span class='nav-link span-a js--create--client'>Dodaj klijenta</span> </nav> <div class='js--filter--container--wrapper'></div> <div class='js--clients--container'></div>";
    };

    ClientsPage.prototype._renderClientsHTML = function(clients) {
      var client, email, firstName, i, lastName, len, mobileNumber, phoneNumber, rowHtml, street, tableHtml;
      tableHtml = "<div> <table class='table mb-0'> <tr> <th class='table-text w-10'>Profil</th> <th class='table-text w-15'>Ime</th> <th class='table-text w-20'>Prezime</th> <th class='table-text w-15'>Telefon</th> <th class='table-text w-20'>Ulica</th> <th class='table-text w-20'>Email</th> </tr> </table> <table class='table table-striped'>";
      rowHtml = "";
      for (i = 0, len = clients.length; i < len; i++) {
        client = clients[i];
        firstName = client.firstName || '/';
        lastName = client.lastName || '/';
        phoneNumber = client.phoneNumber || '/';
        mobileNumber = client.mobileNumber || '/';
        street = client.street || '/';
        email = client.email || '/';
        rowHtml = "<tr class='js--client--row' data-client-id=" + client.id + "> <td class='table-text w-10'> <a href='#client/" + client.id + "'><span class='client-details-icon'></span></a> </td> <td class='table-text w-15'>" + firstName + "</td> <td class='table-text w-20'>" + lastName + "</td> <td class='table-text w-15'>" + phoneNumber + "</td> <td class='table-text w-20'>" + street + "</td> <td class='table-text w-20'>" + email + "</td> </tr>";
        tableHtml += rowHtml;
      }
      tableHtml += "</table></div>";
      return this.clientsContainer.html(tableHtml);
    };

    ClientsPage.prototype._clickEventHandler = function(event) {
      var id, target;
      target = $(event.target);
      if (this._closest(target, ".js--create--client")) {
        this.createClientDialog.show();
        return;
      }
      if (this._closest(target, '.js--show--client')) {
        id = target.attr('data-client-id');
        window.location.hash = 'client/' + id;
      }
    };

    ClientsPage.prototype._closest = function(target, closestTo) {
      return target.closest(closestTo).length > 0;
    };

    ClientsPage.prototype._refreshClientsHTML = function() {
      return this._renderClientsHTML(this.clients);
    };

    ClientsPage.prototype._addNewClient = function(client) {
      return this.clients.push(client);
    };

    ClientsPage.prototype._createdNewClient = function(event, client) {
      this._addNewClient(client);
      return this._refreshClientsHTML();
    };

    ClientsPage.prototype.triggerFilterAs = function(event) {
      return ComponentsUtils.handleAutoSuggestion(this.filterAsInput, 'data-client-id', this.clients, this.suggestionsContainer, true, this, this._resetFilter);
    };

    ClientsPage.prototype.triggerFilterStatus = function(event) {
      return this._applyFilter();
    };

    ClientsPage.prototype.triggerFilterSuggestions = function(event) {
      var target;
      target = $(event.target);
      ComponentsUtils.selectFromAutoSuggestion(target, this.filterAsInput, 'data-client-id', this.clients, this.suggestionsContainer);
      this._applyFilter();
    };

    ClientsPage.prototype.triggerFilterReset = function(event) {
      this._resetFilter();
    };

    ClientsPage.prototype._applyFilter = function() {
      var client, clients, filteredClients, i, id, j, k, len, len1, len2, ref, ref1, status;
      status = this.filterStatus.val();
      clients = [];
      if (status === 'all') {
        clients = this.clients;
      } else if (status === 'paid') {
        ref = this.clients;
        for (i = 0, len = ref.length; i < len; i++) {
          client = ref[i];
          if (!client.unpaid) {
            clients.push(client);
          }
        }
      } else if (status === 'unpaid') {
        ref1 = this.clients;
        for (j = 0, len1 = ref1.length; j < len1; j++) {
          client = ref1[j];
          if (client.unpaid) {
            clients.push(client);
          }
        }
      }
      id = Number(this.filterAsInput.attr('data-client-id'));
      if (!isNaN(id)) {
        filteredClients = [];
        for (k = 0, len2 = clients.length; k < len2; k++) {
          client = clients[k];
          if (client.id === id) {
            filteredClients.push(client);
          }
        }
        clients = filteredClients;
      }
      if (clients.length === 0) {
        return this.clientsContainer.html(this.autoSuggestion.emptyState());
      } else {
        return this._renderClientsHTML(clients);
      }
    };

    ClientsPage.prototype._resetFilter = function() {
      this.filterAsInput.val('');
      this.filterAsInput.removeAttr('data-client-id');
      this.filterStatus.val(this.filterStatus[0].options[0].value);
      return this._renderClientsHTML(this.clients);
    };

    return ClientsPage;

  })(AbstractPage);

}).call(this);
