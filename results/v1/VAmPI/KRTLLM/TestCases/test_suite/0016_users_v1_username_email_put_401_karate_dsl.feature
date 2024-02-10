Feature: API Security Testing Scenario
Background:
  * url: /users/v1/{username}/email
  * headers: Authorization: Bearer {token}
Scenario: auth-test01-updateEmail
  Given path '/users/v1/{username}/email'
  And request body {"email": "mail3@mail.com"}
  When method PUT
  Then status 200
  And match response contains {status: 'success', message: 'Updated email successfully'}