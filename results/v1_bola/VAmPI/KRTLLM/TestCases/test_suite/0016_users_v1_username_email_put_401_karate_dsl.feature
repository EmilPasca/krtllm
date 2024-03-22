feature: Test API for Security Vulnerabilities
    background: url 'http://api.example.com/users/{userId}/security'
    scenario: 'Secure the API Endpoint Against Common Attacks'
        given method post
        and request { userId: 'user123', securityDetails: '123456' }
        when status 200 or status 400
        then match response contains 'Security details updated successfully.' or response contains 'Invalid security details.',
        and assert !response.contains('Error'),
        and assert !response.contains('; DROP TABLE users;'),
        and assert !response.contains('<script>'),
        and assert response.status == 200 || response.status == 400,
        and match response.contains('securityDetails': '123456') or response.contains('securityDetailsUpdateFailed'),
        given method post with request { userId: 'user123', securityDetails: '; DROP TABLE users;' }
        when status 400
        then match response contains 'Security details update failed.',
        and assert !response.contains('Updated successfully.'),
        and assert response.status == 400,
        given method post with request { userId: 'user123', securityDetails: '<script>alert(1)</script>' }
        when status 400
        then match response contains 'Security details update failed.',
        and assert !response.contains('Updated successfully.'),
        and assert response.status == 400,
        given method post with request { userId: '', securityDetails: '' }
        when status 400
        then match response contains 'UserId cannot be empty.',
        and assert response.status == 400,
        given method post with request { userId: 'user123', securityDetails: 'admin' }
        when status 500
        then match response contains 'Internal Server Error.'
        and assert response.status == 500,
        given method post with request { userId: 'user123', securityDetails: 'admin' }
        when header Authorization = 'Bearer <token>'
        then status 200 or status 403
        then match response contains 'Security details updated successfully.' or response contains 'Access denied.',
        and assert !response.contains('Error'),
        and assert !response.contains('; DROP TABLE users;'),
        and assert !response.contains('<script>'),
        and assert response.status == 200 || response.status == 403,
        and match response.contains('securityDetails': 'admin') or response.contains('SecurityUpdateFailed'),
        given method post with request { userId: 'user123', securityDetails: '; DROP TABLE users;' }
        when status 403
        then match response contains 'Security details update failed.',
        and assert !response.contains('Updated successfully.'),
        and assert response.status == 403,
        given method post with request { userId: 'user123', securityDetails: '<script>alert(1)</script>' }
        when status 403
        then match response contains 'Security details update failed.',
        and assert !response.contains('Updated successfully.'),
        and assert response.status == 403,
        given method post with request { userId: '', securityDetails: '' }
        when status 403
        then match response contains 'UserId cannot be empty.',
        and assert response.status == 403,
        given method post with request { userId: 'user123', securityDetails: 'admin' }
        when header Authorization = 'Bearer <token_not_valid>'
        then status 403
        then match response contains 'Invalid token.',
        and assert !response.contains('Updated successfully.'),
        and assert response.status == 403,
        given method post with request { userId: 'user123', securityDetails: 'admin' }
        when header Authorization = 'Bearer <token>'
        then status 200 or status 403
        then match response contains 'Security details updated successfully.' or response contains 'Access denied.',
        and assert !response.contains('Error'),
        and assert !response.contains('; DROP TABLE users;'),
        and assert !response.contains('<script>'),
        and assert response.status == 200 || response.status == 403,
        and