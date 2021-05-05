local function add_params_to_query(query, map)
    local question_mark_flag = false
    for k, v in pairs(map) do
        if not question_mark_flag then
            query = query .. '?' .. k .. '=' .. v
            question_mark_flag = true
        else
            query = query .. '&' .. k .. '=' .. v
        end
    end

    return query
end

return {
    add_params_to_query = add_params_to_query,
}
