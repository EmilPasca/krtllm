Feature: Pet Updating API Security Testing Scenario
Background:
  * URL path: /pet/{petId}
  * Request headers: None
  * Request body (if any): {"name": "Updated Name", "status": "Updated Status"}

Scenario: PUT-PetUpdatingAPI_SecurityTest1
  Given url /pet/{petId}
  And request body {"name": "Updated Name", "status": "Updated Status"}
  When method PUT
  Then status 200

  And match response body has "name" and "status" fields with the given values in Background