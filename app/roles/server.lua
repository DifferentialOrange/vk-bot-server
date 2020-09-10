local cartridge = require('cartridge')
local confirmation_string = require('app.confirmation_string')

local function init(opts) -- luacheck: no unused args
    -- if opts.is_master then
    -- end

    local httpd = cartridge.service_get('httpd')
    httpd:route(
        { method = 'GET', path = '/hello' },
        function()
            return { body = 'Hello world!' }
        end
    )
    httpd:route(
        { method = 'GET', path = '/api' },
        function(request)
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
    )

    return true
end

local function stop()
end

local function validate_config(conf_new, conf_old) -- luacheck: no unused args
    return true
end

local function apply_config(conf, opts) -- luacheck: no unused args
    -- if opts.is_master then
    -- end

    return true
end

return {
    role_name = 'app.roles.server',
    init = init,
    stop = stop,
    validate_config = validate_config,
    apply_config = apply_config,
    -- dependencies = {'cartridge.roles.vshard-router'},
}
