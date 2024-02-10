Feature: API Security Testing Scenario
Background: 
    * URL path: /other/holo/live
    * Request headers: [Include any required request headers]
Scenario: S1-SQLInjectionVulnerability
    Given url '/other/holo/live'
    And request body {} (No body params needed)
    When method GET
    Then status 200
    And match responseBody { "message": "Successful operation" }
Scenario: S2-BrokenAuthenticationVulnerability
    Given url '/other/holo/live'
    And request headers [Include any required authentication headers]
    When method GET
    Then status 401 (Unauthorized)
Scenario: S3-CSRFVulnerability
    Given url '/other/holo/live'
    And request body {}
    When method POST { "message": "Attempting CSRF attack" }
    Then status 200
    And match responseBody { "message": "Successful operation" } (Assert that the CSRF attack was successful)