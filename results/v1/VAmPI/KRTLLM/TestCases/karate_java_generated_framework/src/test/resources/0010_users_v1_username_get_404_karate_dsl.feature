Feature: CSRF-001 - Check for Cross Site Request Forgery vulnerability
 Scenario: CSRF-001 - Check for Cross Site Request Forgery vulnerability
  Given url 'http://localhost:5000/users/v1/users/v1/John.Doe'
  And headers {}
  When method GET
  Then status 404
  And print response
  And match response ==
   """
    {
      "status": "fail",
      "message": "User not found"
   }
   """