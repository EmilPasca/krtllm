Feature: API Security Testing Scenario 1-InvalidRequest

Scenario: 1-InvalidRequest
  Given url 'http://localhost:5000/users/v1/register'
  And request
  """
  { "username": "John.Doe", "password": "password123", "email": "user@tempmail.com" }
  """
  When method POST
  Then status: 400
  And match response.message == "Invalid Request"