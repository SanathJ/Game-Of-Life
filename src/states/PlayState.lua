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
    cells = params
    self.paused = false
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('p') then
        self.paused = not self.paused
    end
end

function PlayState:render()
    renderBoard(cells)

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 255, 0, 255)
    
    local word = 'pause'
    if self.paused then
        word = 'unpause'
    end
    
    love.graphics.printf("Press P to " .. word, 0, 0, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end