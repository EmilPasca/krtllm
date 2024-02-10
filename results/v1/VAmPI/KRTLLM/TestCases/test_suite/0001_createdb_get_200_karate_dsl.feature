Feature: API Security Testing Scenario
Background:
  * URL path: /createdb
  * Request headers: Content-Type: application/json, Accept: application/json
  * Response status code: 200
  * Expected response body schema (example): { "message": "Database populated." }

Scenario: CSRF_1 - Create and Populate Database with Dummy Data
  Given url /createdb
  And headers Content-Type: application/json, Accept: application/json
  When method POST
  Then status 200
  
  And match body { "message": "Database populated." }