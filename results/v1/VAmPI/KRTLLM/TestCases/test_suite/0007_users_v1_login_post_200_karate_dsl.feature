Feature: API Security Testing Scenario
    Background:
        * URL path: /users/v1/login
        * Request headers: { "Content-Type": "application/json" }
        * Request body: {"username":"John.Doe", "password":"password123"}

    Scenario: 01-Login_Successful
         Given url /users/v1/login
         And request body {"username":"John.Doe", "password":"password123"}
         When method POST
         Then status 200

         And match response { "auth_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NzAxNjA2MTcsImlhdCI6MTY3MDE2MDU1Nywic3ViIjoiSm9obi5Eb2UiLCJpZCI6IlRlc3QifQ.n17N4AxTbL4_z65-NR46meoytauPDjImUxrLiUMSTQw", "message": "Successfully logged in.", "status": "success" }