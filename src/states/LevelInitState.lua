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
                if math.random(10) == 7 then
                    filled = true
                end
                cells[i][j] = filled
            end
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
    renderBoard(cells)

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end