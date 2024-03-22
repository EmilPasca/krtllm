feature: 'API Security Testing with Karate DSL'
scenario: 'Test API for SQL Injection and Broken Authentication vulnerabilities'
steps: [
    * def username = 'user987',
    * def password = 'pass123456',
    * def newPassword = 'newPass7890',
    given url 'http://api.example.com/users/{username}/password'
    and header Authorization = 'Bearer <token>'
    when method post { password: 'oldPass', newPassword: 'newPass' }
    then status 403
    and match response contains 'Invalid password or token'
    * def maliciousQuery = ' OR 1=1',
    when method post { password: maliciousQuery, newPassword: 'newPass' }
    then status 500
    and match response contains 'SQL error'
} [
feature: 'API Security Testing with Karate DSL'
scenario: 'Test API for CSRF vulnerabilities'
steps: [
    * def sessionToken = 'session123',
    given url 'http://api.example.com/session/{sessionToken}/validate'
    and header Authorization = 'Bearer <token>'
    when method get {}
    then status 403
    and match response contains 'Invalid session token'
} [
feature: 'API Security Testing with Karate DSL'
scenario: 'Test API for Access Control vulnerabilities'
steps: [
    * def userId = 'user5',
    given url 'http://api.example.com/admin/{userId}/panel'
    and header Authorization = 'Bearer <token_of_regular_user>'
    when method get {}
    then status 403
    and match response contains 'Access denied'
} [
feature: 'API Security Testing with Karate DSL'
scenario: 'Test API for Sensitive Data Exposure vulnerabilities'
steps: [
    * def userId = 'user12',
    given url 'http://api.example.com/users/{userId}/profile'
    and header Authorization = 'Bearer <token>'
    when method get {}
    then status 200
    and match response contains 'User profile data'
} [
feature: 'API Security Testing with Karate DSL'
scenario: 'Test API for Insecure Direct Object References vulnerabilities'
steps: [
    * def documentId = 'doc18',
    given url 'http://api.example.com/docs/{documentId}/content'
    and header Authorization = 'Bearer <token>'
    when method get {}
    then status 403
    and match response contains 'Access not allowed'
} [
feature: 'API Security Testing with Karate DSL'
scenario: 'Test API for Unauthorized Data Access vulnerabilities'
steps: [
    * def userId = 'user15',
    given url 'http://api.example.com/users/{userId}/privateInfo'
    and header Authorization = 'Bearer <token_of_another_user>'
    when method get {}
    then status 403
    and match response contains 'Access not authorized'
} [
feature: 'API Security Testing with Karate DSL'
scenario: 'Test API for Insecure Redirection vulnerabilities'
steps: [
    * def userId = 'user20',
    given url 'http://api.example.com/users/{userId}/redirect'
    and header Authorization = 'Bearer <token>'
    when method get {}
    then status 302
    and match header Location == 'http://api.example.com/user/dashboard'
} [
feature: 'API Security Testing with Karate DSL'
scenario: 'Test API for Header Manipulation vulnerabilities'
steps: [
    * def userId = 'user25',
    given url 'http://api.example.com/headers/{userId}/manipulate'
    and header Authorization = 'Bearer <token>'
    when method post {}
    then status 403
    and match response contains 'Header manipulation not allowed'
} [
feature: 'API Security Testing with Karate DSL'
scenario: 'Test API for Insecure Directory Listing vulnerabilities'
steps: [
    * def rootPath = '/