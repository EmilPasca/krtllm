Feature: API Security Testing Scenario
Background:
* URL path: /store/order/{orderId}
* Request headers: None
Scenario: SCENARIO-API_SECURITY
Given url /store/order/{orderId}
And request body (if any) {}
And headers 
When method GET
Then status 404
And match response { "message": "Order not found" }