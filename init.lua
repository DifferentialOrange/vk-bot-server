#!/usr/bin/env tarantool

local host_port = os.getenv('PORT') or 8081

local handlers = {
    confirmation = require('app.confirmation'),
    message_new  = require('app.message_new')
}

local function api_handler(request)
    local body = request:json()
    if handlers[body.type] == nil then
        return {
            status = 500,
            body = ('Request of %s type is not supported'):format()
        }
    end

    return handlers[body.type](body.object)
end

local server = require('http.server').new(nil, host_port)
server:route({ method = 'POST', path = '/api' }, api_handler)

server:start()

box.cfg{ log_level = 6 }
