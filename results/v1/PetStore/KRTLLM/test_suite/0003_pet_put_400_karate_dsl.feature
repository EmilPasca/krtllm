Feature: Pet Update API Security Testing
    Background:
        * URL path: /pet/{id}
        * Request headers: { "Content-Type": "application/json" }
        * Request body (if any): {"name":"doggie","photoUrls":["https://example.com/photo.png"],"tags":[{"id":123,"name":"cat"},{"id":456,"name":"dog"}], "status":"available"}
    Scenario: PUT-PetUpdate-API-Security-Testing
        Given url /pet/{id}
        And request body {"name":"doggie","photoUrls":["https://example.com/photo.png"],"tags":[{"id":123,"name":"cat"},{"id":456,"name":"dog"}], "status":"available"}
        When method PUT
        Then status 200
         And match body { "id" : 40, "category" : {"id": 1, "name": "kitty cats"}, "name": "doggie", "photoUrls": ["https://example.com/photo.png"], "tags": [{"id": 123,"name":"cat"},{"id":456,"name":"dog"}], "status": "available" }