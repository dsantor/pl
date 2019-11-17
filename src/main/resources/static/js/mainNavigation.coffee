class @MainNavigation
    constructor: () ->
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
            @_handleNavigationButtons()
            @_openPage(window.location.hash)


    _hashChangedHandler: (event) ->
        @_handleNavigationButtons()
        if @currentPage
            @currentPage.destroy() 
            
        @_openPage(window.location.hash)
        document.title = @currentPage.getPageTitle()


    _openPage: (hash) ->

        switch hash
            when '#profile'
                @currentPage = new UserProfile()
                return
            when '#users'
                @currentPage = new UserPage()
                return
            when '#create-user'
                @currentPage = new CreateUserPage(@container)
                return
            when '#clients'
                @currentPage = new ClientsPage(@container)
                return
            when '#bids'
                @currentPage = new BidsPage(@container)
                return
            else
                @_redirectToErrorPage()
                return
        
    
    _restrictPage: () ->
        if not window.isAdmin
            onlyAdmin = $('.js--admin--only')
            onlyAdmin.remove()

    _handleNavigationButtons: (element) ->
        tab = window.location.hash
        tab = tab.replace('#', '')

        $('.js--nav--item').removeClass('active')
        $(".js--nav--item[data-tab=#{tab}]").addClass('active')

    _redirectToHomepage: () ->
        window.location.hash = "#profile"
	
    _redirectToErrorPage: () ->
        window.location.hash     = '';
        window.location.pathname = "/error-404";
	
    _mainNavigationHandler: (event) ->
        @mainNavigation.toggleClass('open')

$(document).ready ->
    new MainNavigation()