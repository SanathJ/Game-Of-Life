--[[
    Conway's Game Of Life

    -- PlayState Class --

    Author: Sanath Jathanna
    sanathjathanna@gmail.com

    Represents the state of the game in which we are actively playing.
]]

-- Inherits empty methods from base class
PlayState = Class{__includes = BaseState}

-- Cells of the board
local cells

--[[
    We initialize what's in our PlayState via a state table that we pass between
    states as we go from creating to playing
]]
function PlayState:enter(params)
    cells = params.cells
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    renderBoard(cells)

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end