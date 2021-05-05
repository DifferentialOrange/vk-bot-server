local log = require('log')
local json = require('json')
local http_client = require('http.client')

local const = require('app.const')

local function response(object, message)
    log.verbose('Send response to message')

    local endpoint = ('%s%s?v=%s&access_token=%s'):format(
        const.VK_API_ENDPOINT, 'messages.send', const.VK_API_VERSION, const.VK_COMMUNITY_TOKEN
    )

    local msg_body = {
        peer_id = object.message.peer_id,
        message = message,
        random_id = math.random(1000000),
    }
    local resp = http_client.post(endpoint, json.encode(msg_body))
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
