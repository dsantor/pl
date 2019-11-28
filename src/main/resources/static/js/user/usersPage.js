// Generated by CoffeeScript 1.12.7
(function() {
  this.UserPage = (function() {
    function UserPage() {
      this.container = $('.js--page--container');
      this.clickEvent = this._clickEventHandler.bind(this);
      this.container.on('click', this.clickEvent);
      UserService.getUsers(null, this, this._getUsersSuccess, this._getUsersError);
      this.createdNewUser = this._createdNewUser.bind(this);
      EventUtils.bindCreatedNewUser(this.createdNewUser);
      this.users = [];
      this.userDetailsDialog = new UserDetailsDialog();
      this.crateUserDialog = new CreateUserDialog();
    }

    UserPage.prototype.getPageTitle = function() {
      return 'Users';
    };

    UserPage.prototype._getUsersSuccess = function(response) {
      this.users = response.data;
      if (this.users === null || this.users.length === 0) {
        return this._renderEmptyState();
      } else {
        return this._renderUsers(this.users);
      }
    };

    UserPage.prototype._getUsersError = function(response) {
      return console.log(response.message);
    };

    UserPage.prototype._renderUsers = function(users) {
      var adminOptionsHtml, firstName, i, lastName, len, phoneNumber, rowHtml, tableHtml, u;
      adminOptionsHtml = "";
      if (window.loggedUserInfo.isAdmin) {
        adminOptionsHtml = "<nav class='nav justify-content-end pt-3'> <span class='nav-link span-a js--create--user'>Dodaj korisnika</span> </nav> <th class='table-text w-10'>Profil</th>";
      }
      tableHtml = "<div> <table class='table mb-0'> <tr> " + adminOptionsHtml + " <th class='table-text w-20'>Ime</th> <th class='table-text w-20'>Prezime</th> <th class='table-text w-20'>Telefon</th> <th class='table-text w-30'>Email</th> </tr> </table> <table class='table table-striped'>";
      rowHtml = "";
      for (i = 0, len = users.length; i < len; i++) {
        u = users[i];
        firstName = u.firstName || '/';
        lastName = u.lastName || '/';
        phoneNumber = u.phoneNumber || '/';
        if (window.loggedUserInfo.isAdmin) {
          adminOptionsHtml = "<td class='table-text w-10'><span class='profile-icon js--show--user' data-user-id=" + u.id + "></span></td>";
        }
        rowHtml = "<tr class='js--user--row' data-user-id=" + u.id + "> " + adminOptionsHtml + " <td class='table-text w-20'>" + firstName + "</td> <td class='table-text w-20'>" + lastName + "</td> <td class='table-text w-20'>" + phoneNumber + "</td> <td class='table-text w-30'>" + u.email + "</td> </tr>";
        tableHtml += rowHtml;
      }
      tableHtml += "</table></div>";
      return this.container.html(tableHtml);
    };

    UserPage.prototype._renderEmptyState = function() {
      var html;
      html = "<div class='col-5 m-auto h-75 pt-5 text-center'>Nema registrovanih korisnika :(</div> <div class='pt-3'><input type='button' class='btn btn-primary d-block js--create--user' value='Dodaj korisnika'/> </div>";
      return this.container.html(html);
    };

    UserPage.prototype._showUserInfo = function(id) {
      var user;
      return user = this._getUserById(id);
    };

    UserPage.prototype.show = function() {};

    UserPage.prototype.destroy = function() {
      this.container.off('click', this.clickEvent);
      this.clickEvent = null;
      this.userDetailsDialog.destroy();
      this.userDetailsDialog = null;
      this.crateUserDialog.destroy();
      this.crateUserDialog = null;
      EventUtils.unbindCreatedNewUser(this.createdNewUser);
      this.createdNewUser = null;
      this.container.html('');
      return this.users = null;
    };

    UserPage.prototype._renderSubmenuActions = function() {
      var html;
      if (window.loggedUserInfo.isAdmin) {
        html = "<nav class='nav justify-content-end pt-5 pb-3'> <a href='#create-user' class='nav-item nav-link active'>Dodaj korisnika</a> </nav>";
        return this.container.append(html);
      }
    };

    UserPage.prototype._clickEventHandler = function(e) {
      var element, targetElement, user;
      targetElement = $(e.target);
      element = targetElement.closest('.js--create--user');
      if (element.length > 0) {
        this.crateUserDialog.show();
        return;
      }
      element = targetElement.closest('.js--show--user');
      if (element.length > 0) {
        user = this._getUserById(element.attr('data-user-id'));
        this.userDetailsDialog.show(user);
        return;
      }
      element = targetElement.closest('.js--remove--user');
      if (element.length > 0) {
        this._removeUser(element);
      }
    };

    UserPage.prototype._removeUser = function(element) {
      var userId;
      userId = element.attr('data-user-id');
      return UserService.remove(userId, null, this, this._removeUserSuccess, this._removeUserError);
    };

    UserPage.prototype._removeUserSuccess = function(response) {
      var i, len, ref, u, userId, users;
      userId = response.data;
      $(".js--user--row[data-user-id='" + userId + "']").remove();
      users = [];
      ref = this.users;
      for (i = 0, len = ref.length; i < len; i++) {
        u = ref[i];
        if (u.id !== userId) {
          users.push(u);
        }
      }
      this.users = users;
      if (this.users.length === 0) {
        return this._renderEmptyState();
      }
    };

    UserPage.prototype._removeUserError = function(response) {
      return console.error(response);
    };

    UserPage.prototype._createdNewUser = function(event, user) {
      this.users.push(user);
      return this._renderUsers(this.users);
    };

    UserPage.prototype._getUserById = function(id) {
      var i, len, ref, user;
      id = +id;
      ref = this.users;
      for (i = 0, len = ref.length; i < len; i++) {
        user = ref[i];
        if (user.id === id) {
          return user;
        }
      }
      return null;
    };

    return UserPage;

  })();

}).call(this);
