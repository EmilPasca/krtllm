Feature: API Security Testing Scenario
Background:
* URL path: /v3.1/alpha
* Request headers: None
Scenario: ScenarioID-API_Security_Testing
Given url /v3.1/alpha
And request body (if any): {}
And headers  : None
When method POST/PUT/GET/DELETE: GET
Then status   : 200
And match body (if any): None

Include only the required Karate DSL code for the java feature scenario code. The scenario should include the endpoint path, request headers, and a JSON body (if required) with all required fields as per the schema. Validate the response to ensure it has the required status code and the response body matches the expected schema.