<?php
include_once("dbconnect.php");


$stmt = $conn->prepare("SELECT * FROM tbl_products");
$stmt->execute();
$result = $stmt->get_result();


if ($result->num_rows > 0) {
    $products["products"] = array();
    while ($row = $result->fetch_assoc()) {
        $productlist['productId'] = $row['prid'];
        $productlist['productName'] = $row['prname'];
        $productlist['productType'] = $row['prtype'];
        $productlist['price'] = $row['prprice'];
        $productlist['quantity'] = $row['prqty'];
        $productlist['picture'] = 'http://192.168.8.31/myshop/images/' . $row['picture'];
        array_push($products['products'], $productlist);
    }
    $response = array('status' => 'success', 'data' => $products);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

// function for sending json
function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
