local b64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local inv_b64 = {}

for i = 1, #b64 do
    inv_b64[b64:sub(i, i)] = i - 1
end

function encode(data)
    local result = {}
    local padding = 0
    local i = 1
    while i <= #data do
        local byte1 = data:byte(i)
        local byte2 = data:byte(i + 1) or 0
        local byte3 = data:byte(i + 2) or 0
        local a = byte1 >> 2
        local b = ((byte1 & 3) << 4) | (byte2 >> 4)
        local c = ((byte2 & 15) << 2) | (byte3 >> 6)
        local d = byte3 & 63
        if i + 1 > #data then
            padding = 2
            c = 64
            d = 64
        elseif i + 2 > #data then
            padding = 1
            d = 64
        end
        result[#result + 1] = b64:sub(a + 1, a + 1)
        result[#result + 1] = b64:sub(b + 1, b + 1)
        result[#result + 1] = b64:sub(c + 1, c + 1)
        result[#result + 1] = b64:sub(d + 1, d + 1)
        i = i + 3
    end
    return table.concat(result):sub(1, #result - padding) .. string.rep("=", padding)
end

function decode(data)
    local result = {}
    local i = 1
    while i <= #data do
        local a = inv_b64[data:sub(i, i)]
        local b = inv_b64[data:sub(i + 1, i + 1)]
        local c = inv_b64[data:sub(i + 2, i + 2)]
        local d = inv_b64[data:sub(i + 3, i + 3)]
        result[#result + 1] = string.char((a << 2) | (b >> 4))
        if c ~= 64 then
            result[#result + 1] = string.char(((b & 15) << 4) | (c >> 2))
        end
        if d ~= 64 then
            result[#result + 1] = string.char(((c & 3) << 6) | d)
        end
        i = i + 4
    end
    return table.concat(result)
end


