class @OrderTypesSettings extends AbstractPage

    constructor: () ->
        super()
        @doorSorts = ['Ulazna', 'Sobna', 'Dvokrilna balkonska', 'Garažna', 'Segmentna garazna', 'Rolo']
        @doorTypes = ['Sa staklom', 'Pun panel', 'Panel/staklo', 'Dekorativni modeli']
        @doorGlass     = ['Providno', 'Griz', 'Delta', 'Vitraz']
        @thresholdSorts = ['Alu prag', 'Štok']
        @mosquitoSorts = ['Fiksni', 'Rolo']
        @mosquitoTypes = ['Vrata', 'Rolo']
        @windowSorts = ['Jednokrilni', 'Dvokrlni', 'Trokrilni', 'Fiks']
        @windowGlass = ['Providno', 'Griz']
        @shutterSorts = ['Kaiš', 'Kurbla', 'Elektronski pogon']
        @shutterBoxSorts = ['Spoljašnja', 'Unutrašnja']
        @shutterBoxTypes = ['RONDO poluzaobljeni', 'ALU liveni', 'ALU zastorom']
        @pageHTML()

    destroy: () ->
        super()
   
    _activeContainer: (container) ->
        @container.find('.js--sub--nav--item').removeClass('active')
        @container.find(container).addClass('active')
        @container.find('.js--nav--container').addClass('hide')
        @container.find(container + '--container').removeClass('hide')

    _clickEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--nav--door')
            @_activeContainer('.js--nav--door')            
            return
        
        if closest(target, '.js--nav--threshold')
            @_activeContainer('.js--nav--threshold')            
            return

        if closest(target, '.js--nav--mosquito')
            @_activeContainer('.js--nav--mosquito')            
            return

        if closest(target, '.js--nav--window')
            @_activeContainer('.js--nav--window')            
            return

        if closest(target, '.js--nav--shutter')
            @_activeContainer('.js--nav--shutter')            
            return

        # Door sort
        if closest(target, '.js--door--sort--add--button')
            input = $('.js--door--sort--add--value').val().trim()
            @doorSorts.push(input)
            @_doorsHTML()
            return

        if closest(target, '.js--door--sort--remove--value')
            type = $('.js--door--sort').val()
            items = []
            for item in @doorSorts
                if item isnt type
                    items.push(item)
            @doorSorts = items
            @_doorsHTML()
            return

        # Door glass
        if closest(target, '.js--door--glass--add--button')
            input = $('.js--door--glass--add--value').val().trim()
            @doorGlass.push(input)
            @_doorsHTML()
            return

        if closest(target, '.js--door--glass--remove--value')
            type = $('.js--door--glass').val()
            items = []
            for item in @doorGlass
                if item isnt type
                    items.push(item)
            @doorGlass = items
            @_doorsHTML()
            return

        # Door type
        if closest(target, '.js--door--type--add--button')
            input = $('.js--door--type--add--value').val().trim()
            @doorTypes.push(input)
            @_doorsHTML()
            return

        if closest(target, '.js--door--type--remove--value')
            type = $('.js--door--type').val()
            items = []
            for item in @doorTypes
                if item isnt type
                    items.push(item)
            @doorTypes = items
            @_doorsHTML()
            return

        # Threshold sort
        if closest(target, '.js--threshold--sort--add--button')
            input = $('.js--threshold--sort--add--value').val().trim()
            @thresholdSorts.push(input)
            @_thresholdHTML()
            return

        if closest(target, '.js--threshold--sort--remove--value')
            type = $('.js--threshold--sort').val()
            items = []
            for item in @thresholdSorts
                if item isnt type
                    items.push(item)
            @thresholdSorts = items
            @_thresholdHTML()
            return
        
        # Mosquito sort
        if closest(target, '.js--mosquito--sort--add--button')
            input = $('.js--mosquito--sort--add--value').val().trim()
            @mosquitoSorts.push(input)
            @_mosquitoHTML()
            return

        if closest(target, '.js--mosquito--sort--remove--value')
            type = $('.js--mosquito--sort').val()
            items = []
            for item in @mosquitoSorts
                if item isnt type
                    items.push(item)
            @mosquitoSorts = items
            @_mosquitoHTML()
            return
        
        # Window sort
        if closest(target, '.js--window--sort--add--button')
            input = $('.js--window--sort--add--value').val().trim()
            @windowSorts.push(input)
            @_windowHTML()
            return

        if closest(target, '.js--window--sort--remove--value')
            type = $('.js--window--sort').val()
            items = []
            for item in @windowSorts
                if item isnt type
                    items.push(item)
            @windowSorts = items
            @_windowHTML()
            return

        # Window glass
        if closest(target, '.js--window--glass--add--button')
            input = $('.js--window--glass--add--value').val().trim()
            @windowGlass.push(input)
            @_windowHTML()
            return

        if closest(target, '.js--window--glass--remove--value')
            type = $('.js--window--glass').val()
            items = []
            for item in @windowGlass
                if item isnt type
                    items.push(item)
            @windowGlass = items
            @_windowHTML()
            return

        # Shutter sort
        if closest(target, '.js--shutter--sort--add--button')
            input = $('.js--shutter--sort--add--value').val().trim()
            @shutterSorts.push(input)
            @_shutterHTML()
            return

        if closest(target, '.js--shutter--sort--remove--value')
            type = $('.js--shutter--sort').val()
            items = []
            for item in @shutterSorts
                if item isnt type
                    items.push(item)
            @shutterSorts = items
            @_shutterHTML()
            return
        
        # Shutter box sort
        if closest(target, '.js--shutter--box--sort--add--button')
            input = $('.js--shutter--box--sort--add--value').val().trim()
            @shutterBoxSorts.push(input)
            @_shutterHTML()
            return

        if closest(target, '.js--shutter--box--sort--remove--value')
            type = $('.js--shutter--box--sort').val()
            items = []
            for item in @shutterBoxSorts
                if item isnt type
                    items.push(item)
            @shutterBoxSorts = items
            @_shutterHTML()
            return
        
        # Shutter box type
        if closest(target, '.js--shutter--box--type--add--button')
            input = $('.js--shutter--box--type--add--value').val().trim()
            @shutterBoxTypes.push(input)
            @_shutterHTML()
            return

        if closest(target, '.js--shutter--box--type--remove--value')
            type = $('.js--shutter--box--type').val()
            items = []
            for item in @shutterBoxTypes
                if item isnt type
                    items.push(item)
            @shutterBoxTypes = items
            @_shutterHTML()
            return

    pageHTML: () ->
        super()
        @_doorsHTML()
        @_thresholdHTML()
        @_mosquitoHTML()
        @_windowHTML()
        @_shutterHTML()

    _customHTML: () ->
        return "<nav class='nav justify-content-end header pt-3'>
                    <span class='nav-link span-a js--sub--nav--item js--nav--door active'>Vrata</span>
                    <span class='nav-link span-a js--sub--nav--item js--nav--threshold'>Pragovi</span>
                    <span class='nav-link span-a js--sub--nav--item js--nav--mosquito'>Komarnici</span>
                    <span class='nav-link span-a js--sub--nav--item js--nav--window'>Prozori</span>
                    <span class='nav-link span-a js--sub--nav--item js--nav--shutter'>Roletne</span>
                </nav>
                <div class='col-7 m-auto h-75 pt-5 flex'>
                    <div class='container w-75'>
                        <div class='js--nav--container js--nav--door--container'>
                        </div>
                        <div class='js--nav--container js--nav--threshold--container hide'>
                        </div>
                        <div class='js--nav--container js--nav--mosquito--container hide'>
                        </div>
                        <div class='js--nav--container js--nav--window--container hide'>
                        </div>
                        <div class='js--nav--container js--order--nav--shutter--container js--nav--shutter--container hide'>
                        </div>
                    </div>
                </div>"


    _printOptionsHTML: (items) ->
        html = ''
        for item in items
            html += "<option value='#{item}'>#{item}</option>"
        return html

    _doorsHTML: () ->
        html =  "<div class='form-group'>
                    <h5>Vrata</h5>
                    <div class='flex flex-column'>
                        <label>Vrsta vrata</label>
                        <div class='flex flex-row'>                                    
                            <select class='js--door--sort'>
                                #{@_printOptionsHTML(@doorSorts)}
                            </select>
                            <button class='cbtn btn-danger js--door--sort--remove--value'>Obriši</button>    
                        </div>
                        <div class='flex flex-row'>
                            <input type='text' class='form-control js--door--sort--add--value' placeholder='Vrsta vrata'>
                            <button class='cbtn btn-primary js--door--sort--add--button'>Dodaj</button>
                        </div>
                    </div>
                </div>
                <div class='form-group'>
                    <div class='flex flex-column'>
                        <label>Staklo</label>
                        <div class='flex flex-row'>                                    
                            <select class='js--door--glass'>
                                #{@_printOptionsHTML(@doorGlass)}
                            </select>
                            <button class='cbtn btn-danger js--door--glass--remove--value'>Obriši</button>    
                        </div>
                        <div class='flex flex-row'>
                            <input type='text' class='form-control js--door--glass--add--value' placeholder='Vrsta stakla'>
                            <button class='cbtn btn-primary js--door--glass--add--button'>Dodaj</button>
                        </div>
                    </div>
                </div>
                <div class='form-group'>                            
                    <div class='flex flex-column'>
                        <label>Tip vrata</label>
                        <div class='flex flex-row'>                                    
                            <select class='js--door--type'>
                                #{@_printOptionsHTML(@doorTypes)}
                            </select>
                            <button class='cbtn btn-danger js--door--type--remove--value'>Obriši</button>    
                        </div>
                        <div class='flex flex-row'>
                            <input type='text' class='form-control js--door--type--add--value' placeholder='Tip vrata'>
                            <button class='cbtn btn-primary js--door--type--add--button'>Dodaj</button>
                        </div>
                    </div>
                </div>"
        @container.find('.js--nav--door--container').html(html)
    
    _thresholdHTML: () ->        
        html = "<div class='form-group'>
                    <h5>Prag</h4>
                    <div class='flex flex-column'>
                        <label>Vrsta praga</label>
                        <div class='flex flex-row'>                                    
                            <select class='js--threshold--sort'>
                                #{@_printOptionsHTML(@thresholdSorts)}
                            </select>
                            <button class='cbtn btn-danger js--threshold--sort--remove--value'>Obriši</button>    
                        </div>
                        <div class='flex flex-row'>
                            <input type='text' class='form-control js--threshold--sort--add--value' placeholder='Vrsta praga'>
                            <button class='cbtn btn-primary js--threshold--sort--add--button'>Dodaj</button>
                        </div>
                    </div>
                </div>"
        @container.find('.js--nav--threshold--container').html(html)

    _mosquitoHTML: () ->
        html = "<div class='form-group'>
                    <h5>Komarnik</h5>
                    <div class='flex flex-column'>
                        <label>Vrsta komarnika</label>
                        <div class='flex flex-row'>                                    
                            <select class='js--mosquito--sort'>
                                #{@_printOptionsHTML(@mosquitoSorts)}
                            </select>
                            <button class='cbtn btn-danger js--mosquito--sort--remove--value'>Obriši</button>    
                        </div>
                        <div class='flex flex-row'>
                            <input type='text' class='form-control js--mosquito--sort--add--value' placeholder='Vrsta komarnika'>
                            <button class='cbtn btn-primary js--mosquito--sort--add--button'>Dodaj</button>
                        </div>
                    </div>
                </div>
                <div class='form-group'>                            
                    <div class='flex flex-column'>
                        <label>Tip komarnika</label>
                        <div class='flex flex-row'>                                    
                            <select class='js--mosquito--type'>
                                #{@_printOptionsHTML(@mosquitoTypes)}
                            </select>
                            <button class='cbtn btn-danger js--mosquito--type--remove--value'>Obriši</button>    
                        </div>
                        <div class='flex flex-row'>
                            <input type='text' class='form-control js--mosquito--type--add--value' placeholder='Tip komarnika'>
                            <button class='cbtn btn-primary js--mosquito--type--add--button'>Dodaj</button>
                        </div>
                    </div>
                </div>"
        @container.find('.js--nav--mosquito--container').html(html)


    _windowHTML: () ->
        html = "<div class='form-group'>
                    <h5>Prozori</h5>
                    <div class='flex flex-column'>
                        <label>Vrsta prozora</label>
                        <div class='flex flex-row'>                                    
                            <select class='js--window--sort'>
                                #{@_printOptionsHTML(@windowSorts)}
                            </select>
                            <button class='cbtn btn-danger js--window--sort--remove--value'>Obriši</button>    
                        </div>
                        <div class='flex flex-row'>
                            <input type='text' class='form-control js--window--sort--add--value' placeholder='Vrsta prozora'>
                            <button class='cbtn btn-primary js--window--sort--add--button'>Dodaj</button>
                        </div>
                    </div>
                </div>
                <div class='form-group'>
                    <div class='flex flex-column'>
                        <label>Staklo</label>
                        <div class='flex flex-row'>                                    
                            <select class='js--window--glass'>
                                #{@_printOptionsHTML(@windowGlass)}
                            </select>
                            <button class='cbtn btn-danger js--window--glass--remove--value'>Obriši</button>    
                        </div>
                        <div class='flex flex-row'>
                            <input type='text' class='form-control js--window--glass--add--value' placeholder='Vrsta stakla'>
                            <button class='cbtn btn-primary js--window--glass--add--button'>Dodaj</button>
                        </div>
                    </div>
                </div>"
        @container.find('.js--nav--window--container').html(html)
    
    _shutterHTML: () ->
        html = "<div class='form-group'>
                    <h5>Roletne</h5>
                    <div class='flex flex-column'>
                        <label>Vrsta roletne</label>
                        <div class='flex flex-row'>                                    
                            <select class='js--shutter--sort'>
                                #{@_printOptionsHTML(@shutterSorts)}
                            </select>
                            <button class='cbtn btn-danger js--shutter--sort--remove--value'>Obriši</button>    
                        </div>
                        <div class='flex flex-row'>
                            <input type='text' class='form-control js--shutter--sort--add--value' placeholder='Vrsta roletne'>
                            <button class='cbtn btn-primary js--shutter--sort--add--button'>Dodaj</button>
                        </div>
                    </div>
                </div>
                <div class='form-group'>                            
                    <div class='flex flex-column'>
                        <label>Vrsta kutije</label>
                        <div class='flex flex-row'>                                    
                            <select class='js--shutter--box--sort'>
                                #{@_printOptionsHTML(@shutterBoxSorts)}
                            </select>
                            <button class='cbtn btn-danger js--shutter--box--sort--remove--value'>Obriši</button>    
                        </div>
                        <div class='flex flex-row'>
                            <input type='text' class='form-control js--shutter--box--sort--add--value' placeholder='Vrsta kutije'>
                            <button class='cbtn btn-primary js--shutter--box--sort--add--button'>Dodaj</button>
                        </div>
                    </div>
                </div>
                <div class='form-group'>                            
                    <div class='flex flex-column'>
                        <label>Tip kutije</label>
                        <div class='flex flex-row'>                                    
                            <select class='js--shutter--box--type'>
                                #{@_printOptionsHTML(@shutterBoxTypes)}
                            </select>
                            <button class='cbtn btn-danger js--door--sort--remove--value'>Obriši</button>    
                        </div>
                        <div class='flex flex-row'>
                            <input type='text' class='form-control js--shutter--box--type--add--value' placeholder='Tip kutije'>
                            <button class='cbtn btn-primary js--shutter--box--type--add--button'>Dodaj</button>
                        </div>
                    </div>
                </div>"
        @container.find('.js--nav--shutter--container').html(html)