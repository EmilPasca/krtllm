Feature: Update User Password

Scenario: UPDATE_USER_PASSWORD-UpdateUserPassword
  Given url 'http://localhost:5000/users/v1/users/v1/{username}/password'
  And request body '{"password": "pass4"}'
  When method PUT
  Then status 204