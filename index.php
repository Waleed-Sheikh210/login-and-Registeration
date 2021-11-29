<?php
include('db.php');


$sql="select * from user";
$res=mysqli_query($con,$sql);
$count=mysqli_num_rows($res);
header('content-type:application/json');
if ($count>0) {
    while ($row=mysqli_fetch_assoc($res)) {
        $arr[]=$row;
    }
    echo json_encode(['status'=>true,'data'=>$arr,'result'=>'Found']);
}else {
    echo "No data found";
    echo json_encode(['status'=>true,'msg'=>'No data found','result'=>'Not found']);
}


?>