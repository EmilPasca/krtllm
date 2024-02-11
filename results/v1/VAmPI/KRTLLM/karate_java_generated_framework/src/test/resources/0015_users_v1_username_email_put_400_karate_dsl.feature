Feature: API_Security_Test_001-EmailUpdate

Scenario: API_Security_Test_001-EmailUpdate
  Given url 'http://localhost:5000/users/v1/users/v1/{username}/email'
  And headers { "Content-Type": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MTIwMTQxLCJpc3MiOiJodHRwOi8vc2VjdXJpdHkgYXR0cmlidXRlcy5jb20vdGltZS9hcHAuY29tIn0.o7DqF-yv1a4hC_K6zWUkfMwI3rA8mTgXnNpRQ" }
  And request body { "email": "mail3@mail.com" }
  When method PUT
  Then status 200
  And match response contains
  """
  { "status": "fail", "message": "Please Provide a valid email address." }
  """