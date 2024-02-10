Feature: API Security Testing Scenario

Background:
  * URL path: /v3.1/fullname/{countryName}
  * Request headers: None
  * Body params (if any): None
  
Scenario: API_Security-SQLInjection
  Given url '/v3.1/fullname/' + countryName
  And request body {}
  When method GET
  Then status 200

  And match response { "data": [{"countryFullName": "Vulnerable Country"}] }