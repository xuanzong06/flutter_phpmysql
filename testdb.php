<?php

$db_host = 'localhost';
$db_user = 'root';
$db_password = 'root';
$db_db = 'TestDB';
$db_port = 8889;

$action = $_POST["action"];

$conn = new mysqli( $db_host, $db_user, $db_password, $db_db, $db_port);

if($conn->connect_error){
    echo 'Errno: '.$conn->connect_errno;
    echo '<br>';
    echo 'Error: '.$conn->connect_error;
    exit();
}else{
    echo 'Connect Success!';
    echo '<br>'; 
    echo 'Starting Working...';
    echo '<br>';
    // try{
    //     $first_name = 'Zac';
    //     $last_name = 'Test';
    //     $table = 'Employees';
    //     $sql = "INSERT INTO $table ( first_name, last_name) VALUES ('$first_name', '$last_name')";
    //     echo 'SQL command : '.$sql;
    //     // $result = $conn->query($sql);
    //     // echo 'result : '.$result;

    //     if ($conn->query($sql) === TRUE) {
    //         echo "New record created successfully";
    //     } else {
    //         echo "Error: " . $sql . "<br>" . $conn->error;
    //     }

    // }catch(Exception $e){
    //     echo 'Error Exception : '.$e->getMessage();
    // }
    
    
    echo 'Query working successed!';
    echo '<br>'; 
}

echo 'Success: A proper connection to MySQL was made.';
// echo '<br>';
// echo 'Host information: '.$conn->host_info;
// echo '<br>';
// echo 'Protocol version: '.$conn->protocol_version;

if($action == "flutter"){
    $first_name = $_POST["first_name"];
    $last_name = $_POST["last_name"];
    echo '<br>';
    echo 'Get POST from flutter';
    echo 'POST data FirstName : '.$first_name;
    echo 'POST data LastName : '.$last_name;


    try{
        $first_name = $_POST["first_name"];
        $last_name = $_POST["last_name"];
        $table = 'Employees';
        $sql = "INSERT INTO $table ( first_name, last_name) VALUES ('$first_name', '$last_name')";
        echo 'SQL command : '.$sql;
        // $result = $conn->query($sql);
        // echo 'result : '.$result;

        if ($conn->query($sql) === TRUE) {
            echo "New record created successfully";
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }

    }catch(Exception $e){
        echo 'Error Exception : '.$e->getMessage();
    }



}else{
    echo 'No Msg from flutter';
}

// if($action == null){
//     echo '$action is null';

// }

$conn->close();

?>