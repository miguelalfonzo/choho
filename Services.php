<?php
    
    ini_set("display_errors", "on");
    ini_set("default_charset", "UTF-8");
    error_reporting (E_ALL);    
    set_time_limit(300);
    header('Content-Type: application/json');


    require_once "include/Conection.php";
    
    require_once "base/Tools.php";

    require_once "Orders.php";

    $parameters = file_get_contents('php://input');


    $data = json_decode($parameters, true); 


    
   

    try 
      {


        
        if( !isset($data["token"])){

            echo verify_inputs("token");
            die();

        }else if( !isset($data["data"])){

            echo verify_inputs("data");
            die();

        }else if( !isset($data["data"]["cod_employee"])){

            echo verify_inputs("cod_employee");
            die();

        }

        $_token          = $data["token"];
       
        $_data           = $data["data"];
        
        
        $middleRpta = verify_token_api($_token,$pdo);


        if ( $middleRpta['status'] == "OK" ) {
            
            
             $response = list_orders_employee($_data,$pdo);

             
        }else{


            $response = set_response($middleRpta['status'],$middleRpta['description'],array());
 
        }
        
       echo json_encode($response,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);

      } 
      catch(Exception $e) 
      { 

        $error = set_response('ERROR',$e->getTrace(),array());

        echo json_encode($error,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);

        die();
      }    


   

