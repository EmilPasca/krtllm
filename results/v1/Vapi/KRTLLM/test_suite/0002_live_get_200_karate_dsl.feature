Feature: API Security Testing Scenario
Background: URL path /live, method GET, request body not required, headers not specified.
Scenario: 1-CheckForVulnerabilities
Given url '/live'
And request body not provided
When method 'GET'
Then status 200