Feature: API Security Testing Scenario
Background:
  * URL path: /v3.1/region
  * Request headers: { "Content-Type": "application/json", "Accept": "application/json" }
Scenario: [ScenarioID]-[Scenario Name]
    Given url '/v3.1/region'
    And request body {} (No Body Params)
    When method GET
    Then status 200
    And match response { "data": [] } (Empty Response Body)