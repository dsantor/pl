class @WindowBidDialog extends AbstractDialog

    BID_TYPE = 'WINDOW'

    constructor: () ->
        super()

    show: () ->
        super()

    hide: () ->
        super()

    destroy: () ->
        super()

    save: () ->
        @_collectDataFromForm()
        super()

    cancel: () ->
        super()


    _collectDataFromForm: () ->
        @doorType = $('.js--door--type')

    _customHTML: () ->
        return "<div class='col-7 m-auto p-5 flex'>
                    <div class='container container-padding w-50'>

                        <h5>Opste</h5>     
                        <br>
                        <div class='form-group'>
                            <label>Vrsta prozora</label>
                            <select>
                                <option selected>---</option>
                                <option>Jednokrilni</option>
                                <option>Dvokrlni</option>
                                <option>Trokrilni</option>
                                <option>Fiks</option>
                            </select>
                        </div>
                        
                        <div class='form-group'>
                                <label>Strana otvora</label>
                                <select>
                                    <option selected>---</option>
                                    <option>Levi otvor</option>
                                    <option>Desni otvor</option>
                                </select>
                        </div>
                        <div class='form-group'>
                            <label>Staklo</label>
                            <select>
                                <option selected>---</option>
                                <option>Providno</option>
                                <option>Griz</option>
                            </select>
                        </div>
                        <div class='form-group'>
                            <br>
                            <hr>
                            <h5>Dimenzije</h5>     
                            <br>
                        
                            <div class='form-group form-inline'>
                                <label class='mr-2 wh-10 left-label'>Sirina</label>
                                <input type='number' class='form-control' placeholder='cm'>
                            </div>
                            <div class='form-group form-inline'>
                                <label class='mr-2 wh-10 left-label'>Visina</label>
                                <input type='number' class='form-control' placeholder='cm'>
                            </div>
                            <div class='form-group form-inline'>
                                <label class='mr-2 wh-10 left-label'>Unutrasnja sirina</label>
                                <input type='number' class='form-control' placeholder='cm'>
                            </div>
                        </div>
                        
                        <div class='form-group'>
                                <br>
                                <hr>
                                <h5>Dodatno</h5>     
                                <br>
                                <label>Kipovanje</label>
                                <select>
                                    <option selected>---</option>
                                    <option>Da</option>
                                    <option>Ne</option>
                                </select>
                        </div>
                    </div>
                </div>"