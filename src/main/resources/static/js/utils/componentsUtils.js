// Generated by CoffeeScript 1.12.7
(function() {
  this.ComponentsUtils = (function() {
    function ComponentsUtils() {}

    ComponentsUtils.CSS_INVALID_INPUT = 'alert-danger';

    ComponentsUtils.POSITIVE_BUTTON = 'js--positive--button';

    ComponentsUtils.NEGATIVE_BUTTON = 'js--negative--button';

    window.closest = function(target, closestTo) {
      return target.closest(closestTo).length > 0;
    };

    window.ajaxCallbackPrintMessage = function(response) {
      return console.log(response.message);
    };

    ComponentsUtils.userDetailsHTML = function() {
      return "<div class='col-7 h-75 pt-5 flex'> <div class='container w-50'> <div class='profile-image h-336'> </div> </div> <div class='container w-50'> <table class='table table-borderless'> <tr> <td>Ime</td> <td class='js--first--name'></td> </tr> <tr> <td>Prezime</td> <td class='js--last--name'></td> </tr> <tr> <td>Ulica</td> <td class='js--street'></td> </tr> <tr> <td>Broj stana</td> <td class='js--build--number'></td> </tr> <tr> <td>Grad</td> <td class='js--city'></td> </tr> <tr> <td>Telefon</td> <td class='js--phone--number'></td> </tr> <tr> <td>Email</td> <td class='js--email'></td> </tr> </table> </div> </div>";
    };

    ComponentsUtils.userDetailsFilledHTML = function(user) {
      return "<div class='col-7 h-75 pt-5 flex'> <div class='container w-50'> <div class='profile-image h-336'> </div> </div> <div class='container w-50'> <table class='table table-borderless'> <tr> <td>Ime</td> <td>" + (user.firstName || '/') + "</td> </tr> <tr> <td>Prezime</td> <td>" + (user.lastName || '/') + "</td> </tr> <tr> <td>Ulica</td> <td>" + (user.street || '/') + "</td> </tr> <tr> <td>Broj stana</td> <td>" + (user.buildNumber || '/') + "</td> </tr> <tr> <td>Grad</td> <td>" + (user.city || '/') + "</td> </tr> <tr> <td>Telefon</td> <td>" + (user.phoneNumber || '/') + "</td> </tr> <tr> <td>Email</td> <td>" + (user.email || '/') + "</td> </tr> </table> </div> </div>";
    };

    ComponentsUtils.emptyState = function(message, innerHtml) {
      if (innerHtml == null) {
        innerHtml = '';
      }
      return "<div class='col-5 m-auto h-75 pt-5 text-center'>" + message + "</div> <div class='pt-3'>" + innerHtml + "</div>";
    };

    ComponentsUtils.loadingPage = function() {
      return "<div class='js--loading--page'><span class='loader-icon'></span></div>";
    };

    ComponentsUtils.getTimeFromMillis = function(millis) {
      var date, day, hour, minutes, month, seconds, year;
      date = new Date(millis);
      year = date.getFullYear();
      month = date.getMonth();
      day = date.getDate();
      hour = date.getHours();
      minutes = date.getMinutes();
      seconds = date.getSeconds();
      return day + "-" + month + "-" + year + " (" + hour + ":" + minutes + ":" + seconds + ")";
    };

    ComponentsUtils.selectFromAutoSuggestion = function(target, input, dataAttribute, array, container) {
      var a, i, id, len, results;
      id = Number(target.attr(dataAttribute));
      results = [];
      for (i = 0, len = array.length; i < len; i++) {
        a = array[i];
        if (a.id === id) {
          input.attr(dataAttribute, id);
          input.val(a.firstName + ' ' + a.lastName);
          container.addClass('hide');
          break;
        } else {
          results.push(void 0);
        }
      }
      return results;
    };

    ComponentsUtils.handleAutoSuggestion = function(input, dataAttribute, array, container, includePhoneNumber) {
      var a, firstName, helpArray, html, i, inputValue, j, k, lastName, len, len1, len2, phoneNumberArray;
      if (includePhoneNumber == null) {
        includePhoneNumber = false;
      }
      inputValue = input.val();
      input.removeAttr(dataAttribute);
      if (inputValue.length < 1) {
        container.addClass('hide');
        return;
      }
      phoneNumberArray = [];
      helpArray = [];
      for (i = 0, len = array.length; i < len; i++) {
        a = array[i];
        inputValue = inputValue.toLowerCase();
        firstName = a.firstName.toLowerCase();
        lastName = a.lastName.toLowerCase();
        if (firstName.startsWith(inputValue) || lastName.startsWith(inputValue)) {
          helpArray.push(a);
        }
        if (includePhoneNumber && a.phoneNumber.startsWith(inputValue)) {
          phoneNumberArray.push(a);
        }
      }
      if (helpArray.length === 0 && phoneNumberArray.length === 0) {
        container.addClass('hide');
        return;
      }
      container.html('');
      if (helpArray.length > 0) {
        html = '';
        for (j = 0, len1 = helpArray.length; j < len1; j++) {
          a = helpArray[j];
          html += "<span class='suggestion-item' " + dataAttribute + "='" + a.id + "'>" + a.firstName + " " + a.lastName + "</span>";
        }
        container.append(html);
      }
      if (phoneNumberArray.length > 0) {
        html = '';
        for (k = 0, len2 = phoneNumberArray.length; k < len2; k++) {
          a = phoneNumberArray[k];
          html += "<span class='suggestion-item' " + dataAttribute + "='" + a.id + "'>" + a.phoneNumber + "</span>";
        }
        container.append(html);
      }
      return container.removeClass('hide');
    };

    return ComponentsUtils;

  })();

}).call(this);
