feature: Secure API Endpoint Against BOLA and Authentication Vulnerabilities
    background: url 'http://localhost:5000'
    scenario: [ScenarioID]-Test API for BOLA and Auth Vulnerabilities on '/users/v1/{username}/password' endpoint with dynamic token handling
         Given path '/users/v1/{username}/password'
         And request { userId: 'user5', newPassword: 'newPass' }
         When method POST
         Then status 200 or 403
         And match response contains 'Password updated successfully.' if status == 200 else 'Access denied.',
         Given header Authorization = 'Bearer <dynamic_token>>'
         And match response.contains('Password updated successfully.') if token is valid else 'Invalid token.',
    Background: url 'http://localhost:5000'
    Scenario: [ScenarioID]-Test API for BOLA and Auth Vulnerabilities on '/users/v1/{username}/profileImage' endpoint with dynamic token handling
         Given path '/users/v1/{username}/profileImage'
         And request { userId: 'user6', imageFile: read('classpath:helpers/sampleImage.jpg') }
         When method POST
         Then status 200 or 403
         And match response contains 'Profile image uploaded successfully.' if status == 200 else 'Access denied.',
         Given header Authorization = 'Bearer <dynamic_token>>'
         And match response.contains('Profile image uploaded successfully.') if token is valid else 'Invalid token.',
    Background: url 'http://localhost:5000'
    Scenario: [ScenarioID]-Test API for BOLA and Auth Vulnerabilities on '/admin/reports/generate' endpoint with dynamic token handling
         Given path '/admin/reports/generate'
         And request { userId: 'admin123', reportType: 'annual' }
         When method POST
         Then status 200 or 403
         And match response contains 'Report generated successfully.' if status == 200 else 'Access denied.',
         Given header Authorization = 'Bearer <dynamic_token>>'
         And match response.contains('Report generated successfully.') if token is valid else 'Invalid token.',
    Background: url 'http://localhost:5000'
    Scenario: [ScenarioID]-Test API for BOLA and Auth Vulnerabilities on '/admin/dashboard' endpoint with dynamic token handling
         Given path '/admin/dashboard'
         And header Authorization = 'Bearer <dynamic_token>>'
         When method GET
         Then status 200 or 403
         And match response contains 'Admin Dashboard' if status == 200 else 'Access denied.',
    Background: url 'http://localhost:5000'
    Scenario: [ScenarioID]-Test API for BOLA and Auth Vulnerabilities on '/user/profile' endpoint with dynamic token handling
         Given path '/user/profile'
         And header Authorization = 'Bearer <dynamic_token>>'
         When method GET
         Then status 200 or 403
         And match response contains 'User Profile' if status == 200 else 'Access denied.',
    Background: url 'http://localhost:5000'
    Scenario: [ScenarioID]-Test API for BOLA and Auth Vulnerabilities on '/guest/home' endpoint with dynamic token handling
         Given path '/guest/home'
         And header Authorization = 'Bearer <dynamic_token>>'
         When method GET
         Then status 200 or 403
         And match response contains 'Guest Homepage' if status == 200 else 'Access denied.',
    Background: url 'http://localhost:5000'
    Scenario: [ScenarioID]-Test API for BOLA and Auth Vulnerabilities on '/admin/reports/{reportId}/download' endpoint with dynamic token handling
         Given path '/admin/reports/{reportId}/download'
         And header Authorization = 'Bearer <dynamic_token>>'
         When method GET
         Then status 200 or 403
         And match response.contains('Report downloaded successfully.') if status == 200 else 'Access denied.',
    Background: url 'http://localhost: