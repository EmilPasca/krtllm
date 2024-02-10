Feature: Basic_Info_About_All_Users
Scenario: Basic_Info_About_All_Users
  Given url 'http://localhost:5000/users/v1'
  When method GET
  Then status 200