--[[
    Conway's Game Of Life

    -- Util file --

    Author: Sanath Jathanna
    sanathjathanna@gmail.com

    Utility functions
]]

--[[
    Utility function for slicing tables, a la Python.

    https://stackoverflow.com/questions/24821045/does-lua-have-something-like-pythons-slice
]]
function table.slice(tbl, first, last, step)
    local sliced = {}
  
    for i = first or 1, last or #tbl, step or 1 do
      sliced[#sliced+1] = tbl[i]
    end
  
    return sliced
end

--[[
    Renders the board
]]
function renderBoard(cells)
    love.graphics.setColor(0, 255, 0, 255)
    for i, row in pairs(cells) do
        for j, cell in pairs(row) do
            -- render cell
            local mode = 'line'
            -- if cell is filled
            if cell then 
                mode = 'fill'
            end
            love.graphics.rectangle(mode, (j - 1) * 10, 20 + (i - 1) * 10, 10, 10)
        end
    end
    love.graphics.setColor(255, 255, 255, 255)
end

--[[
    Handles (deep-)copying of tables
    https://stackoverflow.com/a/26367080/11941952
]]
function copy(obj, seen)
    if type(obj) ~= 'table' then
        return obj
    end
    if seen and seen[obj] then
        return seen[obj]
    end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do
        res[copy(k, s)] = copy(v, s)
    end
    return res
end

function neighbours(cells, x, y)
    local count = 0
    for i = math.max(y - 1, 1), math.min(y + 1, (VIRTUAL_HEIGHT - 20) / 10) do
        for j = math.max(x - 1, 1), math.min(x + 1, VIRTUAL_WIDTH / 10) do
            if cells[i][j] and not (i == y and j == x) then
                count = count + 1
            end
        end
    end
    return count
end
