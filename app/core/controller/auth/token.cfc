component extends="taffy.core.resource" taffy_uri="/auth/token/{apiKey}" {

    authService = new core.service.auth();

    function get(required string apiKey) {
        var apiKeyValid = application.apiKey == arguments.apiKey;

        if (!local.apiKeyValid) {
            return noData().withStatus(401);
        }

        var token = authService.generateJWT();

        return rep(['token': token]);
    }

}
