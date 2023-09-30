component extends="taffy.core.api" {

    // Set global variables read from system environment
    application.apiSecret = server.system.environment['API_SECRET'];
    application.issJWT = server.system.environment['API_NAME'];
    application.apiKey = server.system.environment['API_GLOBAL_KEY'];
    application.datasource = server.system.environment['APP_DATASOURCE'];

    // Add mappings for taffy
    this.mappings['/resources'] = expandPath('./core/controller');
    this.mappings['/taffy'] = expandPath('./taffy');

    // Enable ORM
    this.ormenabled = true
    this.datasource = application.datasource;

    // Set taffy framework settings
    variables.framework = {
        reloadKey: 'reload',
        reloadPassword: server.system.environment['API_RELOAD_PASSWORD'],
        reloadOnEveryRequest: server.system.environment['API_RELOAD_EVERY_REQUEST'],
        disableDashboard: server.system.environment['API_DISABLE_DASHBOARD'],
        disabledDashboardRedirect: '/',
        allowCrossDomain: server.system.environment['API_CROSS_DOMAINS']
    };

    function onApplicationStart() {
        // Initialize jwt-cfml
        application.jwt = new modules.jwtcfml.models.jwt();

        // Set timezone
        setTimezone('UTC+00:00');

        // Needed to not completly override the onApplicationStart() from taffy
        super.onApplicationStart();
    }

    // This function is called after the request has been parsed and all request details are known
    function onTaffyRequest(
        verb,
        cfc,
        requestArguments,
        mimeExt,
        headers
    ) {
        var isValidToken = false;

        // Skip authorization for authtoken and OPTIONS requests
        if (arguments.cfc == 'authtoken' || arguments.verb == 'OPTIONS') {
            return true;
        }

        // Check if authorization header exists
        if (!structKeyExists(arguments.headers, 'Authorization')) {
            return noData().withStatus(401);
        }

        // Remove bearer keyword and parse only token
        local.token = trim(replaceNoCase(arguments.headers.Authorization, 'Bearer', ''));

        // Check if token is valid
        try {
            application.jwt.decode(local.token, application.apiSecret, 'HS256');

            isValidToken = true;
        } catch (any e) {
            isValidToken = false;
        }

        // Return 401 when token isn't valid
        if (!IsValidToken) {
            return noData().withStatus(401);
        }

        return true;
    }

}
