// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.ThresholdBidDialog = (function(superClass) {
    extend(ThresholdBidDialog, superClass);

    ThresholdBidDialog.BID_TYPE = 'THRESHOLD';

    function ThresholdBidDialog() {
      ThresholdBidDialog.__super__.constructor.call(this);
    }

    ThresholdBidDialog.prototype.show = function(parentPage, updateItem) {
      this.parentPage = parentPage;
      if (updateItem == null) {
        updateItem = null;
      }
      ThresholdBidDialog.__super__.show.call(this);
      this.sort = this.container.find('.js--sort');
      this.width = this.container.find('.js--width');
      this.height = this.container.find('.js--height');
      this.innerWidth = this.container.find('.js--inner-width');
      this.count = this.container.find('.js--count');
      this.id = null;
      if (updateItem) {
        this.sort.val(updateItem.sort);
        this.width.val(updateItem.width || '');
        this.height.val(updateItem.height || '');
        this.innerWidth.val(updateItem.innerWidth || '');
        this.count.val(updateItem.count || '');
        return this.id = updateItem.id;
      }
    };

    ThresholdBidDialog.prototype.hide = function() {
      return ThresholdBidDialog.__super__.hide.call(this);
    };

    ThresholdBidDialog.prototype.destroy = function() {
      this.parentPage = null;
      return ThresholdBidDialog.__super__.destroy.call(this);
    };

    ThresholdBidDialog.prototype.positiveAction = function() {
      var formData;
      if (!this._validateForm()) {
        return;
      }
      formData = this._collectDataFromForm();
      this.parentPage.bidDialogResult(formData);
      return this.hide();
    };

    ThresholdBidDialog.prototype.negativeAction = function() {
      return ThresholdBidDialog.__super__.negativeAction.call(this);
    };

    ThresholdBidDialog.prototype._collectDataFromForm = function() {
      return {
        bidType: ThresholdBidDialog.BID_TYPE,
        id: this.id,
        sort: this._valueOf(this.sort.val()),
        width: this._valueOf(this.width.val()),
        height: this._valueOf(this.height.val()),
        innerWidth: this._valueOf(this.innerWidth.val()),
        count: this._valueOf(this.count.val())
      };
    };

    ThresholdBidDialog.prototype._validateForm = function() {
      return this._validateInput(this.sort);
    };

    ThresholdBidDialog.prototype._valueOf = function(value) {
      if (!value || value === '---') {
        return null;
      }
      return value.trim();
    };

    ThresholdBidDialog.prototype._validateInput = function(input) {
      var valid;
      valid = true;
      if (this._valueOf(input.val())) {
        input.removeClass(ComponentsUtils.CSS_INVALID_INPUT);
      } else {
        valid = false;
        input.addClass(ComponentsUtils.CSS_INVALID_INPUT);
      }
      return valid;
    };

    ThresholdBidDialog.prototype._customHTML = function() {
      return "<div class='col-7 m-auto p-5 flex'> <div class='container container-padding w-50'> <h5>Opste</h5> <br> <div class='form-group'> <label>Vrsta praga</label> <select class='js--sort'> <option selected>---</option> <option>Alu prag</option> <option>Stok</option> </select> </div> <div class='form-group'> <label>Kolicina*</label> <input type='number' min='1' class='form-control js--count' value='1'> </div> <div class='form-group'> <br> <hr> <h5>Dimenzije</h5> <br> <div class='form-group form-inline'> <label class='mr-2 wh-10 left-label'>Sirina</label> <input type='number' min='0' class='form-control js--width' placeholder='cm'> </div> <div class='form-group form-inline'> <label class='mr-2 wh-10 left-label'>Visina</label> <input type='number' min='0' class='form-control js--height' placeholder='cm'> </div> <div class='form-group form-inline'> <label class='mr-2 wh-10 left-label'>Unutrasnja sirina</label> <input type='number' min='0' class='form-control js--inner--width' placeholder='cm'> </div> </div> </div> </div>";
    };

    return ThresholdBidDialog;

  })(AbstractDialog);

}).call(this);
