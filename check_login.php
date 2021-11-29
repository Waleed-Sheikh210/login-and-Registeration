<?php
include('db.php');

    $hash = "empty";


    $query = "SELECT * From `register` WHERE `email_address` = '".$_POST['email_Address']."'";

    $result = mysqli_query($con,$query);

    if(mysqli_num_rows($result) > 0){
        while($row = mysqli_fetch_assoc($result)) {
            $hash = $row["password"];
        }
        if(password_verify($_POST['password'], $hash)){
            echo "Successfully Logged in!";
        }else{
            echo "Email or password does not match";
        }   
    } else {

        echo "Email or password does not match";

    }
    

?>