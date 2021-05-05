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

    if resp.status ~= 200 then
        log.warn('Got status %d on message send: %s', resp.status, resp.body)
        return nil, json.decode(resp.body)
    end

    log.verbose('Got OK response')
    return true
end

return {
    response = response
}
