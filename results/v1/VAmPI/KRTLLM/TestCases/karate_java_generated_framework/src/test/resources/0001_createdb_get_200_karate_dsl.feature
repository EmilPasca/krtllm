Feature: CSRF_1 - Create and Populate Database with Dummy Data


  Scenario: CSRF_1 - Create and Populate Database with Dummy Data
    Given url 'http://localhost:5000/createdb'
    And headers 'Content-Type: application/json, Accept: application/json'
    When method GET
    Then status 200
    And match response.message == "Database populated."