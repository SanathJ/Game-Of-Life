--[[
    Conway's Game Of Life

    -- PlayState Class --

    Author: Sanath Jathanna
    sanathjathanna@gmail.com

    Represents the state of the game in which we are actively playing.
]]

-- Inherits empty methods from base class
LevelInitState = Class{__includes = BaseState}

--[[
    We initialize what's in our LevelInit via a state table that we pass between
    states as we go from creating to playing
]]
function LevelInitState:enter(params)
    -- randomize cells if user has selected that option
    if params.setup == 2 then
        local cells = {}

        -- number of rows
        for i = 1, (VIRTUAL_HEIGHT - 20) / 5 do
            local row = {}

            -- number of columns
            for j = 1, VIRTUAL_WIDTH / 5 do
                -- whether a cell is filled
                local filled = math.random(0, 1) == 0 and false or true
                table.insert(row, filled)
            end
            table.insert(cells, row)
        end

        gStateMachine:change('play', cells)
    end    
end

function LevelInitState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function LevelInitState:render()
    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end