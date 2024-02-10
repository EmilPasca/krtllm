Feature: API Security Testing Scenario
  Background:
    * URL path: /other/all/live
    * Request headers: {}
    * Request body (if any): {}
  Scenario: [ScenarioID]-[Scenario Name]
    Given url '/other/all/live'
    And request body (if any) is empty
    When method GET
    Then status 200
    And match response body (if any) with expected schema {}