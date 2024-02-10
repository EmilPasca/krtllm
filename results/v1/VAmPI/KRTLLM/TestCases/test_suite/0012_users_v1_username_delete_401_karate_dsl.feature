Feature: API Security Testing Scenario

Background:
  * URL path: /users/v1/{username}
  * Request headers: { "Content-Type": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MTIwMTQxLCJpc3MiOiJodHRwOi8vd3d3LnczLm5ldC5hdXRoZW1lZGlhYmxvYy5jb20vcGVyc29uY2xpbmcubWFjaGFuY2UuY29tIiwibmFtzyI6ImFkbWluIn0.z-J_7R4e3aN1hKkZg85jvwCbxXyPfLnMdBqGHpE3DlY" }
  * Request body: {}
  
Scenario: API_Security_Test_DeleteUser-VulnerabilityChecks
    Given url /users/v1/{username}
    And request headers { "Content-Type": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MTIwMTQxLCJpc3MiOiJodHRwOi8vd3d3LnczLm5ldC5hdXRoZW1lZGlhYmxvYy5jb20vcGVyc29uY2xpbmcubWFjaGFuY2UuY29tIiwibmFtzyI6ImFkbWluIn0.z-J_7R4e3aN1hKkZg85jvwCbxXyPfLnMdBqGHpE3DlY" }
    When method DELETE
    Then status 200
    
    And match body { "status": "fail", "message": "Only Admins may delete users!" }