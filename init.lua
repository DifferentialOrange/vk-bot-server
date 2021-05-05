#!/usr/bin/env tarantool

local host_port = os.getenv('PORT') or 8081
local confirmation_token = os.getenv('VK_BOT_CONFIRMATION')

local function api_handler(request)
    local body = request:json()
    if body.type == 'confirmation' then
        if confirmation_token == nil then
            return {
                status = 500,
                body = 'VK_BOT_CONFIRMATION not set'
            }
        end
        return {
            status = 200,
            body = confirmation_token,
        }
    else
        return {
            status = 500,
            body = 'Not implemented yet'
        }
    end
end

local server = require('http.server').new(nil, host_port)
server:route({ method = 'POST', path = '/api' }, api_handler)

server:start()
