Feature: API Security Testing Scenario
 Background: 
 * url: /users/v1/{username}
 * method: GET

Scenario: CSRF-001 - Check for Cross Site Request Forgery vulnerability
 Given path: /users/v1/John.Doe
 And headers: {}
 When method: GET
 Then status: 404

And match body:
{
    "status": "fail",
    "message": "User not found"
}