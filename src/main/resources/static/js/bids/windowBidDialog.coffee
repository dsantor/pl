class @WindowBidDialog extends @AbstractBidDialog

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

    _templateHTML: () ->
        return "<div class='form-group form-inline header'>
                    <div>
                        <img src='https://www.dakiplast.rs/wp-content/uploads/2017/05/logo-small-01-300x75.png' style='max-width: 50%;'>
                    </div>
                    <div >
                        <button class='cbtn btn-light #{ComponentsUtils.NEGATIVE_BUTTON}' value='Izmeni'>Otkazi</button>
                        <button class='cbtn  btn-primary #{ComponentsUtils.POSITIVE_BUTTON}' value='Izmeni'>Sacuvaj</button>
                    </div>
                </div>
                <div class='col-7 m-auto p-5 flex'>
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