<?php
	
	
require_once "Parameters.php";


$dsn = 'mysql:host='.DB_HOST.';port='.DB_PORT.';dbname='.DB_NAME;

$username = DB_USERNAME;

$password = DB_PASSWORD;

$options = [];

$pdo = new PDO($dsn, $username, $password, $options);


return $pdo;
