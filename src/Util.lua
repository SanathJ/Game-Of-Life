--[[
    Conway's Game Of Life

    -- Util file --

    Author: Sanath Jathanna
    sanathjathanna@gmail.com

    Utility functions
]]

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
