Feature: API Security Testing Scenario
Background: URL path /other/niji, Method GET, Request Body empty, Headers not specified
Scenario: 1-API_Security_Test
Given url '/other/niji'
And request body {}
When method 'GET'
Then status 200