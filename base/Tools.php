<?php 

function verify_inputs($input){

 	$error = array (
                    "status"          => 'ERROR',
                    "description"     => 'Undefined Variable :'.$input
            );

       

        return json_encode($error,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);

}

 
 function set_response($status,$description,$data){


    return array(	"status"      => $status,
    				"description" => $description,
    				"data"        => $data

    			);

}