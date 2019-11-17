// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.WindowBidDialog = (function(superClass) {
    extend(WindowBidDialog, superClass);

    function WindowBidDialog() {
      WindowBidDialog.__super__.constructor.call(this);
    }

    WindowBidDialog.prototype.show = function() {
      return WindowBidDialog.__super__.show.call(this);
    };

    WindowBidDialog.prototype.hide = function() {
      return WindowBidDialog.__super__.hide.call(this);
    };

    WindowBidDialog.prototype.destroy = function() {
      return WindowBidDialog.__super__.destroy.call(this);
    };

    WindowBidDialog.prototype.save = function() {
      this._collectDataFromForm();
      return WindowBidDialog.__super__.save.call(this);
    };

    WindowBidDialog.prototype.cancel = function() {
      return WindowBidDialog.__super__.cancel.call(this);
    };

    WindowBidDialog.prototype._collectDataFromForm = function() {
      return this.doorType = $('.js--door--type');
    };

    WindowBidDialog.prototype._templateHTML = function() {
      return "<div class='form-group form-inline header'> <div> <img src='https://www.dakiplast.rs/wp-content/uploads/2017/05/logo-small-01-300x75.png' style='max-width: 50%;'> </div> <div > <button class='cbtn btn-light " + ComponentsUtils.NEGATIVE_BUTTON + "' value='Izmeni'>Otkazi</button> <button class='cbtn  btn-primary " + ComponentsUtils.POSITIVE_BUTTON + "' value='Izmeni'>Sacuvaj</button> </div> </div> <div class='col-7 m-auto p-5 flex'> <div class='container container-padding w-50'> <h5>Opste</h5> <br> <div class='form-group'> <label>Vrsta prozora</label> <select> <option selected>---</option> <option>Jednokrilni</option> <option>Dvokrlni</option> <option>Trokrilni</option> <option>Fiks</option> </select> </div> <div class='form-group'> <label>Strana otvora</label> <select> <option selected>---</option> <option>Levi otvor</option> <option>Desni otvor</option> </select> </div> <div class='form-group'> <label>Staklo</label> <select> <option selected>---</option> <option>Providno</option> <option>Griz</option> </select> </div> <div class='form-group'> <br> <hr> <h5>Dimenzije</h5> <br> <div class='form-group form-inline'> <label class='mr-2 wh-10 left-label'>Sirina</label> <input type='number' class='form-control' placeholder='cm'> </div> <div class='form-group form-inline'> <label class='mr-2 wh-10 left-label'>Visina</label> <input type='number' class='form-control' placeholder='cm'> </div> <div class='form-group form-inline'> <label class='mr-2 wh-10 left-label'>Unutrasnja sirina</label> <input type='number' class='form-control' placeholder='cm'> </div> </div> <div class='form-group'> <br> <hr> <h5>Dodatno</h5> <br> <label>Kipovanje</label> <select> <option selected>---</option> <option>Da</option> <option>Ne</option> </select> </div> </div> </div>";
    };

    return WindowBidDialog;

  })(this.AbstractDialog);

}).call(this);
