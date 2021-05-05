local log = require('log')

local const = require('app.const')

local function handler(_)
    log.verbose('Process confirmation request')

    if const.VK_BOT_CONFIRMATION == nil then
        log.error('VK_BOT_CONFIRMATION is not set, can not respond to confirmation request')
        return {
            status = 500,
            body = 'VK_BOT_CONFIRMATION is not set'
        }
    end

    return {
        status = 200,
        body = const.VK_BOT_CONFIRMATION,
    }
end

return handler
