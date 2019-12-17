// Generated by CoffeeScript 1.12.7
(function() {
  this.BidsPage = (function() {
    function BidsPage(clientId) {
      this.clientId = clientId;
      this.client = null;
      this.clients = [];
      this.newClient = null;
      this.worker = null;
      this.workerIds = [];
      this.allWorkers = [];
      this.bidCurrentId = 1;
      this.container = $('.js--page--container');
      this.allowedSaveBidsButton = false;
      this.oldClientIsChosen = true;
      this._renderChoseBidHTML();
      WorkerService.getAll(null, this, this._loadWorkersSuccess, this._loadWorkersError);
      if (this.clientId) {
        ClientService.get(clientId, null, this, this._loadedClientSuccess, this._loadWorkersError);
      } else {
        ClientService.getAll(null, this, this._loadedClientsSuccess, this._loadWorkersError);
      }
      this.bidsContainer = this.container.find('.bids--container');
      this.overviewContainer = this.container.find('.overview--container');
      this.autoSuggestInputs = this.container.find('.js--autosuggest--input');
      this.workerInput = this.container.find('.js--worker--input');
      this.workersChosenContainer = this.container.find('.js--workers--chosen');
      this.workerSuggestionsContainer = this.container.find('.js--worker--suggestions');
      this.clientInput = this.container.find('.js--client--input');
      this.clientSuggestionsContainer = this.container.find('.js--client--suggestions');
      this.saveOrderErrorMessage = this.container.find('.js--order--error--message');
      this.newClientContainer = this.container.find('.js--radio--button--new--client--container');
      this.oldClientContainer = this.container.find('.js--radio--button--old--client--container');
      this.oldClientButton = this.container.find('.js--radio--button--old--client');
      this.newClientButton = this.container.find('.js--radio--button--new--client');
      this.orderStatus = this.container.find('.js--order--status');
      this.firstName = this.container.find('.js--firstName');
      this.lastName = this.container.find('.js--lastName');
      this.street = this.container.find('.js--street');
      this.buildNumber = this.container.find('.js--buildNumber');
      this.city = this.container.find('.js--city');
      this.phoneNumber = this.container.find('.js--phoneNumber');
      this.email = this.container.find('.js--email');
      this.buildDate = this.container.find('.js--build--date');
      this.clickEvent = this._clickEventHandler.bind(this);
      this.container.on('click', this.clickEvent);
      this.autoSuggestInputEvent = this._autoSuggestInputEventHandler.bind(this);
      this.autoSuggestInputs.on('keyup', this.autoSuggestInputEvent);
      this.doorBidDialog = new DoorBidDialog();
      this.thresholdBidDialog = new ThresholdBidDialog();
      this.windowBidDialog = new WindowBidDialog();
      this.shutterBidDialog = new ShutterBidDialog();
      this.mosquitoRepellerBidDialog = new MosquitoRepellerBidDialog();
      this.cartList = {};
    }

    BidsPage.prototype.destroy = function() {
      this.doorBidDialog.destroy();
      this.doorBidDialog = null;
      this.windowBidDialog.destroy();
      this.windowBidDialog = null;
      this.shutterBidDialog.destroy();
      this.shutterBidDialog = null;
      this.thresholdBidDialog.destroy();
      this.thresholdBidDialog = null;
      this.mosquitoRepellerBidDialog.destroy();
      this.mosquitoRepellerBidDialog = null;
      this.container.off('click', this.clickEvent);
      this.clickEvent = null;
      this.autoSuggestInputs.off('keyup', this.autoSuggestInputEvent);
      this.autoSuggestInputEvent = null;
      this.bidsContainer = null;
      this.overviewContainer = null;
      this.autoSuggestInputs = null;
      this.workerSuggestionsContainer = null;
      this.clientInput = null;
      this.clientSuggestionsContainer = null;
      this.buildDate = null;
      this.orderStatus = null;
      this.container.html('');
      this.clientId = null;
      this.client = null;
      this.clients = null;
      this.newClient = null;
      this.worker = null;
      this.workerIds = null;
      this.bidCurrentId = null;
      this.cartList = null;
      this.allowedSaveBidsButton = null;
      this.oldClientIsChosen = null;
      this.firstName = null;
      this.lastName = null;
      this.street = null;
      this.buildNumber = null;
      this.city = null;
      this.phoneNumber = null;
      return this.email = null;
    };

    BidsPage.prototype.getPageTitle = function() {
      return "Porudzbine";
    };

    BidsPage.prototype._renderChoseBidHTML = function() {
      var bodyHTML;
      bodyHTML = "<div class='container bids--container bids-container' data-page='bids'> <nav class='nav header justify-content-end pt-3'> <span class='nav-link span-a js--chose--bids nav--bids active'>Odaberi proizvod</span> <span class='nav-link span-a js--bids--overview nav--overview nav--empty'>Pregled porudzbine</span> <span class='nav-link span-a " + (this._createClientButtonClass()) + " js--chose--client nav--client'>Unesi klijenta</span> <span class='nav-link span-a js--bids--order nav--order'>Poruči</span> </nav> <div class='col-7 m-auto w-100 pt-3 flex flex-column bidsPage' data-page='bids'> <div class='flex flex-row justify-content-center'> <div class='item-order text-center mb-5'> <div class='js--create--door'> <img class='item-order pointer' draggable=false src='/images/door.png'> </div> <label>Vrata</label> </div> <div class='item-order text-center'> <div class='js--create--threshold'> <img class='item-order pointer' draggable=false src='/images/threshold.png'> </div> <label>Prag</label> </div> <div class='item-order text-center'> <div class='js--create--mosquito--repeller'> <img class='item-order pointer' draggable=false src='/images/mosquitoRepeller.png'> </div> <label>Komarnik</label> </div> </div> <div class='flex flex-row justify-content-center'> <div class='item-order text-center mb-5'> <div class='js--create--window'> <img class='item-order pointer' draggable=false src='/images/window.png'> </div> <label>Prozor</label> </div> <div class='item-order text-center'> <div class='js--create--shutter'> <img class='item-order pointer' draggable=false src='/images/shutter.png'> </div> <label>Roletne</label> </div> </div> </div> <div class='bidsClient' data-page='client'> <div class='col-7 m-auto h-75 pt-5 flex'> <div class='form-group w-50'> <div class='container'> <label class='js--radio--button--old--client switch-section active'>Postojeci klijent</label> <div class='js--radio--button--old--client--container'> <input type='text' class='form-control js--autosuggest--input js--client--input' placeholder='klijent'> <div class='suggestion-container js--client--suggestions hide'> </div> </div> </div> </div> </div> <div class='col-7 m-auto h-75 pt-5 flex'> <div class='container'> <label class='js--radio--button--new--client switch-section'>Kreiraj klijenta</label> </div> </div> <div class='col-7 m-auto h-75 flex js--radio--button--new--client--container disabled'> <div class='container w-50'> <div class='form-group'> <label>Email</label> <input type='email' class='form-control js--email' placeholder='email'/> </div> <div class='form-group'> <label>Ime*</label> <input type='text' class='form-control js--firstName' placeholder='ime'/> </div> <div class='form-group'> <label>Prezime*</label> <input type='text' class='form-control js--lastName' placeholder='prezime'/> </div> <div class='form-group'> <label>Ulica</label> <input type='text' class='form-control js--street' placeholder='ulica'/> </div> </div> <div class='container w-50'> <div class='form-group'> <label>Broj stana</label> <input type='text' class='form-control js--buildNumber' placeholder='broj kuce/stana'/> </div> <div class='form-group'> <label>Grad</label> <input type='text' class='form-control js--city' placeholder='grad'/> </div> <div class='form-group'> <label>Telefon*</label> <input type='tel' class='form-control js--phoneNumber' placeholder='telefon'/> </div> </div> </div> </div> <div class='pt-3 flex flex-column overview--container bidsOverview' data-page='overview'></div> <div class='pt-3 flex flex-column bidsEmptyState' data-page='empty'> " + (BidSectionsHTML.emptyState()) + " </div> <div class='col-7 m-auto p-5 flex bidsOrder' data-page='order'> <div class='container container-padding w-50'> <div class='form-group'> <label>Datum ugradnje</label> <input type='date' class='form-control js--build--date'> </div> <div class='form-group'> <label>Status porudzbine</label> <select class='js--order--status'> <option value='WAITING' selected>Na čekanju</option> <option value='ACCEPTED'>Prihvaćen</option> <option value='DECLINED'>Odbijen</option> </select> </div> <div class='form-group'> <label>Radnik</label> <input type='text' hidden='hidden'> <input type='text' class='form-control js--autosuggest--input js--worker--input' placeholder='radnik'> <div class='suggestion-container js--worker--suggestions hide'> </div> <div class='mt-3 js--workers--chosen'> </div> </div> <div style='color:red;'>Allow user to chose status of order</div> <div class='form-group'> <button class='btn btn-lg btn-primary btn-block js--save--order'>Poruči</button> <span class='text-danger js--order--error--message hide'> </span> </div> </div> </div> </div>";
      return this.container.html(bodyHTML);
    };

    BidsPage.prototype._clickEventHandler = function(event) {
      var target;
      target = $(event.target);
      if (closest(target, ".js--create--door")) {
        this.doorBidDialog.show(this);
        return;
      }
      if (closest(target, ".js--create--threshold")) {
        this.thresholdBidDialog.show(this);
        return;
      }
      if (closest(target, ".js--create--mosquito--repeller")) {
        this.mosquitoRepellerBidDialog.show(this);
        return;
      }
      if (closest(target, ".js--create--window")) {
        this.windowBidDialog.show(this);
        return;
      }
      if (closest(target, ".js--create--shutter")) {
        this.shutterBidDialog.show(this);
        return;
      }
      if (closest(target, '.js--bids--overview')) {
        this._showBids();
        return;
      }
      if (closest(target, '.js--chose--bids')) {
        this._activePage('bids');
        return;
      }
      if (closest(target, '.js--chose--client')) {
        this._activePage('client');
        return;
      }
      if (closest(target, '.js--bids--order')) {
        this.saveOrderErrorMessage.addClass('hide');
        this._activePage('order');
        return;
      }
      if (closest(target, '.js--remove--bid')) {
        this._removeBid(target);
        return;
      }
      if (closest(target, '.js--edit--bid')) {
        this._editBid(target);
        return;
      }
      if (closest(target, '.js--worker--suggestions')) {
        this._selectWorkerFromAutoSuggestion(target);
        return;
      }
      if (closest(target, '.js--client--suggestions')) {
        this._selectClientFromAutoSuggestion(target);
        return;
      }
      if (closest(target, '.js--save--order')) {
        this._saveOrder();
        return;
      }
      if (closest(target, '.js--radio--button--old--client')) {
        this._setNewClientContainer(false);
        return;
      }
      if (closest(target, '.js--radio--button--new--client')) {
        this._setNewClientContainer(true);
        return;
      }
      if (closest(target, '.remove--worker')) {
        this._removeWorkerFromSelectedList(target);
      }
    };

    BidsPage.prototype._setNewClientContainer = function(newClient) {
      if (newClient) {
        this.newClientContainer.removeClass('disabled');
        this.oldClientContainer.addClass('disabled');
        this.oldClientButton.removeClass('active');
        this.newClientButton.addClass('active');
        return this.oldClientIsChosen = false;
      } else {
        this.oldClientContainer.removeClass('disabled');
        this.newClientContainer.addClass('disabled');
        this.newClientButton.removeClass('active');
        this.oldClientButton.addClass('active');
        return this.oldClientIsChosen = true;
      }
    };

    BidsPage.prototype._autoSuggestInputEventHandler = function(event) {
      var target;
      target = $(event.target);
      if (closest(target, '.js--worker--input')) {
        this._workerAutoSuggestion();
        return;
      }
      if (closest(target, '.js--client--input')) {
        this._clientAutoSuggestion();
      }
    };

    BidsPage.prototype._workerAutoSuggestion = function() {
      var firstName, html, i, input, j, lastName, len, len1, ref, w, worker, workers;
      input = this.workerInput.val();
      if (input.length < 1) {
        this.workerSuggestionsContainer.addClass('hide');
        return;
      }
      workers = [];
      ref = this.allWorkers;
      for (i = 0, len = ref.length; i < len; i++) {
        w = ref[i];
        input = input.toLowerCase();
        firstName = w.firstName.toLowerCase();
        lastName = w.lastName.toLowerCase();
        if (firstName.startsWith(input) || lastName.startsWith(input)) {
          workers.push(w);
        }
      }
      if (workers.length > 0) {
        html = '';
        for (j = 0, len1 = workers.length; j < len1; j++) {
          worker = workers[j];
          html += "<span class='suggestion-item' data-worker-id='" + worker.id + "'>" + worker.firstName + " " + worker.lastName + "</span>";
        }
        this.workerSuggestionsContainer.html(html);
        return this.workerSuggestionsContainer.removeClass('hide');
      } else {
        return this.workerSuggestionsContainer.addClass('hide');
      }
    };

    BidsPage.prototype._clientAutoSuggestion = function() {
      var client, clients, firstName, html, i, input, j, k, lastName, len, len1, len2, phoneNumber, phoneNumbers, ref;
      input = this.clientInput.val();
      if (input.length < 1) {
        this.clientSuggestionsContainer.addClass('hide');
        return;
      }
      clients = [];
      phoneNumbers = [];
      ref = this.clients;
      for (i = 0, len = ref.length; i < len; i++) {
        client = ref[i];
        input = input.toLowerCase();
        firstName = client.firstName.toLowerCase();
        lastName = client.lastName.toLowerCase();
        if (firstName.startsWith(input) || lastName.startsWith(input)) {
          clients.push(client);
        } else if (client.phoneNumber.startsWith(input)) {
          phoneNumbers.push(client);
        }
      }
      html = '';
      if (clients.length > 0) {
        for (j = 0, len1 = clients.length; j < len1; j++) {
          client = clients[j];
          html += "<span class='suggestion-item' data-client-id='" + client.id + "'>" + client.firstName + " " + client.lastName + "</span>";
        }
      }
      if (phoneNumbers.length > 0) {
        for (k = 0, len2 = phoneNumbers.length; k < len2; k++) {
          phoneNumber = phoneNumbers[k];
          html += "<span class='suggestion-item' data-client-id='" + phoneNumber.id + "'>" + phoneNumber.phoneNumber + "</span>";
        }
      }
      if (clients.length > 0 || phoneNumbers.length > 0) {
        this.clientSuggestionsContainer.html(html);
        return this.clientSuggestionsContainer.removeClass('hide');
      } else {
        return this.clientSuggestionsContainer.addClass('hide');
      }
    };

    BidsPage.prototype._activePage = function(page) {
      this.bidsContainer.attr('data-page', page);
      this.bidsContainer.find('.nav-link').removeClass('active');
      return this.bidsContainer.find(".nav--" + page).addClass('active');
    };

    BidsPage.prototype._editBid = function(element) {
      var bidId, bidRow, bidType, data, i, item, len, ref;
      bidId = Number(element.attr('data-bid-id'));
      bidRow = $(".js--bid--row[data-bid-id='" + bidId + "']");
      bidType = bidRow.attr('data-bid-type');
      data = null;
      ref = this.cartList[bidType];
      for (i = 0, len = ref.length; i < len; i++) {
        item = ref[i];
        if (item.id === bidId) {
          data = item;
          break;
        }
      }
      return this._openEditDialog(bidType, data);
    };

    BidsPage.prototype._openEditDialog = function(bidType, data) {
      switch (bidType) {
        case DoorBidDialog.BID_TYPE:
          this.doorBidDialog.show(this, data);
          break;
        case ThresholdBidDialog.BID_TYPE:
          this.thresholdBidDialog.show(this, data);
          break;
        case MosquitoRepellerBidDialog.BID_TYPE:
          this.mosquitoBidDialog.show(this, data);
          break;
        case WindowBidDialog.BID_TYPE:
          this.windowBidDialog.show(this, data);
          break;
        case ShutterBidDialog.BID_TYPE:
          this.shutterBidDialog.show(this, data);
          break;
        default:
          return console.log('Dialog is not supported');
      }
    };

    BidsPage.prototype._removeBid = function(target) {
      var bid, bidId, bidRow, bidType, i, index, len, ref;
      bidId = Number(target.attr('data-bid-id'));
      bidRow = $(".js--bid--row[data-bid-id='" + bidId + "']");
      bidType = bidRow.attr('data-bid-type');
      bidRow.remove();
      ref = this.cartList[bidType];
      for (index = i = 0, len = ref.length; i < len; index = ++i) {
        bid = ref[index];
        if (bid.id === bidId) {
          this.cartList[bidType].splice(index, 1);
          break;
        }
      }
      return this._updateResultSections();
    };

    BidsPage.prototype._updateResultSections = function() {
      var i, key, keyLowecase, keys, len, sectionName;
      keys = Object.keys(this.cartList);
      for (i = 0, len = keys.length; i < len; i++) {
        key = keys[i];
        if (this.cartList[key].length === 0) {
          keyLowecase = key.toLowerCase();
          sectionName = ".js--section--" + keyLowecase;
          $(sectionName).remove();
          delete this.cartList[key];
        }
      }
      keys = Object.keys(this.cartList);
      if (keys.length === 0) {
        this.allowedSaveBidsButton = false;
        return this._activePage('empty');
      }
    };

    BidsPage.prototype._getClientIdFromURL = function() {
      var hash;
      hash = window.location.hash;
      return hash.substring(hash.indexOf('/'));
    };

    BidsPage.prototype.bidDialogResult = function(data) {
      this.allowedSaveBidsButton = true;
      $('.js--save--bids').removeClass('disabled');
      if (this.cartList[data.bidType] === void 0) {
        this.cartList[data.bidType] = [];
      }
      if (data.id === null) {
        return this._addItemToCartList(data);
      } else {
        return this._updateItemFromCartList(data);
      }
    };

    BidsPage.prototype._addItemToCartList = function(data) {
      data.id = this.bidCurrentId++;
      return this.cartList[data.bidType].push(data);
    };

    BidsPage.prototype._updateItemFromCartList = function(data) {
      var i, index, item, len, ref;
      ref = this.cartList[data.bidType];
      for (index = i = 0, len = ref.length; i < len; index = ++i) {
        item = ref[index];
        if (item.id === data.id) {
          this.cartList[data.bidType][index] = data;
          break;
        }
      }
      return this._showBids();
    };

    BidsPage.prototype._showBids = function() {
      var html, i, key, keys, len;
      keys = Object.keys(this.cartList);
      if (keys.length === 0) {
        this.allowedSaveBidsButton = false;
        this._activePage('empty');
        return;
      }
      html = '';
      for (i = 0, len = keys.length; i < len; i++) {
        key = keys[i];
        if (this.cartList[key].length > 0) {
          html += this._renderOverviewBidSection(key);
        }
      }
      this.overviewContainer.html(html);
      return this._activePage('overview');
    };

    BidsPage.prototype._renderOverviewBidSection = function(bidType) {
      switch (bidType) {
        case DoorBidDialog.BID_TYPE:
          return BidSectionsHTML.doorSectionHTML(this.cartList[bidType]);
        case ThresholdBidDialog.BID_TYPE:
          return BidSectionsHTML.thresholdSectionHTML(this.cartList[bidType]);
        case MosquitoRepellerBidDialog.BID_TYPE:
          return BidSectionsHTML.mosquitoRepellerSectionHTML(this.cartList[bidType]);
        case WindowBidDialog.BID_TYPE:
          return BidSectionsHTML.windowSectionHTML(this.cartList[bidType]);
        case ShutterBidDialog.BID_TYPE:
          return BidSectionsHTML.shutterSectionHTML(this.cartList[bidType]);
        default:
          return '';
      }
    };

    BidsPage.prototype._createClientButtonClass = function() {
      if (this.clientId) {
        return 'disabled';
      } else {
        return '';
      }
    };

    BidsPage.prototype._loadWorkersSuccess = function(response) {
      return this.allWorkers = response.data;
    };

    BidsPage.prototype._loadWorkersError = function(response) {
      return console.log(response.message);
    };

    BidsPage.prototype._selectWorkerFromAutoSuggestion = function(target) {
      var addHtml, i, id, len, ref, worker, workerHTML;
      id = Number(target.attr('data-worker-id'));
      addHtml = false;
      ref = this.allWorkers;
      for (i = 0, len = ref.length; i < len; i++) {
        worker = ref[i];
        if (worker.id === id) {
          if (!this.workerIds.includes(id)) {
            this.workerIds.push(worker.id);
            addHtml = true;
          }
          break;
        }
      }
      if (addHtml) {
        workerHTML = "<div class='w-100 br-8 nav-link nav-tabs border remove--worker--container' data-worker-id='" + id + "'> <span>" + (worker.firstName + ' ' + worker.lastName.charAt(0)) + "</span> <span class='remove-icon close remove--worker'> </span> </div>";
        this.workersChosenContainer.append(workerHTML);
      }
      this.workerInput.val('');
      return this.workerSuggestionsContainer.addClass('hide');
    };

    BidsPage.prototype._removeWorkerFromSelectedList = function(target) {
      var i, id, len, ref, results, worker;
      id = Number(target.closest('.remove--worker--container').attr('data-worker-id'));
      ref = this.allWorkers;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        worker = ref[i];
        if (worker.id === id) {
          this.allWorkers.splice(worker, 1);
          $(".remove--worker--container[data-worker-id='" + id + "']").remove();
          break;
        } else {
          results.push(void 0);
        }
      }
      return results;
    };

    BidsPage.prototype._selectClientFromAutoSuggestion = function(target) {
      var client, i, id, len, ref;
      id = Number(target.attr('data-client-id'));
      ref = this.clients;
      for (i = 0, len = ref.length; i < len; i++) {
        client = ref[i];
        if (client.id === id) {
          this.client = client;
          break;
        }
      }
      this.clientInput.val(this.client.firstName + ' ' + this.client.lastName);
      return this.clientSuggestionsContainer.addClass('hide');
    };

    BidsPage.prototype._loadedClientSuccess = function(response) {
      return this.client = response.data;
    };

    BidsPage.prototype._loadedClientsSuccess = function(response) {
      return this.clients = response.data;
    };

    BidsPage.prototype._saveOrder = function() {
      var buildDate, buildNumber, city, clientId, data, email, firstName, keys, lastName, newClient, phoneNumber, street, valid;
      keys = Object.keys(this.cartList);
      if (keys.length === 0) {
        this.saveOrderErrorMessage.html('Korpa je prazna!').removeClass('hide');
        return;
      }
      clientId = null;
      newClient = null;
      if (this.oldClientIsChosen) {
        if (this.client === null) {
          this.saveOrderErrorMessage.html('Klijent nije odabran!').removeClass('hide');
          return;
        }
        clientId = this.client.id;
      } else {
        valid = true;
        firstName = this.firstName.val().trim();
        lastName = this.lastName.val().trim();
        street = this.street.val().trim();
        buildNumber = this.buildNumber.val().trim();
        city = this.city.val().trim();
        phoneNumber = this.phoneNumber.val().trim();
        email = this.email.val().trim();
        if (firstName === '') {
          this.firstName.addClass(ComponentsUtils.CSS_INVALID_INPUT);
          valid = false;
        } else {
          this.firstName.removeClass(ComponentsUtils.CSS_INVALID_INPUT);
        }
        if (lastName === '') {
          this.lastName.addClass(ComponentsUtils.CSS_INVALID_INPUT);
          valid = false;
        } else {
          this.lastName.removeClass(ComponentsUtils.CSS_INVALID_INPUT);
        }
        if (Validation.phone(phoneNumber)) {
          this.phoneNumber.removeClass(ComponentsUtils.CSS_INVALID_INPUT);
        } else {
          valid = false;
          this.phoneNumber.addClass(ComponentsUtils.CSS_INVALID_INPUT);
        }
        if (!valid) {
          return;
        } else {
          newClient = {
            firstName: firstName,
            lastName: lastName,
            street: street,
            buildNumber: buildNumber,
            city: city,
            phoneNumber: phoneNumber,
            email: email
          };
        }
      }
      if (this.workerIds.length === 0) {
        this.saveOrderErrorMessage.html('Radnik nije odabran!').removeClass('hide');
        return;
      }
      if (this.buildDate.val() === '') {
        this.saveOrderErrorMessage.html('Vreme ugradnje nije odabrano!').removeClass('hide');
        return;
      }
      this.saveOrderErrorMessage.addClass('hide');
      buildDate = new Date(this.buildDate.val()).getTime();
      data = {
        doors: this.cartList[DoorBidDialog.BID_TYPE],
        thresholds: this.cartList[ThresholdBidDialog.BID_TYPE],
        mosquitos: this.cartList[MosquitoRepellerBidDialog.BID_TYPE],
        windows: this.cartList[WindowBidDialog.BID_TYPE],
        shutters: this.cartList[ShutterBidDialog.BID_TYPE],
        clientId: clientId,
        createClient: newClient,
        workerIds: this.workerIds,
        buildDate: buildDate,
        oldClientIsChosen: this.oldClientIsChosen,
        orderStatus: this.orderStatus.val()
      };
      return OrderService.create(data, null, this, this._orderSavedSuccess, this._loadWorkersError);
    };

    BidsPage.prototype._orderSavedSuccess = function(response) {
      return console.log(response);
    };

    return BidsPage;

  })();

}).call(this);
