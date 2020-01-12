// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.OrderTypesSettings = (function(superClass) {
    extend(OrderTypesSettings, superClass);

    function OrderTypesSettings() {
      OrderTypesSettings.__super__.constructor.call(this);
      this.doorSorts = ['Ulazna', 'Sobna', 'Dvokrilna balkonska', 'Garažna', 'Segmentna garazna', 'Rolo'];
      this.doorTypes = ['Sa staklom', 'Pun panel', 'Panel/staklo', 'Dekorativni modeli'];
      this.doorGlass = ['Providno', 'Griz', 'Delta', 'Vitraz'];
      this.thresholdSorts = ['Alu prag', 'Štok'];
      this.mosquitoSorts = ['Fiksni', 'Rolo'];
      this.mosquitoTypes = ['Vrata', 'Rolo'];
      this.windowSorts = ['Jednokrilni', 'Dvokrlni', 'Trokrilni', 'Fiks'];
      this.windowGlass = ['Providno', 'Griz'];
      this.shutterSorts = ['Kaiš', 'Kurbla', 'Elektronski pogon'];
      this.shutterBoxSorts = ['Spoljašnja', 'Unutrašnja'];
      this.shutterBoxTypes = ['RONDO poluzaobljeni', 'ALU liveni', 'ALU zastorom'];
      this.pageHTML();
    }

    OrderTypesSettings.prototype.destroy = function() {
      return OrderTypesSettings.__super__.destroy.call(this);
    };

    OrderTypesSettings.prototype._activeContainer = function(container) {
      this.container.find('.js--sub--nav--item').removeClass('active');
      this.container.find(container).addClass('active');
      this.container.find('.js--nav--container').addClass('hide');
      return this.container.find(container + '--container').removeClass('hide');
    };

    OrderTypesSettings.prototype._clickEventHandler = function(event) {
      var i, input, item, items, j, k, l, len, len1, len2, len3, len4, len5, len6, len7, len8, len9, m, n, o, p, q, r, ref, ref1, ref2, ref3, ref4, ref5, ref6, ref7, ref8, ref9, target, type;
      target = $(event.target);
      if (closest(target, '.js--nav--door')) {
        this._activeContainer('.js--nav--door');
        return;
      }
      if (closest(target, '.js--nav--threshold')) {
        this._activeContainer('.js--nav--threshold');
        return;
      }
      if (closest(target, '.js--nav--mosquito')) {
        this._activeContainer('.js--nav--mosquito');
        return;
      }
      if (closest(target, '.js--nav--window')) {
        this._activeContainer('.js--nav--window');
        return;
      }
      if (closest(target, '.js--nav--shutter')) {
        this._activeContainer('.js--nav--shutter');
        return;
      }
      if (closest(target, '.js--door--sort--add--button')) {
        input = $('.js--door--sort--add--value').val().trim();
        this.doorSorts.push(input);
        this._doorsHTML();
        return;
      }
      if (closest(target, '.js--door--sort--remove--value')) {
        type = $('.js--door--sort').val();
        items = [];
        ref = this.doorSorts;
        for (i = 0, len = ref.length; i < len; i++) {
          item = ref[i];
          if (item !== type) {
            items.push(item);
          }
        }
        this.doorSorts = items;
        this._doorsHTML();
        return;
      }
      if (closest(target, '.js--door--glass--add--button')) {
        input = $('.js--door--glass--add--value').val().trim();
        this.doorGlass.push(input);
        this._doorsHTML();
        return;
      }
      if (closest(target, '.js--door--glass--remove--value')) {
        type = $('.js--door--glass').val();
        items = [];
        ref1 = this.doorGlass;
        for (j = 0, len1 = ref1.length; j < len1; j++) {
          item = ref1[j];
          if (item !== type) {
            items.push(item);
          }
        }
        this.doorGlass = items;
        this._doorsHTML();
        return;
      }
      if (closest(target, '.js--door--type--add--button')) {
        input = $('.js--door--type--add--value').val().trim();
        this.doorTypes.push(input);
        this._doorsHTML();
        return;
      }
      if (closest(target, '.js--door--type--remove--value')) {
        type = $('.js--door--type').val();
        items = [];
        ref2 = this.doorTypes;
        for (k = 0, len2 = ref2.length; k < len2; k++) {
          item = ref2[k];
          if (item !== type) {
            items.push(item);
          }
        }
        this.doorTypes = items;
        this._doorsHTML();
        return;
      }
      if (closest(target, '.js--threshold--sort--add--button')) {
        input = $('.js--threshold--sort--add--value').val().trim();
        this.thresholdSorts.push(input);
        this._thresholdHTML();
        return;
      }
      if (closest(target, '.js--threshold--sort--remove--value')) {
        type = $('.js--threshold--sort').val();
        items = [];
        ref3 = this.thresholdSorts;
        for (l = 0, len3 = ref3.length; l < len3; l++) {
          item = ref3[l];
          if (item !== type) {
            items.push(item);
          }
        }
        this.thresholdSorts = items;
        this._thresholdHTML();
        return;
      }
      if (closest(target, '.js--mosquito--sort--add--button')) {
        input = $('.js--mosquito--sort--add--value').val().trim();
        this.mosquitoSorts.push(input);
        this._mosquitoHTML();
        return;
      }
      if (closest(target, '.js--mosquito--sort--remove--value')) {
        type = $('.js--mosquito--sort').val();
        items = [];
        ref4 = this.mosquitoSorts;
        for (m = 0, len4 = ref4.length; m < len4; m++) {
          item = ref4[m];
          if (item !== type) {
            items.push(item);
          }
        }
        this.mosquitoSorts = items;
        this._mosquitoHTML();
        return;
      }
      if (closest(target, '.js--window--sort--add--button')) {
        input = $('.js--window--sort--add--value').val().trim();
        this.windowSorts.push(input);
        this._windowHTML();
        return;
      }
      if (closest(target, '.js--window--sort--remove--value')) {
        type = $('.js--window--sort').val();
        items = [];
        ref5 = this.windowSorts;
        for (n = 0, len5 = ref5.length; n < len5; n++) {
          item = ref5[n];
          if (item !== type) {
            items.push(item);
          }
        }
        this.windowSorts = items;
        this._windowHTML();
        return;
      }
      if (closest(target, '.js--window--glass--add--button')) {
        input = $('.js--window--glass--add--value').val().trim();
        this.windowGlass.push(input);
        this._windowHTML();
        return;
      }
      if (closest(target, '.js--window--glass--remove--value')) {
        type = $('.js--window--glass').val();
        items = [];
        ref6 = this.windowGlass;
        for (o = 0, len6 = ref6.length; o < len6; o++) {
          item = ref6[o];
          if (item !== type) {
            items.push(item);
          }
        }
        this.windowGlass = items;
        this._windowHTML();
        return;
      }
      if (closest(target, '.js--shutter--sort--add--button')) {
        input = $('.js--shutter--sort--add--value').val().trim();
        this.shutterSorts.push(input);
        this._shutterHTML();
        return;
      }
      if (closest(target, '.js--shutter--sort--remove--value')) {
        type = $('.js--shutter--sort').val();
        items = [];
        ref7 = this.shutterSorts;
        for (p = 0, len7 = ref7.length; p < len7; p++) {
          item = ref7[p];
          if (item !== type) {
            items.push(item);
          }
        }
        this.shutterSorts = items;
        this._shutterHTML();
        return;
      }
      if (closest(target, '.js--shutter--box--sort--add--button')) {
        input = $('.js--shutter--box--sort--add--value').val().trim();
        this.shutterBoxSorts.push(input);
        this._shutterHTML();
        return;
      }
      if (closest(target, '.js--shutter--box--sort--remove--value')) {
        type = $('.js--shutter--box--sort').val();
        items = [];
        ref8 = this.shutterBoxSorts;
        for (q = 0, len8 = ref8.length; q < len8; q++) {
          item = ref8[q];
          if (item !== type) {
            items.push(item);
          }
        }
        this.shutterBoxSorts = items;
        this._shutterHTML();
        return;
      }
      if (closest(target, '.js--shutter--box--type--add--button')) {
        input = $('.js--shutter--box--type--add--value').val().trim();
        this.shutterBoxTypes.push(input);
        this._shutterHTML();
        return;
      }
      if (closest(target, '.js--shutter--box--type--remove--value')) {
        type = $('.js--shutter--box--type').val();
        items = [];
        ref9 = this.shutterBoxTypes;
        for (r = 0, len9 = ref9.length; r < len9; r++) {
          item = ref9[r];
          if (item !== type) {
            items.push(item);
          }
        }
        this.shutterBoxTypes = items;
        this._shutterHTML();
      }
    };

    OrderTypesSettings.prototype.pageHTML = function() {
      OrderTypesSettings.__super__.pageHTML.call(this);
      this._doorsHTML();
      this._thresholdHTML();
      this._mosquitoHTML();
      this._windowHTML();
      return this._shutterHTML();
    };

    OrderTypesSettings.prototype._customHTML = function() {
      return "<nav class='nav justify-content-end header pt-3'> <span class='nav-link span-a js--sub--nav--item js--nav--door active'>Vrata</span> <span class='nav-link span-a js--sub--nav--item js--nav--threshold'>Pragovi</span> <span class='nav-link span-a js--sub--nav--item js--nav--mosquito'>Komarnici</span> <span class='nav-link span-a js--sub--nav--item js--nav--window'>Prozori</span> <span class='nav-link span-a js--sub--nav--item js--nav--shutter'>Roletne</span> </nav> <div class='col-7 m-auto h-75 pt-5 flex'> <div class='container w-75'> <div class='js--nav--container js--nav--door--container'> </div> <div class='js--nav--container js--nav--threshold--container hide'> </div> <div class='js--nav--container js--nav--mosquito--container hide'> </div> <div class='js--nav--container js--nav--window--container hide'> </div> <div class='js--nav--container js--order--nav--shutter--container js--nav--shutter--container hide'> </div> </div> </div>";
    };

    OrderTypesSettings.prototype._printOptionsHTML = function(items) {
      var html, i, item, len;
      html = '';
      for (i = 0, len = items.length; i < len; i++) {
        item = items[i];
        html += "<option value='" + item + "'>" + item + "</option>";
      }
      return html;
    };

    OrderTypesSettings.prototype._doorsHTML = function() {
      var html;
      html = "<div class='form-group'> <h5>Vrata</h5> <div class='flex flex-column'> <label>Vrsta vrata</label> <div class='flex flex-row'> <select class='js--door--sort'> " + (this._printOptionsHTML(this.doorSorts)) + " </select> <button class='cbtn btn-danger js--door--sort--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--door--sort--add--value' placeholder='Vrsta vrata'> <button class='cbtn btn-primary js--door--sort--add--button'>Dodaj</button> </div> </div> </div> <div class='form-group'> <div class='flex flex-column'> <label>Staklo</label> <div class='flex flex-row'> <select class='js--door--glass'> " + (this._printOptionsHTML(this.doorGlass)) + " </select> <button class='cbtn btn-danger js--door--glass--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--door--glass--add--value' placeholder='Vrsta stakla'> <button class='cbtn btn-primary js--door--glass--add--button'>Dodaj</button> </div> </div> </div> <div class='form-group'> <div class='flex flex-column'> <label>Tip vrata</label> <div class='flex flex-row'> <select class='js--door--type'> " + (this._printOptionsHTML(this.doorTypes)) + " </select> <button class='cbtn btn-danger js--door--type--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--door--type--add--value' placeholder='Tip vrata'> <button class='cbtn btn-primary js--door--type--add--button'>Dodaj</button> </div> </div> </div>";
      return this.container.find('.js--nav--door--container').html(html);
    };

    OrderTypesSettings.prototype._thresholdHTML = function() {
      var html;
      html = "<div class='form-group'> <h5>Prag</h4> <div class='flex flex-column'> <label>Vrsta praga</label> <div class='flex flex-row'> <select class='js--threshold--sort'> " + (this._printOptionsHTML(this.thresholdSorts)) + " </select> <button class='cbtn btn-danger js--threshold--sort--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--threshold--sort--add--value' placeholder='Vrsta praga'> <button class='cbtn btn-primary js--threshold--sort--add--button'>Dodaj</button> </div> </div> </div>";
      return this.container.find('.js--nav--threshold--container').html(html);
    };

    OrderTypesSettings.prototype._mosquitoHTML = function() {
      var html;
      html = "<div class='form-group'> <h5>Komarnik</h5> <div class='flex flex-column'> <label>Vrsta komarnika</label> <div class='flex flex-row'> <select class='js--mosquito--sort'> " + (this._printOptionsHTML(this.mosquitoSorts)) + " </select> <button class='cbtn btn-danger js--mosquito--sort--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--mosquito--sort--add--value' placeholder='Vrsta komarnika'> <button class='cbtn btn-primary js--mosquito--sort--add--button'>Dodaj</button> </div> </div> </div> <div class='form-group'> <div class='flex flex-column'> <label>Tip komarnika</label> <div class='flex flex-row'> <select class='js--mosquito--type'> " + (this._printOptionsHTML(this.mosquitoTypes)) + " </select> <button class='cbtn btn-danger js--mosquito--type--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--mosquito--type--add--value' placeholder='Tip komarnika'> <button class='cbtn btn-primary js--mosquito--type--add--button'>Dodaj</button> </div> </div> </div>";
      return this.container.find('.js--nav--mosquito--container').html(html);
    };

    OrderTypesSettings.prototype._windowHTML = function() {
      var html;
      html = "<div class='form-group'> <h5>Prozori</h5> <div class='flex flex-column'> <label>Vrsta prozora</label> <div class='flex flex-row'> <select class='js--window--sort'> " + (this._printOptionsHTML(this.windowSorts)) + " </select> <button class='cbtn btn-danger js--window--sort--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--window--sort--add--value' placeholder='Vrsta prozora'> <button class='cbtn btn-primary js--window--sort--add--button'>Dodaj</button> </div> </div> </div> <div class='form-group'> <div class='flex flex-column'> <label>Staklo</label> <div class='flex flex-row'> <select class='js--window--glass'> " + (this._printOptionsHTML(this.windowGlass)) + " </select> <button class='cbtn btn-danger js--window--glass--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--window--glass--add--value' placeholder='Vrsta stakla'> <button class='cbtn btn-primary js--window--glass--add--button'>Dodaj</button> </div> </div> </div>";
      return this.container.find('.js--nav--window--container').html(html);
    };

    OrderTypesSettings.prototype._shutterHTML = function() {
      var html;
      html = "<div class='form-group'> <h5>Roletne</h5> <div class='flex flex-column'> <label>Vrsta roletne</label> <div class='flex flex-row'> <select class='js--shutter--sort'> " + (this._printOptionsHTML(this.shutterSorts)) + " </select> <button class='cbtn btn-danger js--shutter--sort--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--shutter--sort--add--value' placeholder='Vrsta roletne'> <button class='cbtn btn-primary js--shutter--sort--add--button'>Dodaj</button> </div> </div> </div> <div class='form-group'> <div class='flex flex-column'> <label>Vrsta kutije</label> <div class='flex flex-row'> <select class='js--shutter--box--sort'> " + (this._printOptionsHTML(this.shutterBoxSorts)) + " </select> <button class='cbtn btn-danger js--shutter--box--sort--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--shutter--box--sort--add--value' placeholder='Vrsta kutije'> <button class='cbtn btn-primary js--shutter--box--sort--add--button'>Dodaj</button> </div> </div> </div> <div class='form-group'> <div class='flex flex-column'> <label>Tip kutije</label> <div class='flex flex-row'> <select class='js--shutter--box--type'> " + (this._printOptionsHTML(this.shutterBoxTypes)) + " </select> <button class='cbtn btn-danger js--door--sort--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--shutter--box--type--add--value' placeholder='Tip kutije'> <button class='cbtn btn-primary js--shutter--box--type--add--button'>Dodaj</button> </div> </div> </div>";
      return this.container.find('.js--nav--shutter--container').html(html);
    };

    return OrderTypesSettings;

  })(AbstractPage);

}).call(this);
