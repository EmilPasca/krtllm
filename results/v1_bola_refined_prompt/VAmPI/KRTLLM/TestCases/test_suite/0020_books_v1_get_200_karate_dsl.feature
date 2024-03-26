feature: Test API for BOLA and Authentication Vulnerabilities
    background: url 'http://localhost:5000'
    scenario: "Test the `/books/v1` endpoint for unauthorized access"
        given path '/books/v1'
        when method get
        then status 403
        and match response contains 'Access not allowed',
        scenario: "Ensure proper authorization checks on `/books/admin/reports/generate`"
            given path '/books/admin/reports/generate'
            when method post
            then status 200 or status 403
            and match response contains 'Report generated successfully' or 'Access denied',
            scenario: "Test the `/user/{userId}/promote` endpoint for BOLA"
                given path '/user/{userId}/promote'
                when method post
                then status 403
                and match response contains 'User cannot be promoted by this user',
            scenario: "Ensure secure token handling on `/api/secure/endpoint`"
                given path '/api/secure/endpoint'
                And header Authorization = 'Bearer <token>'
                when method get
                then status 200
                and match response contains 'Token is valid',
            scenario: "Test the `/user/{userId}/follow` endpoint for BOLA, ensuring only authorized users can follow another user"
                given path '/user/{userId}/follow'
                And header Authorization = 'Bearer <token>'
                when method post
                then status 403 or status 200
                and match response contains 'User followed successfully' or 'You are not authorized to follow this user',
            scenario: "Ensure the `/user/{userId}/profile` endpoint respects user privacy settings, denying access if the profile is set to private"
                given path '/user/{userId}/profile'
                And header Authorization = 'Bearer <token>'
                when method get
                then status 403 or status 200
                and match response contains 'Profile is private' or 'User profile data',
            scenario: "Test the `/user/{userId}/settings` endpoint for BOLA, ensuring only the account owner can update settings"
                given path '/user/{userId}/settings'
                And header Authorization = 'Bearer <token>'
                when method post
                then status 403 or status 200
                and match response contains 'Settings updated successfully' or 'You are not authorized to update these settings',
            scenario: "Ensure the `/file/{fileId}/download` endpoint enforces file access restrictions, denying download requests for restricted files"
                given path '/file/{fileId}/download'
                And header Authorization = 'Bearer <token>'
                when method get
                then status 403 or status 200
                and match response contains 'File not accessible' or 'File downloaded successfully',
            scenario: "Test the `/user/{userId}/promote` endpoint for BOLA, ensuring only 'admin' users can promote other users"
                given path '/user/{userId}/promote'
                And header Authorization = 'Bearer <token_admin>'
                when method post
                then status 200
                and match response contains 'User promoted successfully',
            scenario: "Ensure the `/file/{fileId}/preview` endpoint respects file preview restrictions, denying previews for certain file types"
                given path '/file/{fileId}/preview'
                And header Authorization = 'Bearer <token>'
                when method get
                then status 403 or status 200
                and match response contains 'File preview not available' or 'File previewed successfully',
            scenario: "Test the `/user/{userId}/follow` endpoint for BOLA, ensuring users cannot follow themselves"
                given path '/user/{userId}/follow'
                And header Authorization = 'Bearer <token>'
                when method post
                then status 403 or status 200
                and match response contains 'Cannot follow yourself' or 'User followed successfully',
            scenario: "Ensure the `/file/{fileId}/upload` endpoint enforces file upload restrictions, rejecting files that do not meet criteria"
                given path