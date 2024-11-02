<?php

date_default_timezone_set('Asia/Jakarta');

$database = (object) [
    'host' => 'localhost',
    'user' => 'root',
    'password' => '',
    'db' => 'nursery',
    'port' => 3306,
];

$conn = new mysqli(
    $database->host,
    $database->user,
    $database->password,
    $database->db,
    $database->port
);

if ($conn->connect_error)
    die("Connection failed" . $conn->connect_error);
