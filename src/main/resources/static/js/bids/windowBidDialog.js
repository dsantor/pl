// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.WindowBidDialog = (function(superClass) {
    extend(WindowBidDialog, superClass);

    WindowBidDialog.BID_TYPE = 'WINDOW';

    function WindowBidDialog() {
      WindowBidDialog.__super__.constructor.call(this);
    }

    WindowBidDialog.prototype.show = function(parentPage, updateItem) {
      this.parentPage = parentPage;
      if (updateItem == null) {
        updateItem = null;
      }
      WindowBidDialog.__super__.show.call(this);
      this.customHTML();
      this.sort = this.container.find('.js--sort');
      this.openSide = this.container.find('.js--open--side');
      this.glass = this.container.find('.js--glass');
      this.tipper = this.container.find('.js--tipper');
      this.width = this.container.find('.js--width');
      this.height = this.container.find('.js--height');
      this.innerWidth = this.container.find('.js--inner--width');
      this.price = this.container.find('.js--price');
      this.quantity = this.container.find('.js--quantity');
      this.id = null;
      if (updateItem) {
        this.sort.val(updateItem.sort || '---');
        this.openSide.val(updateItem.openSide || '---');
        this.glass.val(updateItem.glass || '---');
        this.tipper.val(updateItem.tipper || '---');
        this.width.val(updateItem.width || '');
        this.height.val(updateItem.height || '');
        this.innerWidth.val(updateItem.innerWidth || '');
        this.price.val(updateItem.price || '');
        this.quantity.val(updateItem.quantity || '');
        return this.id = updateItem.id;
      }
    };

    WindowBidDialog.prototype.hide = function() {
      return WindowBidDialog.__super__.hide.call(this);
    };

    WindowBidDialog.prototype.destroy = function() {
      this.parentPage = null;
      this.sort = null;
      this.openSide = null;
      this.glass = null;
      this.tipper = null;
      this.width = null;
      this.height = null;
      this.innerWidth = null;
      this.price = null;
      this.quantity = null;
      return WindowBidDialog.__super__.destroy.call(this);
    };

    WindowBidDialog.prototype.positiveAction = function() {
      var formData;
      if (!this._validateForm()) {
        return;
      }
      formData = this._collectDataFromForm();
      this.parentPage.bidDialogResult(formData);
      return this.hide();
    };

    WindowBidDialog.prototype.negativeAction = function() {
      return WindowBidDialog.__super__.negativeAction.call(this);
    };

    WindowBidDialog.prototype._collectDataFromForm = function() {
      return {
        bidType: WindowBidDialog.BID_TYPE,
        id: this.id,
        sort: this._valueOf(this.sort.val()),
        openSide: this._valueOf(this.openSide.val()),
        glass: this._valueOf(this.glass.val()),
        tipper: this._valueOf(this.tipper.val()),
        width: this._valueOf(this.width.val()),
        height: this._valueOf(this.height.val()),
        innerWidth: this._valueOf(this.innerWidth.val()),
        price: this._valueOf(this.price.val()),
        quantity: this._valueOf(this.quantity.val())
      };
    };

    WindowBidDialog.prototype._validateForm = function() {
      var valid, validInput;
      valid = true;
      validInput = this._validateInput(this.sort);
      valid &= validInput;
      validInput = this._validateInput(this.openSide);
      valid &= validInput;
      validInput = this._validateInput(this.glass);
      valid &= validInput;
      validInput = this._validateInput(this.tipper);
      valid &= validInput;
      validInput = this._validateInput(this.width);
      valid &= validInput;
      validInput = this._validateInput(this.height);
      valid &= validInput;
      validInput = this._validateInput(this.innerWidth);
      valid &= validInput;
      validInput = this._validateInput(this.price);
      valid &= validInput;
      validInput = this._validateInput(this.quantity);
      valid &= validInput;
      return valid;
    };

    WindowBidDialog.prototype._customHTML = function() {
      return "<div class='col-7 m-auto p-5 flex'> <div class='container container-padding w-50'> <h5>Opste</h5> <br> <div class='form-group'> <label>Vrsta prozora*</label> <select class='js--sort'> <option selected>---</option> <option>Jednokrilni</option> <option>Dvokrlni</option> <option>Trokrilni</option> <option>Fiks</option> </select> </div> <div class='form-group'> <label>Otvor*</label> <select class='js--open--side'> <option selected>---</option> <option>Levi</option> <option>Desni</option> </select> </div> <div class='form-group'> <label>Staklo*</label> <select class='js--glass'> <option selected>---</option> <option>Providno</option> <option>Griz</option> </select> </div> <div class='form-group'> <label>Kipovanje*</label> <select class='js--tipper'> <option selected>---</option> <option>Da</option> <option>Ne</option> </select> </div> <div class='form-group'> <label>Kolicina*</label> <input type='number' min='1' class='form-control js--quantity' value='1'> </div> <div class='form-group'> <label>Cena*</label> <input type='number' min='1' class='form-control js--price' placeholder='din'> </div> <div class='form-group'> <br> <hr> <h5>Dimenzije</h5> <br> <div class='form-group form-inline'> <label class='mr-2 wc-10 left-label'>Sirina</label> <input type='number' class='form-control js--width' placeholder='cm'> </div> <div class='form-group form-inline'> <label class='mr-2 wc-10 left-label'>Visina</label> <input type='number' class='form-control js--height' placeholder='cm'> </div> <div class='form-group form-inline'> <label class='mr-2 wc-10 left-label'>Unutrasnja sirina</label> <input type='number' class='form-control js--inner--width' placeholder='cm'> </div> </div> </div> </div>";
    };

    return WindowBidDialog;

  })(AbstractDialog);

}).call(this);
