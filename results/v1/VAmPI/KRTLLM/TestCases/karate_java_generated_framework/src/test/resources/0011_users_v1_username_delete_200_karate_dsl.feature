Feature: Delete User API Security Testing

Scenario: deleteUserSecurity_01 - Successfully Delete User
  Given url 'http://localhost:5000/users/v1/users/v1/{username}'
  And request headers '{ "Content-Type": "application/json", "Authorization": "Bearer token" }'
  When method DELETE
  Then status 200
  And match body { "message": "User deleted.", "status": "success" }