Feature: API Security Testing Scenario

Background:
  * url: /store/order
  * method: POST
  * headers: { "Content-Type": "application/json" }
  * requestBody: { "id": 1, "petId": 2, "quantity": 3, "shipDate": "2022-08-15", "status": "placed", "complete": false }

Scenario: API_Security_Test_1
  Given url /store/order
  And headers { "Content-Type": "application/json" }
  When method POST
  Then status 200
    * match body {"id": 4, "petId": 5, "quantity": 6, "shipDate": "2022-10-03", "status": "approved"}