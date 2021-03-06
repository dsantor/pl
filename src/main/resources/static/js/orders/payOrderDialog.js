// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.PayOrderDialog = (function(superClass) {
    extend(PayOrderDialog, superClass);

    function PayOrderDialog() {
      PayOrderDialog.__super__.constructor.call(this);
    }

    PayOrderDialog.prototype.destroy = function() {
      PayOrderDialog.__super__.destroy.call(this);
      this.orderId = null;
      return this.parentPage = null;
    };

    PayOrderDialog.prototype.show = function(orderId, parentPage) {
      this.orderId = orderId;
      this.parentPage = parentPage;
      PayOrderDialog.__super__.show.call(this);
      return this.customHTML();
    };

    PayOrderDialog.prototype.hide = function() {
      return PayOrderDialog.__super__.hide.call(this);
    };

    PayOrderDialog.prototype.positiveAction = function() {
      var data, paidAmount;
      paidAmount = this.container.find('.js--paid--amount');
      if (!this._validateInput(paidAmount)) {
        return;
      }
      data = {
        orderId: this.orderId,
        paidAmount: paidAmount.val().trim()
      };
      OrderService.payOrder(data, null, this, this._payOrderSuccess, this._payOrderError);
      return PayOrderDialog.__super__.positiveAction.call(this);
    };

    PayOrderDialog.prototype._customHTML = function() {
      return "<div class='col-7 m-auto p-5 flex'> <div class='container container-padding w-50'> <div class='form-group'> <div class='pos-rel'> <label>Iznos uplate*</label> <input type='number' class='form-control js--paid--amount' placeholder='din'/> </div> </div> </div> </div>";
    };

    PayOrderDialog.prototype._payOrderSuccess = function(response) {
      FloatingMessage.success("Uspešno izvešeno plaćanje");
      if (this.parentPage && (this.parentPage.payOrderSuccess != null)) {
        return this.parentPage.payOrderSuccess(response);
      }
    };

    PayOrderDialog.prototype._payOrderError = function(response) {
      return FloatingMessage.error("Došlo je do greške. Pokušajte ponovo");
    };

    return PayOrderDialog;

  })(AbstractDialog);

}).call(this);
