Feature: API Security Testing Scenario
Background:
  * URL path: /pet/{petId}
  * Request headers: api_key (optional string)
  * Request body: None
Scenario: DELETE-API-Security-Test
  Given url '/pet/{petId}'
  And request header 'api_key' as optional string
  When method DELETE
  Then status code is 404
  And response body matches the schema with petId as required integer in path
  And match error description "Pet not found"