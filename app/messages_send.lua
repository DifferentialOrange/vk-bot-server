local log = require('log')
local json = require('json')
local http_client = require('http.client')

local const = require('app.const')
local utils = require('app.utils')

local function response(object, message)
    log.verbose('Send response to message')

    local params = {
        v = const.VK_API_VERSION,
        access_token = const.VK_COMMUNITY_TOKEN,
        random_id = math.random(1000000),
        peer_id = object.message.peer_id,
        message = message,
    }
    local resp = http_client.post(utils.add_params_to_query(const.VK_API_ENDPOINT .. 'messages.send', params))
    local resp_json = json.decode(resp.body)

    if resp_json.error ~= nil then
        log.error('Got error on message send: %s', resp_json.error.error_msg)
        return nil, resp_json.error.error_msg
    end

    log.verbose('Got OK response')
    return true
end

return {
    response = response
}
