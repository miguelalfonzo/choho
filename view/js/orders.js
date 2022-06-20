$(document).ready(function() {

    //VARIABLE SERVER

    server = 'http://localhost/choho/';

    load_list_clientes();

   

});



function load_list_clientes() {

 
    let dataTable = $('#orders-table').DataTable({
        ajax: {
            url: server + 'v1/list.php',
            type: 'GET',
            data: {

              param:null,
              type:'orders'


            },
            dataSrc: '',
            beforeSend: function() {

                
            },
            error: function(jqXHR, textStatus, errorThrown) {

               
                console.log(jqXHR);
                
            }
        },
        "initComplete": function(settings, json) {
           
        },
        language: {
            "decimal": "",
            "emptyTable": "No hay información",
            "info": "Mostrando _START_ a _END_ de _TOTAL_ filas",
            "infoEmpty": "Mostrando 0 to 0 of 0 filas",
            "infoFiltered": "(Filtrado de _MAX_ total filas)",
            "infoPostFix": "",
            "thousands": ",",
            "lengthMenu": "Mostrar _MENU_ filas",
            "loadingRecords": "Cargando...",
            "search": "Buscar:",
            "zeroRecords": "Sin resultados encontrados",
            "paginate": {
                "first": "Primero",
                "last": "Ultimo",
                "next": "Siguiente",
                "previous": "Anterior"
            }
        },
        columns: [ 

        

        {
            data: 'id_order'
        }, {
            data: 'status'
        },{
            data: 'name_employee'
        }, {
            data: 'name_customer'
        }, {
            data: 'item_order'
        }, {
            data: 'amount_order'
        },{
            data: 'date_payment'
        },{
            data: null,
            "render": function(data, type, full, meta) {

                return set_butons_table(data);

            }
        }]

      
      

    });

   

  
}


function set_butons_table(data){

   btn_details = '<a  class="btn btn-success btn-xs text-white" title="Ver"' +
        'onclick="modal_details_order(\'' + data.id_order + '\')" style="cursor:pointer">' +
        '<i class="fas fa-eye"></i></a> ';

    return '<div class="btn-group"> ' + btn_details +'</div>';


}


function destroy_data_table(selector) {

    $('#' + selector).dataTable().fnClearTable();
    $('#' + selector).dataTable().fnDestroy();
}


function modal_details_order(order){


    
    destroy_data_table('orders-details-table');


    let dataTable = $('#orders-details-table').DataTable({
        ajax: {
            url: server + 'v1/list.php',
            type: 'GET',
            data: {

              param:order,
              type:'orders_details'


            },
            dataSrc: '',
            beforeSend: function() {

                
            },
            error: function(jqXHR, textStatus, errorThrown) {

               
                console.log(jqXHR);
                
            }
        },
        "initComplete": function(settings, json) {
           
           $('#modal-details-order').modal('show');

           $('#order-number').text(order);
           
        },
        language: {
            "decimal": "",
            "emptyTable": "No hay información",
            "info": "Mostrando _START_ a _END_ de _TOTAL_ filas",
            "infoEmpty": "Mostrando 0 to 0 of 0 filas",
            "infoFiltered": "(Filtrado de _MAX_ total filas)",
            "infoPostFix": "",
            "thousands": ",",
            "lengthMenu": "Mostrar _MENU_ filas",
            "loadingRecords": "Cargando...",
            "search": "Buscar:",
            "zeroRecords": "Sin resultados encontrados",
            "paginate": {
                "first": "Primero",
                "last": "Ultimo",
                "next": "Siguiente",
                "previous": "Anterior"
            }
        },
        columns: [ 

        

        {
            data: 'id_producto'
        }, {
            data: 'tipo'
        },{
            data: 'cantidad'
        }, {
            data: 'valor_unitario'
        }, {
            data: 'total'
        }]

      
      

    });
    

}