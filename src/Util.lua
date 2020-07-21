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
