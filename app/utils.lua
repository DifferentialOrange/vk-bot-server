-- local url = require('socket.url') -- docker run fails to find package

local function escape(s)
    return tostring(s):gsub('%s', '%%20')
end

local function add_params_to_query(query, map)
    local question_mark_flag = false
    for k, v in pairs(map) do
        if not question_mark_flag then
            query = query .. '?' .. escape(k) .. '=' .. escape(v)
            question_mark_flag = true
        else
            query = query .. '&' .. escape(k) .. '=' .. escape(v)
        end
    end

    return query
end

return {
    add_params_to_query = add_params_to_query,
}
