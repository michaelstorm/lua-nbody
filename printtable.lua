printf = function(s,...) return io.write(s:format(...)) end

function ptable(t, name)
    if name ~= nil then
        printf("%s = ", name)
    end
    _ptable(t)
end

function _ptable(t, indent)
    indent = indent or 0;

    local keys = {};

    for k in pairs(t) do
        keys[#keys+1] = k;
        table.sort(keys, function(a, b)
            local ta, tb = type(a), type(b);
            if (ta ~= tb) then
                return ta < tb;
            else
                return a < b;
            end
        end);
    end

    print('{');
    indent = indent + 1;
    for k, v in pairs(t) do
        local key = k;
        if (type(key) == 'string') then
                if not (string.match(key, '^[A-Za-z_][0-9A-Za-z_]*$')) then
                    key = "['"..key.."']";
                end
        elseif (type(key) == 'number') then
            key = "["..key.."]";
        end

        if (type(v) == 'table') then
            if (next(v)) then
                printf("%s%s = ", string.rep('  ', indent), tostring(key));
                _ptable(v, indent);
            else
                printf("%s%s = {},\n", string.rep('  ', indent), tostring(key));
            end 
        elseif (type(v) == 'string') then
            printf("%s%s = %s,\n", string.rep('  ', indent), tostring(key), "'"..v.."'");
        else
            printf("%s%s = %s,\n", string.rep('  ', indent), tostring(key), tostring(v));
        end
    end
    indent = indent - 1;
    print(string.rep('  ', indent)..'}');
end
