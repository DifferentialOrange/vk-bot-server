local log = require('log')

local confirmation_token = os.getenv('VK_BOT_CONFIRMATION')

local function handler(_)
    log.verbose('Process confirmation request')

    if confirmation_token == nil then
        log.error('VK_BOT_CONFIRMATION is not set, can not respond to confirmation request')
        return {
            status = 500,
            body = 'VK_BOT_CONFIRMATION is not set'
        }
    end

    return {
        status = 200,
        body = confirmation_token,
    }
end

return handler
