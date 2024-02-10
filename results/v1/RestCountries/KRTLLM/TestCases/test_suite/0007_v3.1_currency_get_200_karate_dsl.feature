Feature: Currency Search API
Background:
  * URL path: /v3.1/currency
  * Request headers: None
Scenario: CURR-001 - Successful currency search
  Given url '/v3.1/currency'
  And request body {}
  When method GET
  Then status 200
  And match response { "success": true, "data": [{"id": 1, "name": "EUR"}, {"id": 2, "name": "USD"}] }