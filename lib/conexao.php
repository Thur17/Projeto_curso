<?php

// Detectar ambiente (Docker ou local)
$host = isset($_ENV['DB_HOST']) ? $_ENV['DB_HOST'] : "localhost";
$user = isset($_ENV['DB_USER']) ? $_ENV['DB_USER'] : "root";
$pass = isset($_ENV['DB_PASS']) ? $_ENV['DB_PASS'] : "";
$bd = isset($_ENV['DB_NAME']) ? $_ENV['DB_NAME'] : "escola_ead";

$mysqli = new mysqli($host, $user, $pass, $bd);

/* check connection */
if ($mysqli->connect_errno) {
    echo "Connect failed: " . $mysqli->connect_error;
    exit();
}