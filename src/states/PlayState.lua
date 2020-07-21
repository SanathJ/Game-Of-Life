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
    self.timer = 0
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('p') then
        self.paused = not self.paused
    end

    if self.paused then return end

    -- Updates game every TICK_RATE seconds
    self.timer = self.timer + dt
    if self.timer >= TICK_RATE then
        self.timer = self.timer % TICK_RATE
        -- Game logic
        local cells_copy = {}
        -- Number of rows
        for i = 1, (VIRTUAL_HEIGHT - 20) / 10 do
            cells_copy[i] = {}
            -- Number of columns
            for j = 1, VIRTUAL_WIDTH / 10 do
                local cell = false
                local neighbour_count = neighbours(cells, j, i)
                -- Any live cell with two or three live neighbours survives.
                if cells[i][j] and (neighbour_count == 2 or neighbour_count == 3) then
                    cell = true
                -- Any dead cell with three live neighbours becomes a live cell.
                elseif not cells[i][j] and neighbour_count == 3 then
                    cell = true
                end
                -- All other cells die or stay dead

                cells_copy[i][j] = cell
            end
        end
        cells = cells_copy
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