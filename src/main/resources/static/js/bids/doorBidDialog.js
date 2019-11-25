// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.DoorBidDialog = (function(superClass) {
    extend(DoorBidDialog, superClass);

    DoorBidDialog.BID_TYPE = 'DOOR';

    function DoorBidDialog() {
      DoorBidDialog.__super__.constructor.call(this);
    }

    DoorBidDialog.prototype._pageClientEventHandler = function(event) {
      var target;
      DoorBidDialog.__super__._pageClientEventHandler.call(this);
      target = $(event.target);
      if (closest(target, '.select--input')) {
        return this._validateInput(target);
      }
    };

    DoorBidDialog.prototype.show = function(parentPage, updateItem) {
      this.parentPage = parentPage;
      if (updateItem == null) {
        updateItem = null;
      }
      DoorBidDialog.__super__.show.call(this);
      this.sort = this.container.find('.js--sort');
      this.type = this.container.find('.js--type');
      this.openSide = this.container.find('.js--open--side');
      this.glass = this.container.find('.js--glass');
      this.width = this.container.find('.js--width');
      this.height = this.container.find('.js--height');
      this.innerWidth = this.container.find('.js--inner-width');
      this.count = this.container.find('.js--count');
      this.id = null;
      if (updateItem) {
        this.sort.val(updateItem.sort || '---');
        this.type.val(updateItem.type || '---');
        this.openSide.val(updateItem.openSide || '---');
        this.glass.val(updateItem.glass || '---');
        this.width.val(updateItem.width || '');
        this.height.val(updateItem.height || '');
        this.innerWidth.val(updateItem.innerWidth || '');
        this.count.val(updateItem.count || '');
        return this.id = updateItem.id;
      }
    };

    DoorBidDialog.prototype.hide = function() {
      return DoorBidDialog.__super__.hide.call(this);
    };

    DoorBidDialog.prototype.destroy = function() {
      this.parentPage = null;
      return DoorBidDialog.__super__.destroy.call(this);
    };

    DoorBidDialog.prototype.positiveAction = function() {
      var formData;
      if (!this._validateForm()) {
        return;
      }
      formData = this._collectDataFromForm();
      this.parentPage.bidDialogResult(formData);
      return this.hide();
    };

    DoorBidDialog.prototype.negativeAction = function() {
      return DoorBidDialog.__super__.negativeAction.call(this);
    };

    DoorBidDialog.prototype._collectDataFromForm = function() {
      return {
        bidType: DoorBidDialog.BID_TYPE,
        id: this.id,
        sort: this._valueOf(this.sort.val()),
        type: this._valueOf(this.type.val()),
        openSide: this._valueOf(this.openSide.val()),
        glass: this._valueOf(this.glass.val()),
        width: this._valueOf(this.width.val()),
        height: this._valueOf(this.height.val()),
        innerWidth: this._valueOf(this.innerWidth.val()),
        count: this._valueOf(this.count.val())
      };
    };

    DoorBidDialog.prototype._valueOf = function(value) {
      if (!value || value === '---') {
        return null;
      }
      return value.trim();
    };

    DoorBidDialog.prototype._validateInput = function(input) {
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

    DoorBidDialog.prototype._validateForm = function() {
      var valid, validInput;
      valid = true;
      validInput = this._validateInput(this.sort);
      valid &= validInput;
      validInput = this._validateInput(this.type);
      valid &= validInput;
      validInput = this._validateInput(this.openSide);
      valid &= validInput;
      validInput = this._validateInput(this.glass);
      valid &= validInput;
      return valid;
    };

    DoorBidDialog.prototype._customHTML = function() {
      return "<div class='col-7 m-auto p-5 flex'> <div class='container container-padding w-50'> <h5>Opste</h5> <br> <div class='form-group'> <label>Vrsta vrata*</label> <select class='select--input js--sort'> <option selected>---</option> <option>Ulazna</option> <option>Sobna</option> <option>Jednokrilna balkonska</option> <option>Dvokrilna balkonska</option> <option>Garažna</option> <option>segmentna garazna</option> <option>Rolo</option> </select> </div> <div class='form-group'> <label>Tip vrata*</label> <select class='select--input js--type'> <option selected>---</option> <option>Sa staklom</option> <option>Pun panel</option> <option>Panel/staklo</option> <option>Dekorativni modeli</option> </select> </div> <div class='form-group'> <label>Strana otvora*</label> <select class='select--input js--open--side'> <option selected>---</option> <option>Levi otvor</option> <option>Desni otvor</option> </select> </div> <div class='form-group'> <label>Staklo*</label> <select class='select--input js--glass'> <option selected>---</option> <option>Providno</option> <option>Griz</option> <option>Delta</option> <option>Vitraz</option> </select> </div> <div class='form-group'> <label>Kolicina*</label> <input type='number' min='1' class='form-control js--count' value='1'> </div> <div class='form-group'> <br> <hr> <h5>Dimenzije</h5> <br> <div class='form-group form-inline'> <label class='mr-2 wh-10 left-label'>Sirina*</label> <input type='number' min='0' class='form-control js--width' placeholder='cm'> </div> <div class='form-group form-inline'> <label class='mr-2 wh-10 left-label'>Visina*</label> <input type='number' min='0' class='form-control js--height' placeholder='cm'> </div> <div class='form-group form-inline'> <label class='mr-2 wh-10 left-label'>Unutrasnja sirina*</label> <input type='number' min='0' class='form-control js--inner-width' placeholder='cm'> </div> </div> </div> </div>";
    };

    return DoorBidDialog;

  })(AbstractDialog);

}).call(this);
