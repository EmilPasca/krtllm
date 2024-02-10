Scenario: 1-GetPetById
Given url /pet/{petId}
And request body {}
And headers {Content-Type: application/json}
When method GET
Then status 200
And match response.body == {
    "id": 40,
    "category": {
        "id": 1,
        "name": "doggie"
    },
    "name": "doggie",
    "photoUrls": [
        "https://example.com/photo.png"
    ],
    "tags": [
        {
            "id": 25,
            "name": "available"
        }
    ],
    "status": "pending"
}