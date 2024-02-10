Feature: API Security Testing Scenario
Background: 
    Given url '/v3.1/all'
    And headers {'Content-Type': 'application/json'}
Scenario: SCENARIOID-API_Security_Testing
    When method POST
    Then status 200
    And match body { "data": [] }