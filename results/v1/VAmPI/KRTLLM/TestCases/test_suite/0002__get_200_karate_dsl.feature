Feature: API Security Testing Scenario

Background:
* URL path: /
* Request headers: { "Content-Type": "application/json", "Accept": "application/json" }

Scenario: 1.0-SQL_Injection
Given url '/'
And request body {} (No body needed for GET method)
When method 'GET'
Then status 200

And match response { message: "VAmPI the Vulnerable API", help: "VAmPI is a vulnerable on purpose API. It was created in order to evaluate the efficiency of third party tools in identifying vulnerabilities in APIs but it can also be used in learning/teaching purposes.", vulnerable: 1 }

Scenario: 2.0-Broken_Authentication
Given url '/'
And request body { "username": "admin", "password": "wrong" } (No body needed for GET method)
When method 'POST', path '/login'
Then status 401

Scenario: 3.0-CSRF
Given url '/'
And request body {} (No body needed for GET method)
When method 'GET', headers { "X-CSRF-Token": "wrong_token" }
Then status 403

Scenario: 4.0-Information_Exposure
Given url '/users'
And request body {} (No body needed for GET method)
When method 'GET', headers { "Authorization": "Bearer wrong_access_token" }
Then status 401

Scenario: 5.0-Insecure_Deserialization
Given url '/users'
And request body {} (No body needed for GET method)
When method 'GET', headers { "Content-Type": "application/x-yaml", "Accept": "text/plain" }
Then status 415

Scenario: 6.0-Cross_Site_Scripting
Given url '/'
And request body {} (No body needed for GET method)
When method 'GET', headers { "X-Content-Type-Options": "nosniff" }, path '/index.html?<script>alert(1)</script>'
Then status 200

Scenario: 7.0-Insecure_Direct_Object_Reference
Given url '/files/private'
And request body {} (No body needed for GET method)
When method 'GET', headers { "Authorization": "Bearer valid_access_token" }
Then status 403