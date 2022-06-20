<?php 


	ini_set("display_errors", "on");
    ini_set("default_charset", "UTF-8");
    error_reporting (E_ALL);    
    set_time_limit(300);
    header('Content-Type: application/json');


    
    require_once "../Orders.php";
    require_once "../base/Tools.php";

	if(isset($_GET["param"]) && isset($_GET["type"])){

		 $type = $_GET["type"];

		 $param = $_GET["param"];

		 switch ($type) {

              
                case 'orders':

	                    $response = list_orders_all($param);

	                    break;

                 case 'orders_details':

                   		$response = set_products_order($param);

                   		break; 

                  default:

                  $response = set_response('ERROR','ERROR',array());

            }
		

		

		echo json_encode($response,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);

	}else{

		$error = set_response('ERROR','ERROR',array());

        echo json_encode($error,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);
	}

 ?>