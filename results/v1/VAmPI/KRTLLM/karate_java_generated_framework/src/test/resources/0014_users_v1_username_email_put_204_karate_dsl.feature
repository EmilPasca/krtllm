Feature: Update User Email
  Background:
    * URL path: /users/v1/{username}/email
    * Request headers: { "Content-Type": "application/json", "Authorization": "Bearer token" }
  Scenario: update_user_email_successfully
    Given url '/users/v1/{username}/email'
    And request body '{"email":"mail3@mail.com"}'
    When method PUT
    Then status 204
    And match response { "description": "Sucessfully updated user email", "content": {} }