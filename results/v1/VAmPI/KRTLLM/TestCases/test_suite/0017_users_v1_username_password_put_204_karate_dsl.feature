Feature: Update User Password
Background:
  * URL path: /users/v1/{username}/password
  * Request headers: { "Content-Type": "application/json", "Authorization": "Bearer TOKEN" }

Scenario: UPDATE_USER_PASSWORD-UpdateUserPassword
  Given url '/users/v1/{username}/password'
  And request body '{"password": "pass4"}'
  When method PUT
  Then status 204
    * Description: Sucessfully updated users password