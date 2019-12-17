// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.OrderPage = (function(superClass) {
    extend(OrderPage, superClass);

    function OrderPage(orderId) {
      OrderPage.__super__.constructor.call(this);
      this.order = null;
      OrderService.get(orderId, null, this, this._loadedOrder, ajaxCallbackPrintMessage);
    }

    OrderPage.prototype.destroy = function() {
      OrderPage.__super__.destroy.call(this);
      return this.order = null;
    };

    OrderPage.prototype._loadedOrder = function(response) {
      console.log(response);
      this.order = response.data;
      return this.pageHTML();
    };

    OrderPage.prototype._customHTML = function() {
      var i, key, keys, len, workersHTML;
      workersHTML = '';
      keys = Object.keys(this.order.workersMap);
      for (i = 0, len = keys.length; i < len; i++) {
        key = keys[i];
        workersHTML += "<a href='#worker/" + key + "'>" + this.order.workersMap[key] + "</a></br>";
      }
      return "<div class='h-75 pt-5 flex'> <div class='container w-50'> <table class='table table-borderless'> <tr> <td>Porudžbinu kreirao/la</td> <td><a href='#user/" + this.order.createdById + "'>" + this.order.createdByName + "</a></td> </tr> <tr> <td>Klijent</td> <td><a href='#client/" + this.order.clientId + "'>" + this.order.clientName + "</a></td> </tr> <tr> <td>Kreirano</td> <td>" + (ComponentsUtils.getTimeFromMillis(this.order.createdAtMillis)) + "</td> </tr> <tr> <td>Status prodžbine</td> <td>" + this.order.status + "</td> </tr> <tr> <td>Cena</td> <td>" + this.order.saldo + "</td> </tr> <tr> <td>Uplaćeno</td> <td>" + this.order.paid + "</td> </tr> <tr> <td>Radnici</td> <td>" + workersHTML + "</td> </tr> </table> </div> </div>";
    };

    return OrderPage;

  })(AbstractPage);

}).call(this);
