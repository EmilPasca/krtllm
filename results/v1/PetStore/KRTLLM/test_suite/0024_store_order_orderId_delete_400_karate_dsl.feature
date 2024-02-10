Feature: API Security Testing Scenario
 Background:
 * URL path: /store/order/{orderId}
 * Request headers: None
 * Request body: None

Scenario: delete_order-invalid_id
 Given url '/store/order/{orderId}'
 And method DELETE
 Then status 400
 And match response { "message": "Invalid ID supplied" }