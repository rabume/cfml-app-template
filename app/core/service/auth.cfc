component name="authService" {

    function generateJWT() {
        var validUntil = dateAdd('h', 4, now())
        var startDate = createDateTime('1970', '01', '01', '00', '00', '00')
        var unixStamp = dateDiff('s', startDate, validUntil)

        var payload = {
            'iss': application.issJWT,
            'iat': now(),
            'exp': unixStamp
        }

        var token = application.jwt.encode(payload, application.apiSecret, 'HS256')

        return token
    }

}
