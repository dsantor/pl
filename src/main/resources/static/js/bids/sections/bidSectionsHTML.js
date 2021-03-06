// Generated by CoffeeScript 1.12.7
(function() {
  this.BidSectionsHTML = (function() {
    function BidSectionsHTML() {}

    BidSectionsHTML.emptyState = function() {
      return "<div class='col-5 m-auto h-75 pt-5 text-center'>Korpa je prazna :(</div>";
    };

    BidSectionsHTML.doorSectionHTML = function(items) {
      var dimension, html, i, innerHtml, item, len;
      innerHtml = "";
      for (i = 0, len = items.length; i < len; i++) {
        item = items[i];
        dimension = '/';
        if (item.width && item.height && item.innerWidth) {
          dimension = item.width + 'x' + item.height + 'x' + item.innerWidth;
        }
        innerHtml += "<div class='flex-table js--bid--row' data-bid-id=" + item.id + " data-bid-type=" + item.bidType + "> <div class='flex-table-cell w-20'>" + item.sort + "</div> <div class='flex-table-cell w-20'>" + item.type + "</div> <div class='flex-table-cell w-10'>" + item.openSide + "</div> <div class='flex-table-cell w-10'>" + item.glass + "</div> <div class='flex-table-cell w-10'>" + dimension + "</div> <div class='flex-table-cell w-10'>" + item.quantity + "</div> <div class='flex-table-cell w-10'> <span class='edit-icon js--edit--bid' data-bid-id=" + item.id + "></span> </div> <div class='flex-table-cell w-10'> <span class='remove-icon js--remove--bid' data-bid-id=" + item.id + "></span> </div> </div>";
      }
      html = "<div class='js--section--door'> <div class='container'><h4>Vrata</h4></div> <div class='flex-table'> <div class='flex-table-cell w-20'>Vrsta</div> <div class='flex-table-cell w-20'>Tip</div> <div class='flex-table-cell w-10'>Otvor</div> <div class='flex-table-cell w-10'>Staklo</div> <div class='flex-table-cell w-10'>Dimenzije</div> <div class='flex-table-cell w-10'>Količina</div> <div class='flex-table-cell w-10'>Izmeni</div> <div class='flex-table-cell w-10'>Obriši</div> </div> " + innerHtml + " </div> </div>";
      return html;
    };

    BidSectionsHTML.thresholdSectionHTML = function(items) {
      var html, i, innerHtml, item, len;
      innerHtml = '';
      for (i = 0, len = items.length; i < len; i++) {
        item = items[i];
        innerHtml += "<div class='flex-table js--bid--row' data-bid-id=" + item.id + " data-bid-type=" + item.bidType + "> <div class='flex-table-cell w-20'>" + item.sort + "</div> <div class='flex-table-cell w-20'>" + (item.width || '/') + "</div> <div class='flex-table-cell w-10'>" + (item.height || '/') + "</div> <div class='flex-table-cell w-20'>" + (item.innerWidth || '/') + "</div> <div class='flex-table-cell w-10'>" + item.quantity + "</div> <div class='flex-table-cell w-10'> <span class='edit-icon js--edit--bid' data-bid-id=" + item.id + "></span> </div> <div class='flex-table-cell w-10'> <span class='remove-icon js--remove--bid' data-bid-id=" + item.id + "></span> </div> </div>";
      }
      html = "<div class='js--section--threshold'> <div class='container'><h4>Prag</h4></div> <div class='flex-table'> <div class='flex-table-cell w-20'>Vrsta</div> <div class='flex-table-cell w-20'>Širina</div> <div class='flex-table-cell w-10'>Visina</div> <div class='flex-table-cell w-20'>Unudivašnja širina</div> <div class='flex-table-cell w-10'>Količina</div> <div class='flex-table-cell w-10'>Promeni</div> <div class='flex-table-cell w-10'>Obriši</div> </div> " + innerHtml + " </div> </div>";
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
        innerHtml += "<div class='flex-table js--bid--row' data-bid-id=" + item.id + " data-bid-type=" + item.bidType + "> <div class='flex-table-cell w-20'>" + item.sort + "</div> <div class='flex-table-cell w-20'>" + item.type + "</div> <div class='flex-table-cell w-20'>" + item.openSide + "</div> <div class='flex-table-cell w-10'>" + dimension + "</div> <div class='flex-table-cell w-10'>" + item.quantity + "</div> <div class='flex-table-cell w-10'> <span class='edit-icon js--edit--bid' data-bid-id=" + item.id + "></span> </div> <div class='flex-table-cell w-10'> <span class='remove-icon js--remove--bid' data-bid-id=" + item.id + "></span> </div> </div>";
      }
      html = "<div class='js--section--mosquito'> <div class='container'><h4>Komarnik</h4></div> <div class='flex-table'> <div class='flex-table-cell w-20'>Vrsta</div> <div class='flex-table-cell w-20'>Tip</div> <div class='flex-table-cell w-20'>Otvor</div> <div class='flex-table-cell w-10'>Dimenzije</div> <div class='flex-table-cell w-10'>Količina</div> <div class='flex-table-cell w-10'>Izmeni</div> <div class='flex-table-cell w-10'>Obriši</div> </div> " + innerHtml + " </div> </div>";
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
        innerHtml += "<div class='flex-table js--bid--row' data-bid-id=" + item.id + " data-bid-type=" + item.bidType + "> <div class='flex-table-cell w-20'>" + item.sort + "</div> <div class='flex-table-cell w-15'>" + item.openSide + "</div> <div class='flex-table-cell w-15'>" + item.glass + "</div> <div class='flex-table-cell w-10'>" + item.tipper + "</div> <div class='flex-table-cell w-10'>" + dimension + "</div> <div class='flex-table-cell w-10'>" + item.quantity + "</div> <div class='flex-table-cell w-10'> <span class='edit-icon js--edit--bid' data-bid-id=" + item.id + "></span> </div> <div class='flex-table-cell w-10'> <span class='remove-icon js--remove--bid' data-bid-id=" + item.id + "></span> </div> </div>";
      }
      html = "<div class='js--section--window'> <div class='container'><h4>Prozor</h4></div> <div class='flex-table'> <div class='flex-table-cell w-20'>Vrsta</div> <div class='flex-table-cell w-15'>Otvor</div> <div class='flex-table-cell w-15'>Staklo</div> <div class='flex-table-cell w-10'>Kipanje</div> <div class='flex-table-cell w-10'>Dimenzije</div> <div class='flex-table-cell w-10'>Količina</div> <div class='flex-table-cell w-10'>Izmeni</div> <div class='flex-table-cell w-10'>Obriši</div> </div> " + innerHtml + " </div> </div>";
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
        innerHtml += "<div class='flex-table js--bid--row' data-bid-id=" + item.id + " data-bid-type=" + item.bidType + "> <div class='flex-table-cell w-15'>" + item.sort + "</div> <div class='flex-table-cell w-15'>" + item.box + "</div> <div class='flex-table-cell w-20'>" + (item.boxType || '/') + "</div> <div class='flex-table-cell w-10'>" + item.openSide + "</div> <div class='flex-table-cell w-10'>" + dimension + "</div> <div class='flex-table-cell w-10'>" + item.quantity + "</div> <div class='flex-table-cell w-10'> <span class='edit-icon js--edit--bid' data-bid-id=" + item.id + "></span> </div> <div class='flex-table-cell w-10'> <span class='remove-icon js--remove--bid' data-bid-id=" + item.id + "></span> </div> </div>";
      }
      html = "<div class='js--section--shutter'> <div class='container'><h4>Roletna</h4></div> <div class='flex-table'> <div class='flex-table-cell w-15'>Vrsta</div> <div class='flex-table-cell w-15'>Kutija</div> <div class='flex-table-cell w-20'>Tip kutije</div> <div class='flex-table-cell w-10'>Otvor</div> <div class='flex-table-cell w-10'>Dimenzije</div> <div class='flex-table-cell w-10'>Količina</div> <div class='flex-table-cell w-10'>Izmeni</div> <div class='flex-table-cell w-10'>Obriši</div> </div> " + innerHtml + " </div> </div>";
      return html;
    };

    return BidSectionsHTML;

  })();

}).call(this);
