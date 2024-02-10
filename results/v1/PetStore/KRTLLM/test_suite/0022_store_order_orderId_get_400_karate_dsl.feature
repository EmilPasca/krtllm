Feature: API Security Testing Scenario
Background:
* URL path: /store/order/{orderId}
* Request headers: None
Scenario: Vulnerability-Test-1
Given url /store/order/{orderId}
And request body {} (No Body)
When method GET
Then status 400
And match response { "message": "Invalid ID supplied" }