Feature: API Security Testing Scenario
Background:
  * URL path: /pet/{petId}
  * Request headers: None
Scenario: 1-CheckPetById
  Given url '/pet/{petId}'
  And request body {} (No Body Params)
  When method GET
  Then status 200
  And match response { "name": "Fido", "id": 1 }

Feature: API Security Testing Scenario with Error Handling
Background:
  * URL path: /pet/{petId}
  * Request headers: None
Scenario: 2-PetNotFoundError
  Given url '/pet/99' (Invalid pet ID)
  And request body {} (No Body Params)
  When method GET