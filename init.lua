#!/usr/bin/env tarantool

local log = require('log')

local host_port = os.getenv('PORT') or 8081

local handlers = {
    confirmation = require('app.handler.confirmation'),
    message_new  = require('app.handler.message_new')
}

local function api_handler(request)
    local body = request:json()
    if handlers[body.type] == nil then
        log.verbose('Unsupported request type %s', body.type)
        return {
            status = 200,
            body = ('Request of %s type is not supported'):format(body.type)
        }
    end

    return handlers[body.type](body.object)
end

local server = require('http.server').new(nil, host_port)
server:route({ method = 'POST', path = '/api' }, api_handler)

server:start()

box.cfg{ log_level = 6 }
