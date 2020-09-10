#!/usr/bin/env tarantool

local confirmation_string = require('app.confirmation_string')

local host_port = os.getenv("PORT") or 8081

local function api_handler(request)
    local body = request:json()
    if body.type == 'confirmation' then
        return {
            status = 200,
            body = confirmation_string[body.group_id],
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
