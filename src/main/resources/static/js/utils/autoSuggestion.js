// Generated by CoffeeScript 1.12.7
(function() {
  this.AutoSuggestion = (function() {
    AutoSuggestion.BASE_FILTER = 'base_filter';

    AutoSuggestion.ORDER_FILTER = 'order_filter';

    AutoSuggestion.EXPENSE_FILTER = 'expense_filter';

    function AutoSuggestion(parentPage, container, filterType, status) {
      this.parentPage = parentPage;
      this.container = container;
      this.status = status;
      this.container.html(this._getHTMLByFilterType(filterType));
      this.filterToggleButton = this.container.find('.js--filters--content');
      this.filterSuggestionsContainer = this.container.find('.js--filter--suggestions');
      this.keyupEvent = this._keyupEventHandler.bind(this);
      this.container.on('keyup', this.keyupEvent);
      this.clickEvent = this._clickEventHandler.bind(this);
      this.container.on('click', this.clickEvent);
      this.changeEvent = this._changeEventHander.bind(this);
      this.container.on('change', this.changeEvent);
    }

    AutoSuggestion.prototype.destroy = function() {
      this.container.off('keyup', this.keyupEvent);
      this.keyupEvent = null;
      this.container.off('click', this.clickEvent);
      this.clickEvent = null;
      this.container.off('change', this.changeEvent);
      this.changeEvent = null;
      this.container = null;
      this.parentPage = null;
      this.filterToggleButton = null;
      this.filterSuggestionsContainer = null;
      return this.status = null;
    };

    AutoSuggestion.prototype._keyupEventHandler = function(event) {
      var base, base1, base2, base3, target;
      target = $(event.target);
      if (closest(target, '.js--filter--as')) {
        if (typeof (base = this.parentPage).triggerFilterAs === "function") {
          base.triggerFilterAs(event);
        }
        return;
      }
      if (closest(target, '.js--filter--sum--from')) {
        if (typeof (base1 = this.parentPage).triggerFiterSumFrom === "function") {
          base1.triggerFiterSumFrom();
        }
        return;
      }
      if (closest(target, '.js--filter--sum--to')) {
        if (typeof (base2 = this.parentPage).triggerFiterSumTo === "function") {
          base2.triggerFiterSumTo();
        }
        return;
      }
      return typeof (base3 = this.parentPage).AutoSuggestionKeyUpEventHander === "function" ? base3.AutoSuggestionKeyUpEventHander(event) : void 0;
    };

    AutoSuggestion.prototype._changeEventHander = function(event) {
      var base, base1, base2, base3, target;
      target = $(event.target);
      if (closest(target, '.js--filter--status')) {
        if (typeof (base = this.parentPage).triggerFilterStatus === "function") {
          base.triggerFilterStatus(event);
        }
        return;
      }
      if (closest(target, '.js--filter--from')) {
        if (typeof (base1 = this.parentPage).triggerFilterFrom === "function") {
          base1.triggerFilterFrom(event);
        }
        return;
      }
      if (closest(target, '.js--filter--to')) {
        if (typeof (base2 = this.parentPage).triggerFilterTo === "function") {
          base2.triggerFilterTo(event);
        }
        return;
      }
      return typeof (base3 = this.parentPage).AutoSuggestionChangeEventHander === "function" ? base3.AutoSuggestionChangeEventHander(event) : void 0;
    };

    AutoSuggestion.prototype._clickEventHandler = function(event) {
      var base, base1, base2, target;
      target = $(event.target);
      if (closest(target, '.js--filters--button')) {
        this.filterToggleButton.toggleClass('show');
        return;
      }
      if (closest(target, '.js--filter--suggestions')) {
        if (typeof (base = this.parentPage).triggerFilterSuggestions === "function") {
          base.triggerFilterSuggestions(event);
        }
        return;
      }
      if (closest(target, '.js--filter--reset')) {
        if (typeof (base1 = this.parentPage).triggerFilterReset === "function") {
          base1.triggerFilterReset(event);
        }
        return;
      }
      this.filterSuggestionsContainer.addClass('hide');
      return typeof (base2 = this.parentPage).AutoSuggestionClickEventHander === "function" ? base2.AutoSuggestionClickEventHander(event) : void 0;
    };

    AutoSuggestion.prototype.triggerFilterAs = function(event) {};

    AutoSuggestion.prototype.triggerFilterSuggestions = function(event) {};

    AutoSuggestion.prototype.triggerFilterStatus = function(event) {};

    AutoSuggestion.prototype.triggerFilterReset = function(event) {};

    AutoSuggestion.prototype._getHTMLByFilterType = function(filterType) {
      switch (filterType) {
        case AutoSuggestion.BASE_FILTER:
          return this._baseFilter();
        case AutoSuggestion.ORDER_FILTER:
          return this._orderFilter();
        case AutoSuggestion.EXPENSE_FILTER:
          return this._expenseFilter();
        default:
          return console.log('ops ops');
      }
    };

    AutoSuggestion.prototype.emptyState = function() {
      return "<div class='col-5 m-auto h-75 pt-5 text-center'>Prazna pretraga :(</div>";
    };

    AutoSuggestion.prototype._baseFilter = function() {
      return this._filterWrapperHTML(this._filterBaseHTML());
    };

    AutoSuggestion.prototype._orderFilter = function() {
      return this._filterWrapperHTML(this._filterOrderHTML());
    };

    AutoSuggestion.prototype._expenseFilter = function() {
      return this._filterWrapperHTML(this._expenseOrderHTML());
    };

    AutoSuggestion.prototype._filterWrapperHTML = function(innerHtml) {
      return "<div class='card-header card bp-4'> <h2 class='mb-0 text-center'> <span  class='span-a btn pointer m-auto js--filters--button' data-toggle='collapse' data-target='#collapseOne'>Filteri</span> </h2> </div> <div id='collapseOne' class='collapse card js--filters--content'> <div class='card-body w-75 m-auto flex'> " + innerHtml + " </div> </div> </div> </div>";
    };

    AutoSuggestion.prototype._applyStatus = function() {
      var index, length, statusHTML;
      statusHTML = '';
      if (this.status) {
        index = 1;
        length = this.status.length;
        statusHTML += "<option value='" + this.status[0].key + "' selected>" + this.status[0].value + "</option>";
        while (index < length) {
          statusHTML += "<option value='" + this.status[index].key + "'>" + this.status[index].value + "</option>";
          index++;
        }
      } else {
        statusHTML = " <option value='all' selected>Svi</option> <option value='active'>Zaposlen</option> <option value='deactive'>Otpušten</option>";
      }
      return statusHTML;
    };

    AutoSuggestion.prototype._filterBaseHTML = function() {
      return "<div class='flex-column w-100'> <div class='flex flex-row justify-content-around pb-3'> <div class='flex flex-row w-40'> <label class='flex mr-2 mb-0 align-self-center w-fit-content'>Pretraži</label> <div class='pos-rel w-100 mb-2'> <input type='text' class='form-control w-100 input-icon-icon-24 js--filter--as'/> <i class='input-icon-24 search-icon cursor-initial'></i> <div class='suggestion-container js--filter--suggestions pos-abs hide'></div> </div> </div> <div class='flex flex-row w-40 mb-2'> <label class='mr-2 mb-0 align-self-center wc-10'>Status</label> <select class='js--change js--filter--status'> " + (this._applyStatus()) + " </select> </div> </div> <div class='w-100 flex justify-content-center'> <input type='button' class='btn btn-primary js--filter--reset' value='Reset filter'/> </div> </div>";
    };

    AutoSuggestion.prototype._filterOrderHTML = function() {
      return "<div class='flex-column w-100'> <div class='flex flex-row justify-content-around pb-3'> <div class='flex flex-column w-40'> <label class='w-100 d-inline-block'>Ugradnja u opsegu</label> <div class='flex flex-row w-100 mb-2'> <label class='flex mr-2 mb-0 align-self-center'>Od</label> <input type='date' class='form-control flex w-100 js--filter--from'/> </div> <div class='flex w-100'> <label class='flex mr-2 mb-0 align-self-center'>Do</label> <input type='date' class='form-control flex w-100 js--filter--to'/> </div> </div> <div class='flex flex-row align-items-center mb-2 w-40'> <label class='mr-2 wc-10 mb-0 align-self-center'>Status</label> <select class='form-control js--change js--filter--status'> " + (this._applyStatus()) + " </select> </div> </div> <div class='w-100 flex justify-content-center'> <input type='button' class='btn btn-primary js--filter--reset' value='Restart filter'/> </div> </div>";
    };

    AutoSuggestion.prototype._expenseOrderHTML = function() {
      return "<div class='flex-column w-100'> <div class='flex flex-row justify-content-around pb-3'> <div class='flex flex-column w-40'> <div class='flex flex-row w-100'> <label class='flex mr-2 mb-0 align-self-center w-fit-content'>Pretraži</label> <div class='pos-rel w-100 mb-2'> <input type='text' class='form-control w-100 input-icon-icon-24 js--filter--as'/> <i class='input-icon-24 search-icon cursor-initial'></i> <div class='suggestion-container js--filter--suggestions pos-abs hide'></div> </div> </div> <label class='w-100 d-inline-block'>Pare izručene</label> <div class='flex flex-row w-100 mb-2'> <label class='flex mr-2 mb-0 align-self-center'>Od</label> <input type='date' class='form-control flex w-100 js--filter--from'/> </div> <div class='flex w-100'> <label class='flex mr-2 mb-0 align-self-center'>Do</label> <input type='date' class='form-control flex w-100 js--filter--to'/> </div> </div> <div class='flex flex-column w-40 align-self-end'> <div class='flex flex-column w-100'> <label class='w-100 d-inline-block'>Iznos novca</label> <div class='flex flex-row w-100 mb-2'> <label class='flex mr-2 mb-0 align-self-center'>Od</label> <input type='number' class='form-control flex w-100 js--filter--sum--from'/> </div> <div class='flex w-100'> <label class='flex mr-2 mb-0 align-self-center'>Do</label> <input type='number' class='form-control flex w-100 js--filter--sum--to'/> </div> </div> </div> </div> <div class='w-100 flex justify-content-center'> <input type='button' class='btn btn-primary js--filter--reset' value='Restart filter'/> </div> </div>";
    };

    return AutoSuggestion;

  })();

}).call(this);
