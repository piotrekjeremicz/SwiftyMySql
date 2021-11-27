<?php
    $servername = $argv[1];
    $username = $argv[2];
    $password = $argv[3];
    $dbname = $argv[4];
    $port = $argv[5];

    $ztm_db = new mysqli($servername, $username, $password, $dbname, $port);
    
    if ($ztm_db->connect_error) {
        die('Connect Error (' . $db->connect_errno . ') ' . $db->connect_error);
    }
    
    $query = $argv[5];
    $result = mysqli_query($ztm_db, $query);
    $ztm_db->next_result();
    
    $rows = [];
    while($row = $result->fetch_array(MYSQLI_ASSOC)) {
        $object = new stdClass();
        foreach ($row as $key => $value) {
            $object->$key = $value;
        }
        
        $rows[] = $object;
    }
    
    echo json_encode($rows);
?>

