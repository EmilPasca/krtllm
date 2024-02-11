Feature: API Security Testing 01-Login_Successful Scenario
    Scenario: 01-Login_Successful
         Given url 'http://localhost:5000/users/v1/login'
         And headers '{ "Content-Type": "application/json"}'
         And request
         """
         {
            "username": "John.Doe",
            "password": "password123"
          }
         """
         When method POST
         Then status 200
         And match response.status == "success"
