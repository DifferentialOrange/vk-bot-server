local confirmation_token = os.getenv('VK_BOT_CONFIRMATION')

local function handler(_)
    if confirmation_token == nil then
        return {
            status = 500,
            body = 'VK_BOT_CONFIRMATION is not set'
        }
    end

    return {
        status = 200,
        body = confirmation_token,
    }
end

return handler
