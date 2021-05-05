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

    if resp.status ~= 200 then
        log.error('Got %d error on message send: %s', resp.status, resp.body)
        return nil, resp.body
    end

    local json_status, resp_body = pcall(json.decode, resp.body)
    if not json_status then
        resp_body = resp.body
    end

    if (type(resp_body) == 'table') and (resp_body.error ~= nil) then
        log.error('Got error on message send: %s', resp_body.error.error_msg)
        return nil, resp_body.error.error_msg
    end

    log.verbose('Got OK response')
    return true
end

return {
    response = response
}
