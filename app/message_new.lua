local log = require('log')

local function handler(object)
    log.verbose('Process message_new request')
    log.info(object)

    return {
        status = 200,
        body = 'Ok',
    }
end

return handler