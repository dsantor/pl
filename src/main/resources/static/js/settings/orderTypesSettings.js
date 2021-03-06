// Generated by CoffeeScript 1.12.7
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.OrderTypesSettings = (function(superClass) {
    extend(OrderTypesSettings, superClass);

    function OrderTypesSettings() {
      OrderTypesSettings.__super__.constructor.call(this);
      this.doorSorts = [];
      this.doorTypes = [];
      this.doorGlass = [];
      this.thresholdSorts = [];
      this.mosquitoSorts = [];
      this.mosquitoTypes = [];
      this.windowSorts = [];
      this.windowGlass = [];
      this.shutterSorts = [];
      this.shutterBoxSorts = [];
      this.shutterBoxTypes = [];
      this.pageHTML();
      SettingsService.getAllOrderTypes(null, this, this._loadedOrderTypes, ajaxCallbackPrintMessage);
      this.confirmationDialog = new ConfirmationDialog(this);
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
      var data, input, items, onTheFlyData, target, type;
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
        data = {
          type: 'DOOR_SORT',
          options: this.doorSorts
        };
        SettingsService.saveOrderTypes(data, null, this, null, null);
        this._doorsHTML();
        return;
      }
      if (closest(target, '.js--door--sort--remove--value')) {
        type = $('.js--door--sort').val();
        items = [];
        onTheFlyData = {
          array: 'doorSorts',
          itemToRemove: type,
          callback: this._doorsHTML,
          context: this,
          settingsType: 'DOOR_SORT'
        };
        this.confirmationDialog.show("Da li ste sigurni da zelite obrisati '" + type + "'?", onTheFlyData);
        return;
      }
      if (closest(target, '.js--door--glass--add--button')) {
        input = $('.js--door--glass--add--value').val().trim();
        this.doorGlass.push(input);
        data = {
          type: 'DOOR_GLASS',
          options: this.doorGlass
        };
        SettingsService.saveOrderTypes(data, null, this, null, null);
        this._doorsHTML();
        return;
      }
      if (closest(target, '.js--door--glass--remove--value')) {
        type = $('.js--door--glass').val();
        onTheFlyData = {
          array: 'doorGlass',
          itemToRemove: type,
          callback: this._doorsHTML,
          context: this,
          settingsType: 'DOOR_GLASS'
        };
        this.confirmationDialog.show("Da li ste sigurni da zelite obrisati '" + type + "'?", onTheFlyData);
        return;
      }
      if (closest(target, '.js--door--type--add--button')) {
        input = $('.js--door--type--add--value').val().trim();
        this.doorTypes.push(input);
        data = {
          type: 'DOOR_TYPE',
          options: this.doorTypes
        };
        SettingsService.saveOrderTypes(data, null, this, null, null);
        this._doorsHTML();
        return;
      }
      if (closest(target, '.js--door--type--remove--value')) {
        type = $('.js--door--type').val();
        onTheFlyData = {
          array: 'doorTypes',
          itemToRemove: type,
          callback: this._doorsHTML,
          context: this,
          settingsType: 'DOOR_TYPE'
        };
        this.confirmationDialog.show("Da li ste sigurni da zelite obrisati '" + type + "'?", onTheFlyData);
        return;
      }
      if (closest(target, '.js--threshold--sort--add--button')) {
        input = $('.js--threshold--sort--add--value').val().trim();
        this.thresholdSorts.push(input);
        data = {
          type: 'THRESHOLD_SORT',
          options: this.thresholdSorts
        };
        SettingsService.saveOrderTypes(data, null, this, null, null);
        this._thresholdHTML();
        return;
      }
      if (closest(target, '.js--threshold--sort--remove--value')) {
        type = $('.js--threshold--sort').val();
        onTheFlyData = {
          array: 'thresholdSorts',
          itemToRemove: type,
          callback: this._thresholdHTML,
          context: this,
          settingsType: 'THRESHOLD_SORT'
        };
        this.confirmationDialog.show("Da li ste sigurni da zelite obrisati '" + type + "'?", onTheFlyData);
        return;
      }
      if (closest(target, '.js--mosquito--sort--add--button')) {
        input = $('.js--mosquito--sort--add--value').val().trim();
        this.mosquitoSorts.push(input);
        data = {
          type: 'MOSQUITO_SORT',
          options: this.mosquitoSorts
        };
        SettingsService.saveOrderTypes(data, null, this, null, null);
        this._mosquitoHTML();
        return;
      }
      if (closest(target, '.js--mosquito--sort--remove--value')) {
        type = $('.js--mosquito--sort').val();
        onTheFlyData = {
          array: 'mosquitoSorts',
          itemToRemove: type,
          callback: this._mosquitoHTML,
          context: this,
          settingsType: 'MOSQUITO_SORT'
        };
        this.confirmationDialog.show("Da li ste sigurni da zelite obrisati '" + type + "'?", onTheFlyData);
        return;
      }
      if (closest(target, '.js--mosquito--type--add--button')) {
        input = $('.js--mosquito--type--add--value').val().trim();
        this.mosquitoTypes.push(input);
        data = {
          type: 'MOSQUITO_TYPE',
          options: this.mosquitoTypes
        };
        SettingsService.saveOrderTypes(data, null, this, null, null);
        this._mosquitoHTML();
        return;
      }
      if (closest(target, '.js--mosquito--type--remove--value')) {
        type = $('.js--mosquito--type').val();
        onTheFlyData = {
          array: 'mosquitoTypes',
          itemToRemove: type,
          callback: this._mosquitoHTML,
          context: this,
          settingsType: 'MOSQUITO_TYPE'
        };
        this.confirmationDialog.show("Da li ste sigurni da zelite obrisati '" + type + "'?", onTheFlyData);
        return;
      }
      if (closest(target, '.js--window--sort--add--button')) {
        input = $('.js--window--sort--add--value').val().trim();
        this.windowSorts.push(input);
        data = {
          type: 'WINDOW_SORT',
          options: this.windowSorts
        };
        SettingsService.saveOrderTypes(data, null, this, null, null);
        this._windowHTML();
        return;
      }
      if (closest(target, '.js--window--sort--remove--value')) {
        type = $('.js--window--sort').val();
        onTheFlyData = {
          array: 'windowSorts',
          itemToRemove: type,
          callback: this._windowHTML,
          context: this,
          settingsType: 'WINDOW_SORT'
        };
        this.confirmationDialog.show("Da li ste sigurni da zelite obrisati '" + type + "'?", onTheFlyData);
        return;
      }
      if (closest(target, '.js--window--glass--add--button')) {
        input = $('.js--window--glass--add--value').val().trim();
        this.windowGlass.push(input);
        data = {
          type: 'WINDOW_GLASS',
          options: this.windowGlass
        };
        SettingsService.saveOrderTypes(data, null, this, null, null);
        this._windowHTML();
        return;
      }
      if (closest(target, '.js--window--glass--remove--value')) {
        type = $('.js--window--glass').val();
        onTheFlyData = {
          array: 'windowGlass',
          itemToRemove: type,
          callback: this._windowHTML,
          context: this,
          settingsType: 'WINDOW_GLASS'
        };
        this.confirmationDialog.show("Da li ste sigurni da zelite obrisati '" + type + "'?", onTheFlyData);
        return;
      }
      if (closest(target, '.js--shutter--sort--add--button')) {
        input = $('.js--shutter--sort--add--value').val().trim();
        this.shutterSorts.push(input);
        data = {
          type: 'SHUTTER_SORT',
          options: this.shutterSorts
        };
        SettingsService.saveOrderTypes(data, null, this, null, null);
        this._shutterHTML();
        return;
      }
      if (closest(target, '.js--shutter--sort--remove--value')) {
        type = $('.js--shutter--sort').val();
        onTheFlyData = {
          array: 'shutterSorts',
          itemToRemove: type,
          callback: this._shutterHTML,
          context: this,
          settingsType: 'SHUTTER_SORT'
        };
        this.confirmationDialog.show("Da li ste sigurni da zelite obrisati '" + type + "'?", onTheFlyData);
        return;
      }
      if (closest(target, '.js--shutter--box--sort--add--button')) {
        input = $('.js--shutter--box--sort--add--value').val().trim();
        this.shutterBoxSorts.push(input);
        data = {
          type: 'SHUTTER_BOX_SORT',
          options: this.shutterBoxSorts
        };
        SettingsService.saveOrderTypes(data, null, this, null, null);
        this._shutterHTML();
        return;
      }
      if (closest(target, '.js--shutter--box--sort--remove--value')) {
        type = $('.js--shutter--box--sort').val();
        onTheFlyData = {
          array: 'shutterBoxSorts',
          itemToRemove: type,
          callback: this._shutterHTML,
          context: this,
          settingsType: 'SHUTTER_BOX_SORT'
        };
        this.confirmationDialog.show("Da li ste sigurni da zelite obrisati '" + type + "'?", onTheFlyData);
        return;
      }
      if (closest(target, '.js--shutter--box--type--add--button')) {
        input = $('.js--shutter--box--type--add--value').val().trim();
        this.shutterBoxTypes.push(input);
        data = {
          type: 'SHUTTER_BOX_TYPE',
          options: this.shutterBoxTypes
        };
        SettingsService.saveOrderTypes(data, null, this, null, null);
        this._shutterHTML();
        return;
      }
      if (closest(target, '.js--shutter--box--type--remove--value')) {
        type = $('.js--shutter--box--type').val();
        onTheFlyData = {
          array: 'shutterBoxTypes',
          itemToRemove: type,
          callback: this._shutterHTML,
          context: this,
          settingsType: 'SHUTTER_BOX_TYPE'
        };
        this.confirmationDialog.show("Da li ste sigurni da zelite obrisati '" + type + "'?", onTheFlyData);
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
      html = "<div class='form-group'> <h5>Roletne</h5> <div class='flex flex-column'> <label>Vrsta roletne</label> <div class='flex flex-row'> <select class='js--shutter--sort'> " + (this._printOptionsHTML(this.shutterSorts)) + " </select> <button class='cbtn btn-danger js--shutter--sort--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--shutter--sort--add--value' placeholder='Vrsta roletne'> <button class='cbtn btn-primary js--shutter--sort--add--button'>Dodaj</button> </div> </div> </div> <div class='form-group'> <div class='flex flex-column'> <label>Vrsta kutije</label> <div class='flex flex-row'> <select class='js--shutter--box--sort'> " + (this._printOptionsHTML(this.shutterBoxSorts)) + " </select> <button class='cbtn btn-danger js--shutter--box--sort--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--shutter--box--sort--add--value' placeholder='Vrsta kutije'> <button class='cbtn btn-primary js--shutter--box--sort--add--button'>Dodaj</button> </div> </div> </div> <div class='form-group'> <div class='flex flex-column'> <label>Tip kutije</label> <div class='flex flex-row'> <select class='js--shutter--box--type'> " + (this._printOptionsHTML(this.shutterBoxTypes)) + " </select> <button class='cbtn btn-danger js--shutter--box--type--remove--value'>Obriši</button> </div> <div class='flex flex-row'> <input type='text' class='form-control js--shutter--box--type--add--value' placeholder='Tip kutije'> <button class='cbtn btn-primary js--shutter--box--type--add--button'>Dodaj</button> </div> </div> </div>";
      return this.container.find('.js--nav--shutter--container').html(html);
    };

    OrderTypesSettings.prototype.confirmationDialogResponse = function(action, onTheFlyData) {
      var data, i, item, items, len, ref;
      if (action) {
        items = [];
        ref = this[onTheFlyData.array];
        for (i = 0, len = ref.length; i < len; i++) {
          item = ref[i];
          if (item !== onTheFlyData.itemToRemove) {
            items.push(item);
          }
        }
        this[onTheFlyData.array] = items;
        onTheFlyData.callback.call(onTheFlyData.context);
        data = {
          type: onTheFlyData.settingsType,
          options: this[onTheFlyData.array]
        };
        return SettingsService.saveOrderTypes(data, null, this, null, null);
      }
    };

    OrderTypesSettings.prototype._loadedOrderTypes = function(response) {
      var data;
      data = response.data;
      this.doorSorts = data['DOOR_SORT'];
      this.doorTypes = data['DOOR_TYPE'];
      this.doorGlass = data['DOOR_GLASS'];
      this.thresholdSorts = data['THRESHOLD_SORT'];
      this.mosquitoSorts = data['MOSQUITO_SORT'];
      this.mosquitoTypes = data['MOSQUITO_TYPE'];
      this.windowSorts = data['WINDOW_SORT'];
      this.windowGlass = data['WINDOW_GLASS'];
      this.shutterSorts = data['SHUTTER_SORT'];
      this.shutterBoxSorts = data['SHUTTER_BOX_SORT'];
      this.shutterBoxTypes = data['SHUTTER_BOX_TYPE'];
      return this.pageHTML();
    };

    return OrderTypesSettings;

  })(AbstractPage);

}).call(this);
