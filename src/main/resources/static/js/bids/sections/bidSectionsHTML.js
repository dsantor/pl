// Generated by CoffeeScript 1.12.7
(function() {
  this.BidSectionsHTML = (function() {
    function BidSectionsHTML() {}

    BidSectionsHTML.doorSectionHTML = function(items) {
      var dimension, html, i, innerHtml, item, len;
      innerHtml = "";
      for (i = 0, len = items.length; i < len; i++) {
        item = items[i];
        dimension = '/';
        if (item.doorWidth && item.doorHeight && item.doorInnerWidth) {
          dimension = item.doorWidth + 'x' + item.doorHeight + 'x' + item.doorInnerWidth;
        }
        innerHtml += "<tr class='js--bid--row' data-bid-id=" + item.id + " data-bid-type=" + item.bidType + "> <td class='table-text w-15'>" + item.doorSort + "</td> <td class='table-text w-15'>" + item.doorType + "</td> <td class='table-text w-10'>" + item.doorOpenSide + "</td> <td class='table-text w-10'>" + item.doorGlass + "</td> <td class='table-text w-10'>" + dimension + "</td> <td class='table-text w-10'>" + item.doorCount + "</td> <td class='table-text w-10'> <span class='edit-icon js--show--client' data-bid-id=" + item.id + "></span> </td> <td class='table-text w-10'> <span class='remove-icon js--remove--bid' data-bid-id=" + item.id + "></span> </td> </tr>";
      }
      html = "<div class='container'><h4>Vrata</h4></div> <table class='table mb-0'> <tr> <th class='table-text w-15'>Vrsta</th> <th class='table-text w-15'>Tip</th> <th class='table-text w-10'>Otvor</th> <th class='table-text w-10'>Staklo</th> <th class='table-text w-10'>Dimenzije</th> <th class='table-text w-10'>Količina</th> <th class='table-text w-10'>Izmeni</th> <th class='table-text w-10'>Obriši</th> </tr> </table> <table class='table table-striped'> " + innerHtml + " </table>";
      return html;
    };

    BidSectionsHTML.thresholdSectionHTML = function(items) {
      var html, i, innerHtml, item, len;
      innerHtml = '';
      for (i = 0, len = items.length; i < len; i++) {
        item = items[i];
        innerHtml += "<tr class='js--bid--row' data-bid-id=" + item.id + " data-bid-type=" + item.bidType + "> <td class='table-text w-20'>" + item.sort + "</td> <td class='table-text w-20'>" + (item.width || '/') + "</td> <td class='table-text w-10'>" + (item.height || '/') + "</td> <td class='table-text w-20'>" + (item.innerWidth || '/') + "</td> <td class='table-text w-10'>" + item.count + "</td> <td class='table-text w-10'> <span class='edit-icon js--edit--bid' data-bid-id=" + item.id + "></span> </td> <td class='table-text w-10'> <span class='remove-icon js--remove--bid' data-bid-id=" + item.id + "></span> </td> </tr>";
      }
      html = "<div class='container'><h4>Prag</h4></div> <table class='table mb-0'> <tr> <th class='table-text w-20'>Vrsta</th> <th class='table-text w-20'>Širina</th> <th class='table-text w-10'>Visina</th> <th class='table-text w-20'>Unutrašnja širina</th> <th class='table-text w-10'>Količina</th> <th class='table-text w-10'>Promeni</th> <th class='table-text w-10'>Obriši</th> </tr> </table> <table class='table table-striped'> " + innerHtml + " </table>";
      return html;
    };

    BidSectionsHTML.mosquitoRepellerSectionHTML = function(items) {
      var dimension, html, i, innerHtml, item, len;
      innerHtml = '';
      for (i = 0, len = items.length; i < len; i++) {
        item = items[i];
        dimension = '/';
        if (item.width && item.height && item.innerWidth) {
          dimension = item.width + 'x' + item.height + 'x' + item.innerWidth;
        }
        innerHtml += "<tr class='js--bid--row' data-bid-id=" + item.id + " data-bid-type=" + item.bidType + "> <td class='table-text w-20'>" + item.sort + "</td> <td class='table-text w-20'>" + item.type + "</td> <td class='table-text w-20'>" + item.openSide + "</td> <td class='table-text w-10'>" + dimension + "</td> <td class='table-text w-10'>" + item.count + "</td> <td class='table-text w-10'> <span class='edit-icon js--show--client' data-bid-id=" + item.id + "></span> </td> <td class='table-text w-10'> <span class='remove-icon js--remove--bid' data-bid-id=" + item.id + "></span> </td> </tr>";
      }
      html = "<div class='container'><h4>Komarnik</h4></div> <table class='table mb-0'> <tr> <th class='table-text w-20'>Vrsta</th> <th class='table-text w-20'>Tip</th> <th class='table-text w-20'>Otvor</th> <th class='table-text w-10'>Dimenzije</th> <th class='table-text w-10'>Količina</th> <th class='table-text w-10'>Izmeni</th> <th class='table-text w-10'>Obriši</th> </tr> </table> <table class='table table-striped pt-3'> " + innerHtml + " </table>";
      return html;
    };

    BidSectionsHTML.windowSectionHTML = function(items) {
      var dimension, html, i, innerHtml, item, len;
      innerHtml = '';
      for (i = 0, len = items.length; i < len; i++) {
        item = items[i];
        dimension = '/';
        if (item.width && item.height && item.innerWidth) {
          dimension = item.width + 'x' + item.height + 'x' + item.innerWidth;
        }
        innerHtml += "<tr class='js--bid--row' data-bid-id=" + item.id + " data-bid-type=" + item.bidType + "> <td class='table-text w-20'>" + item.sort + "</td> <td class='table-text w-15'>" + item.openSide + "</td> <td class='table-text w-15'>" + item.glass + "</td> <td class='table-text w-10'>" + item.tipper + "</td> <td class='table-text w-10'>" + dimension + "</td> <td class='table-text w-10'>" + item.count + "</td> <td class='table-text w-10'> <span class='edit-icon js--show--client' data-bid-id=" + item.id + "></span> </td> <td class='table-text w-10'> <span class='remove-icon js--remove--bid' data-bid-id=" + item.id + "></span> </td> </tr>";
      }
      html = "<div class='container'><h4>Prozor</h4></div> <table class='table mb-0'> <tr> <th class='table-text w-20'>Vrsta</th> <th class='table-text w-15'>Otvor</th> <th class='table-text w-15'>Staklo</th> <th class='table-text w-10'>Kipanje</th> <th class='table-text w-10'>Dimenzije</th> <th class='table-text w-10'>Količina</th> <th class='table-text w-10'>Izmeni</th> <th class='table-text w-10'>Obriši</th> </tr> </table> <table class='table table-striped'> " + innerHtml + " </table>";
      return html;
    };

    BidSectionsHTML.shutterSectionHTML = function(items) {
      var dimension, html, i, innerHtml, item, len;
      innerHtml = '';
      for (i = 0, len = items.length; i < len; i++) {
        item = items[i];
        dimension = '/';
        if (item.width && item.height) {
          dimension = item.width + 'x' + item.height;
        }
        innerHtml += "<tr class='js--bid--row' data-bid-id=" + item.id + " data-bid-type=" + item.bidType + "> <td class='table-text w-15'>" + item.sort + "</td> <td class='table-text w-15'>" + item.box + "</td> <td class='table-text w-20'>" + (item.boxType || '/') + "</td> <td class='table-text w-10'>" + item.openSide + "</td> <td class='table-text w-10'>" + dimension + "</td> <td class='table-text w-10'>" + item.count + "</td> <td class='table-text w-10'> <span class='edit-icon js--show--client' data-bid-id=" + item.id + "></span> </td> <td class='table-text w-10'> <span class='remove-icon js--remove--bid' data-bid-id=" + item.id + "></span> </td> </tr>";
      }
      html = "<div class='container'><h4>Prozor</h4></div> <table class='table mb-0'> <tr> <th class='table-text w-15'>Vrsta</th> <th class='table-text w-15'>Kutija</th> <th class='table-text w-20'>Tip kutije</th> <th class='table-text w-10'>Otvor</th> <th class='table-text w-10'>Dimenzije</th> <th class='table-text w-10'>Količina</th> <th class='table-text w-10'>Izmeni</th> <th class='table-text w-10'>Obriši</th> </tr> </table> <table class='table table-striped'> " + innerHtml + " </table>";
      return html;
    };

    return BidSectionsHTML;

  })();

}).call(this);
