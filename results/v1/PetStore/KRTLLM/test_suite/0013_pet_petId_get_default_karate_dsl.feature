Feature: Pet ID API Security Testing
Background:
  * URL path: /pet/{petId}
  * Request headers: None
  * Request body (if any): None

Scenario: Scenario1-PetIDSecurityTest
  Given url '/pet/{petId}'
  And request header is empty
  When method 'GET'
  Then status code is 200
  
  And match response body with schema:
    {
      "id": petId,
      "name": "",
      "status": ""
    }

Scenario: Scenario2-PetIDSecurityTestWithErrors
  Given url '/pet/{petId}'
  When method 'GET' using invalid petId (e.g., -1)
  Then status code is 400 or 500 with error message "Invalid ID"