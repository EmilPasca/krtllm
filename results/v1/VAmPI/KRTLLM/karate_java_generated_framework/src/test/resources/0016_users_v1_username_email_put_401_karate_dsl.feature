Feature: auth-test01-updateEmail

Scenario: auth-test01-updateEmail
  Given url 'http://localhost:5000/users/v1/users/v1/{username}/email'
  And request body {"email": "mail3@mail.com"}
  When method PUT
  Then status 200
  And match response contains
  """
  {status: 'success', message: 'Updated email successfully'}
  """