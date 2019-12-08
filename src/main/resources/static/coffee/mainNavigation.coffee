class @MainNavigation
    constructor: () ->

        @pageAndHash = {'#profile': 'profile', '#users': 'users', '#user': 'users', '#workers': 'workers', '#worker': 'workers', '#clients': "clients", "#bids": 'bids', '#client': 'clients'}
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
        tab = @pageAndHash[hashValue.page]
        @_handleNavigationButtons(tab)

    _hashChangedHandler: (event) ->
        
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
                @currentPage = new UserPage()
                return
            when '#user'
                @currentPage = new UserDetailsDialog(hash.value)
                return
            when '#workers'
                @currentPage = new WorkersPage()
                return
            when '#worker'
                @currentPage = new WorkerPage(hash.value)
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
        hashObject = {}
        hash = window.location.hash
        dash = hash.indexOf('/')
        page = hash
        value = null
        if dash > 0
            page = hash.substring(0, dash)
            value = hash.substring(dash + 1) 
        
        return {page: page, value: value}
$(document).ready ->
    new MainNavigation()