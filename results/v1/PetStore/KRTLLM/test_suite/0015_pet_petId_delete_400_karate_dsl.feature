Feature: API Security Testing Scenario
Background:
  * URL path: /pet/{petId}
  * Request headers: api_key (optional)
  * Request body: None
Scenario: DELETE-DeletePetById
  Given url /pet/{petId}
  And request header api_key is optional and type string
  When method DELETE
  Then status code is 400

  And match response body with schema:
    {
      "message": "Invalid ID supplied"
    }