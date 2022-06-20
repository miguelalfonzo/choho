<?php 



function verify_token_api($token,$pdo){

        $token    =   htmlentities(addslashes($token));
     

        $sql = 'CALL verify_token_api(:token)';

        $data = [];

        $statement = $pdo->prepare($sql);
        $statement->bindParam(':token', $token, \PDO::PARAM_STR,100);
        $statement->execute();

        $data = $statement->fetchAll(\PDO::FETCH_ASSOC);

    
        $response = set_response($data[0]['STATUS'],$data[0]['DESCRIPTION'],array());

      
        return  $response; 
            
    }

    
    

    function set_products_order($order){

        

        include  "include/Conection.php";
        

        $sql = 'CALL list_orders_details_employee(:order)';

        $data = [];

        $response = [] ;

        $statement = $pdo->prepare($sql);
        $statement->bindParam(':order', $order,  \PDO::PARAM_INT);
        $statement->execute();

        $data = $statement->fetchAll(\PDO::FETCH_ASSOC);
    

        foreach ($data as $value) {
           
           $response[] = array(

                'id_producto'    => $value['id_product'],
                'tipo'           => $value['description'],
                'cantidad'       => $value['quantity'],
                'valor_unitario' => $value['unit_price'],
                'total'          => $value['amount']
           ) ;

        }
        return $response;
         
    }

    function set_customers_employee($data,$pdo){


     

        $customers = array();

        $details = array();

        $old_customer = 0;

        foreach ($data as $value) {
            
            if( $value["id_customer"] != $old_customer){

                $details = array();
            }
            

            $customers[$value["id_customer"]][$value["id_order"]] = array(

                                                                    "id_pedido"       => $value['id_order'],
                                                                    "total_productos" => $value['item_order'],
                                                                    "total_pedidos"   => $value['amount_order'],
                                                                    "estado"          => $value['status'],
                                                                    "fecha_pago"      => $value['date_payment'],
                                            "productos"       => set_products_order($value['id_order'])

                                                                );


            $details[] = $customers[$value["id_customer"]][$value["id_order"]];


            $customers[$value["id_customer"]] = array( "id_cliente"      => $value['id_customer'],
                                                       "total_pedidos"   => $value['total_orders_customers'],
                                                       "name"            => $value['name_customer'],
                                                       "detalle_pedidos" => $details
                                                       );

            $old_customer = $value["id_customer"];


            


        }


        return array_values($customers);

       
    }



    function list_orders_employee($param,$pdo){


        $employee = $param["cod_employee"];


        $sql = 'CALL list_orders_employee(:employee)';

        $data = [];

        $statement = $pdo->prepare($sql);
        $statement->bindParam(':employee', $employee, \PDO::PARAM_STR,10);
        $statement->execute();

        $data = $statement->fetchAll(\PDO::FETCH_ASSOC);


        $json = [];


        if( count($data) > 0){

            $cod_employee = implode("",array_unique(array_column($data, 'cod_employee')));

            $name_employee = implode("",array_unique(array_column($data, 'name_employee')));

            $assigned_clients = count(array_unique(array_column($data, 'id_customer')));

            $total_orders = count(array_unique(array_column($data, 'id_order')));

            $customers = set_customers_employee($data,$pdo);



           $json  = array(

                "codigo_asesor"      => $cod_employee,
                "name"               => $name_employee,
                "clientes_asignados" => $assigned_clients,
                "total_pedidos"      => $total_orders,
                "clientes"           => $customers

           );
        

            

        }

        $response = set_response('OK','SUCCESSFUL RESPONSE',$json);
        
        return  $response; 




}




function list_orders_all($employee){

       include  "include/Conection.php";


        $sql = 'CALL list_orders_employee(:employee)';

        $data = [];

        $statement = $pdo->prepare($sql);
        $statement->bindParam(':employee', $employee, \PDO::PARAM_STR,10);
        $statement->execute();

        $data = $statement->fetchAll(\PDO::FETCH_ASSOC);


        return $data;



}
  

    

    

    





    

   
