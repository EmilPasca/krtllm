Feature: Delete User API Security Testing
Background:
  * URL path: /users/v1/{username}
  * Request headers: { "Content-Type": "application/json", "Authorization": "Bearer token" }
  * Request body (if any): {}

Scenario: deleteUserSecurity_01 - Successfully Delete User
  Given url /users/v1/{username}
  And request headers { "Content-Type": "application/json", "Authorization": "Bearer token" }
  When method DELETE
  Then status 200
  And match body { "message": "User deleted.", "status": "success" }