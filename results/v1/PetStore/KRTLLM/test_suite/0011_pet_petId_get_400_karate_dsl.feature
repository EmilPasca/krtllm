Feature: API Security Testing Scenario

Background:
  * URL path: /pet/{petId}
  * Request headers: { "Content-Type": "application/json", "Accept": "application/json" }
  * Request body (if any): {}

Scenario: [ScenarioID]-[Scenario Name]:
  Given url '/pet/{petId}'
  And request headers { "Content-Type": "application/json", "Accept": "application/json" }
  When method GET