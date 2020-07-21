--[[
    Conway's Game Of Life

    -- PlayState Class --

    Author: Sanath Jathanna
    sanathjathanna@gmail.com

    Represents the state of the game in which we are actively playing.
]]

-- Inherits empty methods from base class
LevelInitState = Class{__includes = BaseState}

local cells = {}

--[[
    We initialize what's in our LevelInit via a state table that we pass between
    states as we go from creating to playing
]]
function LevelInitState:enter(params)
    -- randomize cells if user has selected that option
    if params.setup == 2 then
        -- number of rows
        for i = 1, (VIRTUAL_HEIGHT - 20) / 10 do
            cells[i] = {}

            -- number of columns
            for j = 1, VIRTUAL_WIDTH / 10 do
                -- whether a cell is filled
                local filled = false
                if math.random(15) == 7 then
                    filled = true
                end
                cells[i][j] = filled
            end
        end

    -- else set all cells to empty
    else
        -- number of rows
        for i = 1, (VIRTUAL_HEIGHT - 20) / 10 do
            cells[i] = {}
            -- number of columns
            for j = 1, VIRTUAL_WIDTH / 10 do
                cells[i][j] = false
            end
        end
    end    
end

function LevelInitState:update(dt)
    
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function LevelInitState:render()
    renderBoard(cells)

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.printf("Press enter to start", 0, 0, VIRTUAL_WIDTH, 'center')
end