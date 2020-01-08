class @MainNavigation
    constructor: () ->
        @pages = {
            '#profile': 'profile', '#user': 'users', '#worker': 'workers',
            '#client': 'clients', '#order': 'orders', '#bids': 'bids', '#expens': 'expenses'}

        @currentPageHash  = null
        @currentPage = null
        @pageTitle = $('.js--page--title')
        @navigationBar = $('.js--nav--bar')
        @container = $('.js--page--container')

        @mainNavigation = $('.js--main--navigation')
        @mainNavigation.on 'click', @_mainNavigationHandler.bind(this)
		
        @_restrictPage()
        $(window).on 'hashchange', @_hashChangedHandler.bind(this)

        if window.location.hash == ''
        	@_redirectToHomepage()
        else
            @_handlePage()
            

    _handlePage: () ->
        hashValue = @_extractHashValue()
        @_openPage(hashValue)
        tab = ''
        keys = Object.keys(@pages)
        for key in keys
            if hashValue.page.startsWith(key)
                tab = @pages[key]
                break
        @_handleNavigationButtons(tab)

    _hashChangedHandler: (event) ->
        
        @_savePreviousPage(@currentPageHash)

        if @currentPage
            @currentPage.destroy() 

        @_handlePage()
        document.title = @currentPage.getPageTitle()


    _openPage: (hash) ->
        switch hash.page
            when '#profile'
                @currentPage = new UserProfile()
                return
            when '#users'
                @currentPage = new UsersPage()
                return
            when '#user'
                @currentPage = new UserPage(hash.value)
                return
            when '#workers'
                @currentPage = new WorkersPage()
                return
            when '#worker'
                @currentPage = new WorkerPage(hash.value)
                return
            when "#client/#{hash.data}"
                @currentPage = new OrdersPage(hash.value)
                return
            when '#clients'
                @currentPage = new ClientsPage()
                return
            when '#client'
                @currentPage = new ClientProfilePage(hash.value)
                return
            when '#bids'
                @currentPage = new BidsPage(hash.value)
                return
            when '#orders'
                @currentPage = new OrdersPage()
                return
            when '#order'
                @currentPage = new OrderPage(hash.value)
                return
            when '#expenses'
                @currentPage = new ExpensesPage(hash.value)
                return
            else
                @_redirectToErrorPage()
                return
        
    
    _restrictPage: () ->
        if not window.loggedUserInfo.isAdmin
            onlyAdmin = $('.js--admin--only')
            onlyAdmin.remove()

    _handleNavigationButtons: (tab) ->
        $('.js--nav--item').removeClass('active')
        $(".js--nav--item[data-tab=#{tab}]").addClass('active')

    _redirectToHomepage: () ->
        window.location.hash = "#profile"
	
    _redirectToErrorPage: () ->
        window.location.hash     = '';
        window.location.pathname = "/error-404";
	
    _mainNavigationHandler: (event) ->
        @mainNavigation.toggleClass('open')

    _extractHashValue: () ->
        hash = window.location.hash
        dashes = hash.split('/') 
        if dashes.length > 2
            data = hash.substring(hash.indexOf('/')+1)
            value = data.substring(0, data.indexOf('/'))
            return {page: hash, data: data, value: value}
            
        dash = hash.indexOf('/')
        page = hash
        value = null
        if dash > 0
            page = hash.substring(0, dash)
            value = hash.substring(dash + 1) 
        
        return {page: page, data: '', value: value}

    
    @back = () ->
        window.previousPageHash = history.back()

$(document).ready ->
    new MainNavigation()