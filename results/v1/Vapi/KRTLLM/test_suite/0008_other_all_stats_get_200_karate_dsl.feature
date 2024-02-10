Feature: API Security Testing Scenario
Background:
  * URL path: /other/all/stats
  * Request headers: None
Scenario: 1-API_Security_Testing
Given url /other/all/stats
And request body {} (No Body)
When method GET
Then status 200
And match response { "description": "successful operation", "content": {} }