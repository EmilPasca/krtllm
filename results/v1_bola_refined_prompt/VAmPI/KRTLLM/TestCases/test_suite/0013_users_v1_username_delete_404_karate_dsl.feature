feature: 'Test API for BOLA and Authentication Vulnerabilities'
    background: 'url "http://localhost:5000";'
scenario: 'test the endpoint [/users/{userId}/role] with dynamic authentication tokens to ensure proper authorization checks, avoiding hardcoded endpoints.'
    given path '[/users/{userId}/role]'
    when method GET
    then status 200 or 403
    and match response contains 'Access granted' if status == 200 else 'Access denied',
    and assert response.contains('token='),
    and assert response.headers['Authorization'] == 'Bearer <dynamic_token>'
scenario: 'Ensure the system denies access when an unauthorized user tries to update their role.'
    given path '[/users/{userId}/role]'
    when method POST { userId: 'user13', newRole: 'admin' }
    then status 403
    and match response contains 'Unauthorized action attempted',
    and assert !response.headers['Authorization'],
    and assert response does not contain 'token='
scenario: 'Test the endpoint [/users/{userId}/role] with an unauthorized user to ensure BOLA is properly implemented.'
    given path '[/users/{unauthorizedUserId}/role]'
    when method POST { userId: 'user14', newRole: 'admin' }
    then status 403
    and match response contains 'User does not have the necessary permissions to perform this action.',
    and assert !response.headers['Authorization'],
    and assert response does not contain 'token='
scenario: '[ScenarioID]-Test API for BOLA and Authentication Vulnerabilities'
    given path '[/users/{userId}/role]'
    when method POST { userId: 'user15', newRole: 'admin' }
    then status 200 or 403
    and match response contains 'Access granted' if status == 200 else 'Access denied',
    and assert response.contains('token='),
    and assert response.headers['Authorization'] == 'Bearer <dynamic_token>'
scenario: '[ScenarioID]-Test the endpoint [/users/{userId}/role] with an unauthorized user to ensure BOLA is properly implemented.'
    given path '[/users/{unauthorizedUserId}/role]'
    when method POST { userId: 'user16', newRole: 'admin' }
    then status 403
    and match response contains 'User does not have the necessary permissions to perform this action.',
    and assert !response.headers['Authorization'],
    and assert response does not contain 'token='
scenario: '[ScenarioID]-Test API for BOLA and Authentication Vulnerabilities'
    given path '[/users/{userId}/role]'
    when method POST { userId: 'user17', newRole: 'admin' }
    then status 200 or 403
    and match response contains 'Access granted' if status == 200 else 'Access denied',
    and assert response.contains('token='),
    and assert response.headers['Authorization'] == 'Bearer <dynamic_token>'
scenario: '[ScenarioID]-Test the endpoint [/users/{userId}/role] with an unauthorized user to ensure BOLA is properly implemented.'
    given path '[/users/{unauthorizedUserId}/role]'
    when method POST { userId: 'user18', newRole: 'admin' }
    then status 403
    and match response contains 'User does not have the necessary permissions to perform this action.',
    and assert !response.headers['Authorization'],
    and assert response does not contain 'token='
scenario: '[ScenarioID]-Test API for BOLA and Authentication Vulnerabilities'
    given path '[/users/{userId}/role]'
    when method POST { userId: 'user19', newRole: 'admin' }
    then status 200 or 403
    and match response contains 'Access granted' if status == 200 else 'Access denied',
    and assert response.contains('token='),
    and assert response.headers['Authorization'] == 'Bearer <dynamic_token>'
scenario: '[ScenarioID]-Test the endpoint [/users/{userId}/role] with an unauthorized user to ensure BOLA is properly implemented.'
    given path '[/users/{unauthorizedUserId