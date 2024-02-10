Feature: API Security Testing Scenario

Background:
* URL path: /store/order/{orderId}
* Request headers: {headers}

Scenario: delete-order-by-id-vulnerability
Given url '/store/order/{orderId}'
And request body {}
When method DELETE
Then status 404

And match response {
    "message": "Order not found"
}