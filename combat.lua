-- combat.lua

combat = {}

combat.placement = require('placement')
local placement = combat.placement

local E_PlacementTileStates = {
    ["Not Selected"] = 0,
    ["Selected"] = 1
}

local E_Combat_States = {
    ["Placement"] = 0,
    ["Traversal"] = 1,
    ["Execution"] = 2
}

combat.activeTiles = { }
local activeTiles = combat.activeTiles
local currentCombatState = E_Combat_States["Placement"]
local tileSideLength = 32
local numberOfRows = 20
local numberOfColumns = 20

for i = 0, numberOfColumns do activeTiles[i] = {} end

Tile = class(function(self, x, y, tileType)
    self.x = x
    self.y = y
    self.tileType = tileType
    if not tileType then
        self.tileType = "Basic"
    end
    self.state = E_PlacementTileStates["Not Selected"]
end)

AbilityTile = class(Tile, function(self, x, y, ability, parent)
    Tile.init(self, x, y, "Ability")
    self.ability = ability
    self.parent = parent
end)

TileFormation = class(function(self, name)
    self.name = name
    self.tiles = {}
    if self.name == "Sword" then
        self.tiles = {
            { x = 0, y = 0},
            { x = 0, y = 1},
            { x = 0, y = 2},
            { x = 0, y = 3},
            { x = 1, y = 3},
            { x = -1, y = 3},
            { x = 0, y = 4}
        }
    end
end)

function combat.getNumberOfColumns()
    return numberOfColumns
end

function combat.getNumberOfRows()
    return numberOfRows
end

function combat.tileAtLocation(mouse_X, mouse_Y)
    local tile_X, tile_Y = combat.tileUnderMouse_X_And_Y(mouse_X, mouse_Y)
    if activeTiles[tile_X][tile_Y] then
        return true
    end
    return false
end

--Needs Formatting

combat.currentTileFormation = nil
 
function combat.load()
    placement.load()
    
end

function combat.update(dt)

end

function combat.draw()
    love.graphics.draw( background, 0, 0)
    placement.draw()
    love.graphics.setColor(colors.red)
        love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 15, 5)
        
    love.graphics.setColor(colors.aquamarine)--blue)--permanentGreen)
        --[[love.graphics.rectangle("fill", (9 * 32) + 1, (12 * 32) + 1, 30, 30)
        love.graphics.rectangle("fill", (10 * 32) + 1, (12 * 32) + 1, 30, 30)]]
        
    --love.graphics.setColor(colors.purple)
        --love.graphics.rectangle("fill", (14 * 32) + 1, (10 * 32) + 1, 30, 30)
        --love.graphics.rectangle("fill", (14 * 32) + 1, (12 * 32) + 1, 30, 30)
        --love.graphics.rectangle("fill", (14 * 32) + 1, (14 * 32) + 1, 30, 30)
        
   --[[ love.graphics.setColor(colors.yellow)
        love.graphics.rectangle("line", 321, 193, 30, 30)
        love.graphics.rectangle("fill", 289, 225, 30, 30)
        love.graphics.rectangle("fill", 353, 225, 30, 30)
      ]]  
    love.graphics.setColor(colors.white)
    combat.drawActiveTiles()

    --love.graphics.draw(swordTemplate, 800 - swordTemplate:getWidth() / 2, 78)
    --love.graphics.draw(triTemplate, 800 - triTemplate:getWidth() / 2, 267)
    --love.graphics.draw(whirlwindTemplate, 800 - whirlwindTemplate:getWidth() / 2, 456)
end

function combat.mousepressed(x, y, button)
    placement.mousepressed(x, y, button)
end

-- Recent Changes

--Complete for Hard-coded Resolution
function combat.mouseOverGrid(mouse_X, mouse_Y)
    return mouse_X < 640 and mouse_Y < 640
end

--Need to add functionality for ability tiles and selection
function combat.drawActiveTiles()
    local currentColor = {love.graphics.getColor()}
    for x = 0, (numberOfColumns - 1) do
        for y = 0, (numberOfRows - 1) do
            if activeTiles[x][y] then
                if activeTiles[x][y].tileType == "Basic" then
                    if activeTiles[x][y].state == E_PlacementTileStates["Not Selected"] then
                        love.graphics.setColor(colors.aquamarine)
                        love.graphics.rectangle("fill", (x * tileSideLength) + 1, (y * tileSideLength) + 1, 30, 30)
                    end
                end
            end
        end
    end
    love.graphics.setColor(currentColor)
end

--Complete
function combat.tileUnderMouse_X_And_Y(mouse_X, mouse_Y)
    return ( mouse_X - (mouse_X % tileSideLength) ) / tileSideLength, 
                ( mouse_Y - (mouse_Y % tileSideLength) ) / tileSideLength
end

--Complete
--[[local]] function combat.getCombatState()
    return currentCombatState
end

function mouseOverRect(mx, my, x, y, width, height)
    return mx > x and my > y and mx < (x + width) and my < (y + height)
end

return combat