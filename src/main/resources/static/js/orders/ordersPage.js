// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.OrdersPage = (function(superClass) {
    extend(OrdersPage, superClass);

    function OrdersPage(clientId, container) {
      var filterStatus;
      OrdersPage.__super__.constructor.call(this);
      this.pageHTML();
      if (clientId) {
        OrderService.getAllClientOrders(clientId, null, this, this._ordersLoadedSuccess, ajaxCallbackPrintMessage);
      } else {
        OrderService.getAll(null, this, this._ordersLoadedSuccess, ajaxCallbackPrintMessage);
      }
      this.ordersContainer = this.container.find('.js--orders--container');
      this.filterContainer = this.container.find('.js--filter--container--wrapper');
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
      this.autoSuggestion = new AutoSuggestion(this, this.filterContainer, AutoSuggestion.ORDER_FILTER, filterStatus);
      this.asInput = this.container.find('.js--filter--as');
      this.filterFrom = this.container.find('.js--filter--from');
      this.filterTo = this.container.find('.js--filter--to');
      this.suggestionsContainer = this.container.find('.js--filter--suggestions');
      this.status = this.container.find('.js--filter--status');
      this.filterToggleButton = this.container.find('.js--filters--content');
    }

    OrdersPage.prototype.destroy = function() {
      var filterStatus;
      OrdersPage.__super__.destroy.call(this);
      this.autoSuggestion.destroy();
      this.autoSuggestion = null;
      this.ordersContainer = null;
      this.filterContainer = null;
      filterStatus = null;
      this.asInput = null;
      this.filterFrom = null;
      this.filterTo = null;
      this.status = null;
      this.suggestionsContainer = null;
      return this.filterToggleButton = null;
    };

    OrdersPage.prototype.getPageTitle = function() {
      return "Porudzbine";
    };

    OrdersPage.prototype._clickEventHandler = function(event) {};

    OrdersPage.prototype._ordersLoadedSuccess = function(response) {
      this.orders = response.orders;
      this.clients = response.clients;
      if (this.orders.length > 0) {
        return this._renderOrdersHTML(this.orders);
      } else {
        return this._renderEmptyState();
      }
    };

    OrdersPage.prototype._renderEmptyState = function() {
      return this.ordersContainer.html(ComponentsUtils.emptyState('Nema porudžbenica :('));
    };

    OrdersPage.prototype._customHTML = function() {
      return "<div class='js--filter--container--wrapper pt-5'></div> <div class='js--orders--container'> " + (ComponentsUtils.loadingPage()) + " </div>";
    };

    OrdersPage.prototype._renderOrdersHTML = function(orders) {
      var i, innerHTML, len, order, tableHtml;
      tableHtml = '';
      innerHTML = '';
      for (i = 0, len = orders.length; i < len; i++) {
        order = orders[i];
        innerHTML += "<tr> <td class='table-text w-20'> <a class='text-decoration-none' href='#order/" + order.id + "'> <span class='d-inline-block align-middle launch-icon'></span> </a> " + order.clientFullName + " </td> <td class='table-text w-20'>" + order.saldo + "</td> <td class='table-text w-20'>" + order.paid + "</td> <td class='table-text w-20'>" + order.statusStr + "</td> <td class='table-text w-20'>" + (ComponentsUtils.getTimeFromMillis(order.createdAtMillis)) + "</td> </tr>";
      }
      tableHtml = "<div> <table class='table mb-0'> <tr> <th class='table-text w-20'>Poručilac</th> <th class='table-text w-20'>Cena</th> <th class='table-text w-20'>Uplaćeno</th> <th class='table-text w-20'>Status</th> <th class='table-text w-20'>Poručeno</th> </tr> </table> <table class='table table-striped'> " + innerHTML + " </table> </div>";
      return this.ordersContainer.html(tableHtml);
    };

    OrdersPage.prototype.triggerFilterAs = function(event) {
      return ComponentsUtils.handleAutoSuggestion(this.asInput, 'data-order-id', this.clients, this.suggestionsContainer, false, this, this._resetFilter);
    };

    OrdersPage.prototype.triggerFilterSuggestions = function(event) {
      ComponentsUtils.selectFromAutoSuggestion($(event.target), this.asInput, 'data-order-id', this.clients, this.suggestionsContainer, this._applyFilter);
      return this._applyFilter();
    };

    OrdersPage.prototype.triggerFilterStatus = function(event) {
      return this._applyFilter();
    };

    OrdersPage.prototype.triggerFilterReset = function(event) {
      return this._resetFilter();
    };

    OrdersPage.prototype.triggerFilterFrom = function(event) {
      return this._applyFilter();
    };

    OrdersPage.prototype.triggerFilterTo = function(event) {
      return this._applyFilter();
    };

    OrdersPage.prototype._applyFilter = function() {
      var dateFrom, dateTo, filteredOrders, filteredWithDate, i, id, j, k, l, len, len1, len2, len3, order, orders, ref, ref1, status;
      status = this.status.val();
      orders = [];
      if (status === 'all') {
        orders = this.orders;
      } else if (status === 'paid') {
        ref = this.orders;
        for (i = 0, len = ref.length; i < len; i++) {
          order = ref[i];
          if (order.paid === order.saldo) {
            orders.push(order);
          }
        }
      } else if (status === 'unpaid') {
        ref1 = this.orders;
        for (j = 0, len1 = ref1.length; j < len1; j++) {
          order = ref1[j];
          if (order.paid < order.saldo) {
            orders.push(order);
          }
        }
      }
      id = Number(this.asInput.attr('data-order-id'));
      if (!isNaN(id)) {
        filteredOrders = [];
        for (k = 0, len2 = orders.length; k < len2; k++) {
          order = orders[k];
          if (order.clientId === id) {
            filteredOrders.push(order);
          }
        }
        orders = filteredOrders;
      }
      if (this.filterFrom.val() || this.filterTo.val()) {
        if (this.filterFrom.val()) {
          dateFrom = new Date(this.filterFrom.val()).getTime();
        } else {
          dateFrom = new Date('1970').getTime();
        }
        if (this.filterTo.val()) {
          dateTo = new Date(this.filterTo.val()).getTime();
        } else {
          dateTo = new Date().getTime();
        }
        filteredWithDate = [];
        for (l = 0, len3 = orders.length; l < len3; l++) {
          order = orders[l];
          if (order.buildDateMillis >= dateFrom && order.buildDateMillis <= dateTo) {
            filteredWithDate.push(order);
          }
        }
        orders = filteredWithDate;
      }
      if (orders.length === 0) {
        return this.ordersContainer.html(this.autoSuggestion.emptyState());
      } else {
        return this._renderOrdersHTML(orders);
      }
    };

    OrdersPage.prototype._resetFilter = function() {
      this.asInput.val('');
      this.asInput.removeAttr('data-user-id');
      this.status.val(this.status[0].options[0].value);
      return this._renderOrdersHTML(this.orders);
    };

    return OrdersPage;

  })(AbstractPage);

}).call(this);
