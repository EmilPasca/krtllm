Feature: API Security Testing Scenario

Scenario: [ScenarioID]-[Scenario Name]
  Given url 'http://localhost:5000/users/v1/users/v1/{username}'
  When method DELETE
  Then status 404
  And match responseBody {status: "fail", message: "User not found!"}