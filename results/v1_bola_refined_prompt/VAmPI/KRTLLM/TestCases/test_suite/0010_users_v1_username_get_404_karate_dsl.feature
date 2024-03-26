{
  "feature": "[Feature Name] for BOLA and Auth Vulnerabilities",
  "scenario": "[ScenarioID]-[Scenario Name]",
  "steps": [
    "* url 'http://localhost:5000'",
    "* def generateToken = function() { return java.util.UUID.randomUUID().toString() },",
    "* def usernames = ['userA', 'userB', 'userC'],",
    "* foreach usernames, function(username){",
    "    * url 'http://localhost:5000/users/v1/' + username",
    "    * request { token: generateToken(), userId: username }",
    "    * method GET",
    "    * then status 200 or status 403 or status 404",
    "    * match response contains 'User found' or response contains 'Access denied' or response contains 'User not found',",
    "  }"
  ]} [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "/oauth/refresh", "method": "POST", "summary": "Refreshes access and refresh tokens", "parameters": ["client_id", "client_secret"]}