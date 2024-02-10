Feature: API Security Testing Scenario

Background:
  * URL path: /users/v1
  * Request headers: {"Content-Type": "application/json"}

Scenario: Basic_Info_About_All_Users
  Given url '/users/v1'
  And request body {}
  When method GET
  Then status 200

  And match response {email: 'mail1@mail.com', username: 'name1'}