--[[
    Conway's Game Of Life

    -- StartState Class --

    Author: Sanath Jathanna
    sanathjathanna@gmail.com

    Represents the state the game is in when we've just started; should
    simply display "Game Of Life" in large text, as well as a message to press
    Enter to begin set up.
]]

-- Inherits empty methods from base class
StartState = Class{__includes = BaseState}

-- whether we're highlighting "Setup" or "Randomize"
local highlighted = 1

function StartState:update(dt)
    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
    end

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('level-init', {
            setup = highlighted
        })
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    -- title
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("Game Of Life", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')
    
    -- instructions
    love.graphics.setFont(gFonts['medium'])

    -- if we're highlighting 1, render that option blue
    if highlighted == 1 then
        love.graphics.setColor(103, 255, 255, 255)
    end
    love.graphics.printf("Setup", 0, VIRTUAL_HEIGHT / 2 + 70,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(255, 255, 255, 255)

    -- render option 2 blue if we're highlighting that one
    if highlighted == 2 then
        love.graphics.setColor(103, 255, 255, 255)
    end
    love.graphics.printf("Randomize", 0, VIRTUAL_HEIGHT / 2 + 105,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(255, 255, 255, 255)
end