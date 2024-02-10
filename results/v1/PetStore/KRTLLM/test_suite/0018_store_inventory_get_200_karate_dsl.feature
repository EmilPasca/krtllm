Feature: API Security Testing Scenario

Background:
  * URL path: /store/inventory
  * Request headers: None
  * Request body: None

Scenario: SQLI-01 - SQL Injection Attack Detection
  Given url '/store/inventory'
  And request body {}
  When method GET
  Then status 200

  And match response { "data": [ {"id": 1, "name": "Apple", "price": 1}, {"id": 2, "name": "Orange", "price": 2} ] }