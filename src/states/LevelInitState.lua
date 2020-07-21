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
    Initialisation of cells
]]
function LevelInitState:init()
    -- number of rows
    for i = 1, (VIRTUAL_HEIGHT - 20) / 10 do
        cells[i] = {}
        -- number of columns
        for j = 1, VIRTUAL_WIDTH / 10 do
            cells[i][j] = false
        end
    end
end

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
    end    
end

function LevelInitState:update(dt)  
    -- quit
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    -- start
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', cells)
    end

    -- else handle input to change board
    local button = love.mouse.wasPressed(1)
    if button ~= nil and button[1] then
        local x = button[2]
        local y = button[3]
        if y >= 20 then
            local i = math.floor((y - 20) / 10) + 1
            local j = math.floor(x / 10) + 1
            -- inverts cell at mouse location
            cells[i][j] = not cells[i][j] 
        end
    end
end

function LevelInitState:render()
    renderBoard(cells)

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.printf("Press enter to start", 0, 0, VIRTUAL_WIDTH, 'center')
end