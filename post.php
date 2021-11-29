<?php
include('db.php');

$fname = $_POST['first_name'];
$lname = $_POST['last_name'];
$email = $_POST['email_Address'];
$pass = $_POST['password'];
$cpass = $_POST['Confirm_password'];
$password =  password_hash($pass, PASSWORD_DEFAULT);
// $req='INSERT INTO `user`(`id`, `name`, `email`) VALUES (null,"ibad","ibad@gmail.com")';
if($pass == $cpass){
    $req='INSERT INTO `register`(`id`, `first_name`, `last_name`, `email_address`, `password`) 
    VALUES (null,"'.$fname.'", "'.$lname.'", "'.$email.'", "'.$password.'")';
    
    if (mysqli_query($con,$req)) {
        echo "Success";
    }else {
        echo "ERROR: Could not able to Execute". mysqli_error($con);
    }
    mysqli_close($con);
} else {
    echo "Password does not Matched!";
}





?>