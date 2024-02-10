Feature: Pet Updation Scenario
 Background: http://petstore.swagger.io/v2/pet/{id}
    Given url /v2/pet/{id}
    And headers {Authorization: "Bearer 1234567890"}
    When method PUT
    Then status 200

 Scenario: Pet Updation-Success
    Given path params id is 123
    And request body {"name": "Jenny", "photoUrls": ["https://example.com/jenny.png"], "tags": [{"id": 1, "name": "cat"}], "status": "available"}
    When method PUT
    Then status 200
        And match body {
            "id": 123,
            "category": {"id": 1, "name": "animal"},
            "name": "Jenny",
            "photoUrls": ["https://example.com/jenny.png"],
            "tags": [{"id": 1, "name": "cat"}],
            "status": "available"
        }