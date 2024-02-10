Feature: Pet Image Upload API Security Testing
    Background:
        * URL path: /pet/{petId}/uploadImage
        * Request headers: {Authorization: Bearer TOKEN}

    Scenario: 1-UploadPetImage
        Given url /pet/{petId}/uploadImage
        And request body: {"file": "binary", "additionalMetadata": "Additional data to pass to server"}
        When method POST
        Then status: 200
         And match body: {code: 200, type: "success", message: "successful operation"}