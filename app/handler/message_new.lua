local log = require('log')
local fiber = require('fiber')

local messages_send = require('app.messages_send')

local function handler(object)
    log.verbose('Process message_new request')

    fiber.create(messages_send.response, object, 'Hello, I can hear you!')

    return {
        status = 200,
        body = 'Ok',
    }
end

return handler