Feature: API Security Testing Scenarios

Scenario: 1.0-SQL_Injection
  Given url 'http://localhost:5000'
  When method GET
  Then status 200
  And match response.message == "VAmPI the Vulnerable API"

Scenario: 2.0-Broken_Authentication
  Given url 'http://localhost:5000/login'
  And request body
  """
  { "username": "admin", "password": "wrong" }
  """
  When method POST
  Then status 401

Scenario: 3.0-CSRF
  Given url 'http://localhost:5000/'
  And headers '{ "X-CSRF-Token": "wrong_token" }'
  When method GET
  Then status 403

Scenario: 4.0-Information_Exposure
  Given url 'http://localhost:5000/users'
  And headers '{ "Authorization": "Bearer wrong_access_token" }'
  When method GET
  Then status 401

Scenario: 5.0-Insecure_Deserialization
  Given url 'http://localhost:5000/users'
  And  headers '{ "Content-Type": "application/x-yaml", "Accept": "text/plain" }'
  When method GET
  Then status 415

Scenario: 6.0-Cross_Site_Scripting
  Given url 'http://localhost:5000/index.html?<script>alert(1)</script>'
  And headers { "X-Content-Type-Options": "nosniff" }
  When method GET
  Then status 200

Scenario: 7.0-Insecure_Direct_Object_Reference
  Given url 'http://localhost:5000/files/private'
  When headers '{ "Authorization": "Bearer valid_access_token" }'
  And method GET
  Then status 403