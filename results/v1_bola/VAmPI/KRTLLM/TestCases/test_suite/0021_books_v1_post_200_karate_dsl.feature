feature: Test API for Security Vulnerabilities
    background: url 'http://api.example.com/books/v1'
    scenario: "001-Test API for SQL Injection and Broken Authentication"
        given method post
        when request { book_title: 'book99', secret: 'pass1secret' }
        then status 200
        and match response contains 'Book has been added.',
        and assert !response.contains('Error'),
        and assert response.status == 'success',
        given header Authorization = 'Bearer <user_token>'
    scenario: "002-Test API for CSRF"
        when request { book_title: 'book100', secret: 'pass2secret' }
        then status 403
        and match response contains 'CSRF token is invalid or expired.'
        and assert response.status == 'fail',
        given header CSRF-Token = '<valid_csrf_token>'
    scenario: "003-Test API for Access Control"
        when request { book_title: 'book101', secret: 'pass3secret' }
        then status 403
        and match response contains 'User does not have the necessary permissions to perform this action.',
        and assert response.status == 'fail',
        given header Authorization = 'Bearer <user_token_without_adequate_permissions>'
    scenario: "004-Test API for Sensitive Data Exposure"
        when request { book_title: 'book102', secret: 'pass4secret' }
        then status 200
        and match response.contains('Book has been added.'),
        and assert !response.contains('secret'),
        and assert response.status == 'success',
        given header Authorization = 'Bearer <user_token>'
    scenario: "005-Test API for Unauthorized Access"
        when request { book_title: 'book103', secret: 'pass5secret' }
        then status 401
        and match response contains 'Access not authorized.',
        and assert response.status == 'fail',
        given header Authorization = 'Bearer <user_token_not_authorized>'
    scenario: "006-Test API for Insecure Direct Object References"
        when request { book_id: '12345', action: 'delete' }
        then status 403
        and match response contains 'Access not allowed.',
        and assert response.status == 'fail',
        given header Authorization = 'Bearer <user_token>'
    scenario: "007-Test API for Header Manipulation"
        when request { book_title: 'book104', secret: 'pass6secret' }
        and header Custom-Header = 'value'
        then status 200
        and match response.contains('Book has been added.'),
        and assert !response.headers['Set-Cookie'],
        and assert response.status == 'success',
        given header Authorization = 'Bearer <user_token>'
    scenario: "008-Test API for Unhandled Exceptions"
        when request { book_title: '', secret: '' }
        then status 400
        and match response contains 'Invalid request data.',
        and assert response.status == 'fail',
        given header Authorization = 'Bearer <user_token>'
    scenario: "009-Test API for Sensitive Header Exposure"
        when request { book_title: 'book105', secret: 'pass7secret' }
        then status 200
        and match !response.headers['Set-Cookie'],
        and assert response.status == 'success',
        given header Authorization = 'Bearer <user_token>'
    scenario: "010-Test API for Insecure Redirection"
        when request { book_id: '12345', action: 'redirect' }
        then status 302
        and match response.headers['Location'] == 'http://api.example.com/user/dashboard',
        and assert response.status == 'success',
        given header Authorization = 'Bearer <user_token>'
    scenario: "011-Test API for Insecure Directory Listing"
        when method get
        then status 403
        and match response contains 'Access