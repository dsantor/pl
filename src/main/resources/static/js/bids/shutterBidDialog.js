// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.ShutterBidDialog = (function(superClass) {
    extend(ShutterBidDialog, superClass);

    ShutterBidDialog.BID_TYPE = 'SHUTTER';

    function ShutterBidDialog() {
      ShutterBidDialog.__super__.constructor.call(this);
    }

    ShutterBidDialog.prototype.show = function(parentPage, updateItem) {
      this.parentPage = parentPage;
      if (updateItem == null) {
        updateItem = null;
      }
      ShutterBidDialog.__super__.show.call(this);
      this.customHTML();
      this.sort = this.container.find('.js--sort');
      this.box = this.container.find('.js--box');
      this.boxType = this.container.find('.js--box--type');
      this.openSide = this.container.find('.js--open--side');
      this.quantity = this.container.find('.js--quantity');
      this.width = this.container.find('.js--width');
      this.height = this.container.find('.js--height');
      this.quantity = this.container.find('.js--quantity');
      this.price = this.container.find('.js--price');
      this.id = null;
      this.additionBoxOptions = this.container.find('.js--box--type--option');
      this.additionBoxActive = false;
      if (updateItem) {
        this.sort.val(updateItem.sort || '---');
        this.box.val(updateItem.box || '---');
        this.boxType.val(updateItem.boxType || '---');
        this.openSide.val(updateItem.openSide || '---');
        this.quantity.val(updateItem.quantity || '');
        this.width.val(updateItem.width || '');
        this.height.val(updateItem.height || '');
        this.price.val(updateItem.price || '');
        this.quantity.val(updateItem.quantity || '');
        this.id = updateItem.id;
        if (updateItem.boxType) {
          this.additionBoxOptions.removeClass('hide');
          return this.additionBoxActive = true;
        }
      }
    };

    ShutterBidDialog.prototype.hide = function() {
      return ShutterBidDialog.__super__.hide.call(this);
    };

    ShutterBidDialog.prototype.destroy = function() {
      this.parentPage = null;
      this.orderTypes = null;
      this.additionBoxOptions = null;
      this.additionBoxActive = null;
      this.sort = null;
      this.box = null;
      this.boxType = null;
      this.openSide = null;
      this.width = null;
      this.height = null;
      this.quantity = null;
      this.price = null;
      return ShutterBidDialog.__super__.destroy.call(this);
    };

    ShutterBidDialog.prototype.positiveAction = function() {
      var formData;
      if (!this._validateForm()) {
        return;
      }
      formData = this._collectDataFromForm();
      this.parentPage.bidDialogResult(formData);
      return this.hide();
    };

    ShutterBidDialog.prototype.negativeAction = function() {
      return ShutterBidDialog.__super__.negativeAction.call(this);
    };

    ShutterBidDialog.prototype.setData = function(orderTypes) {
      this.orderTypes = orderTypes;
    };

    ShutterBidDialog.prototype._pageClickEventHandler = function(event) {
      var target;
      target = $(event.target);
      if (closest(target, '.js--box')) {
        return this._checkBoxTypeOptions(target);
      }
    };

    ShutterBidDialog.prototype._collectDataFromForm = function() {
      var boxType;
      if (this.box.val() !== 'Spoljasnja') {
        boxType = null;
      } else {
        boxType = this._valueOf(this.boxType.val());
      }
      return {
        bidType: ShutterBidDialog.BID_TYPE,
        id: this.id,
        sort: this._valueOf(this.sort.val()),
        box: this._valueOf(this.box.val()),
        boxType: boxType,
        openSide: this._valueOf(this.openSide.val()),
        width: this._valueOf(this.width.val()),
        height: this._valueOf(this.height.val()),
        quantity: this._valueOf(this.quantity.val()),
        price: this._valueOf(this.price.val())
      };
    };

    ShutterBidDialog.prototype._validateForm = function() {
      var valid, validInput;
      valid = true;
      validInput = this._validateInput(this.sort);
      valid &= validInput;
      validInput = this._validateInput(this.box);
      valid &= validInput;
      if (this.additionBoxActive) {
        validInput = this._validateInput(this.boxType);
        valid &= validInput;
      }
      validInput = this._validateInput(this.openSide);
      valid &= validInput;
      validInput = this._validateInput(this.width);
      valid &= validInput;
      validInput = this._validateInput(this.height);
      valid &= validInput;
      validInput = this._validateInput(this.price);
      valid &= validInput;
      validInput = this._validateInput(this.quantity);
      valid &= validInput;
      return valid;
    };

    ShutterBidDialog.prototype._checkBoxTypeOptions = function(element) {
      var option;
      option = element[0].options;
      if (option[option.selectedIndex].value === 'Spoljasnja') {
        return this.additionBoxOptions.removeClass('hide');
      } else {
        return this.additionBoxOptions.addClass('hide');
      }
    };

    ShutterBidDialog.prototype._customHTML = function() {
      return "<div class='col-7 m-auto p-5 flex'> <div class='container container-padding w-50'> <h5>Opste</h5> <br> <div class='form-group'> <label>Vrsta roletne*</label> <select class='js--sort'> <option selected>---</option> " + (this._printOptionsHTML(this.orderTypes['SHUTTER_SORT'])) + " </select> </div> <div class='form-group'> <label>Vrsta kutije*</label> <select class='js--box'> <option value='0'>---</option> " + (this._printOptionsHTML(this.orderTypes['SHUTTER_BOX_SORT'])) + " </select> </div> <div class='form-group js--box--type--option hide'> <label>Tip kutije*</label> <select class='js--box--type'> <option>---</option> " + (this._printOptionsHTML(this.orderTypes['SHUTTER_BOX_TYPE'])) + " </select> </div> <div class='form-group'> <label>Strana otvora*</label> <select class='js--open--side'> <option selected>---</option> <option>Levi otvor</option> <option>Desni otvor</option> </select> </div> <div class='form-group'> <label>Kolicina*</label> <input type='number' min='1' class='form-control js--quantity' value='1'> </div> <div class='form-group'> <label>Cena*</label> <input type='number' min='1' class='form-control js--price' placeholder='din'> </div> <div class='form-group'> <br> <hr> <h5>Dimenzije</h5> <br> <div class='form-group form-inline'> <label class='mr-2 wc-10 left-label'>Sirina</label> <input type='number' class='form-control js--width' placeholder='cm'> </div> <div class='form-group form-inline'> <label class='mr-2 wc-10 left-label'>Visina</label> <input type='number' class='form-control js--height' placeholder='cm'> </div> </div> </div> </div> </div>";
    };

    return ShutterBidDialog;

  })(AbstractDialog);

}).call(this);
