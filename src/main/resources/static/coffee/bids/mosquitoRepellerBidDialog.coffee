class @MosquitoRepellerBidDialog extends AbstractDialog

    BID_TYPE = 'MOSQUITO_REPELLER'

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
                        <label>Vrsta komarnika</label>
                        <select>
                            <option selected>---</option>
                            <option>Fiksni</option>
                            <option>Rolo</option>
                        </select>
                    </div>
                    <div class='form-group'>
                            <label>Tip komarnika</label>
                            <select>
                                <option selected>---</option>
                                <option>Vrata</option>
                                <option>Rolo</option>
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
                        <br> <hr>
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
                    </div>
             </div>"