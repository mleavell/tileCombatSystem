--placement.lua

local placement = {}


 local E_Placement_States = {
    ["Tile Placement"] = 0,
    ["Tile Formatting"] = 1
 }
 
local currentPlacementState = E_Placement_States["Tile Placement"]
local placementPoints = 8
local TileFormationMenu = {
    x = 640,
    y = 64,
    width = 320,
    height = 576,
    canvas = love.graphics.newCanvas(width, height)
}

--Complete
local function getPlacementState()
    return currentPlacementState
end

local function HandleTileFormationMenu(x, y)

end

local function mouseOverTileFormationMenu(mx, my)
    return mouseOverRect(mx, my, TileFormationMenu.x, TileFormationMenu.y, 
                    TileFormationMenu.width, TileFormationMenu.height)
                    
end

function placement.replaceTileAtLocation(x, y)

end

function placement.addTileToSelection(mouse_X, mouse_Y)

end

function placement.load()
    love.window.setMode( 960, 640)
    font = love.graphics.newFont(20)
    love.graphics.setFont( font )
    --background = love.graphics.newCanvas(640,640)
    --sidebar = love.graphics.newCanvas(320, 64)
    --tileFormatMenu = love.graphics.newCanvas(320, 576)
    swordTemplate = love.graphics.newImage("/images/Sword.png")
    triTemplate = love.graphics.newImage("/images/Tri.png")
    whirlwindTemplate = love.graphics.newImage("/images/Whirlwind.png")
    
    background = love.graphics.newCanvas(640,640)
    love.graphics.setCanvas(background)
        love.graphics.setColor(colors.deepSkyBlue4)
            love.graphics.rectangle("fill", 0, 0, 640, 640)
            
        love.graphics.setColor(colors.white)
            for i = 0, combat.getNumberOfColumns() do
                if i <= 5 and i > 0 then
                    love.graphics.line( i * 32, 32, i * 32, 640)
                else
                    love.graphics.line( i * 32, 0, i * 32, 640)
                end
            end
            
            for i = 0, combat.getNumberOfRows() do
                love.graphics.line( 0, i * 32, 640, i * 32)
            end
    
    buildCostDisplay = love.graphics.newCanvas(320, 64)
    love.graphics.setCanvas(buildCostDisplay)
        love.graphics.setColor(colors.deepSkyBlue4)
            love.graphics.rectangle("fill", 0, 0, 320, 64)
            
        love.graphics.setColor(colors.white)
            love.graphics.setFont( love.graphics.newFont(30) )
            love.graphics.print("Build Cost: ", 45, 10)
    
    love.graphics.setCanvas(TileFormationMenu.canvas)
        love.graphics.setColor(colors.brownNutmegWoodFinish)
            love.graphics.rectangle("fill", 0, 0, TileFormationMenu.width, TileFormationMenu.height)
            
        love.graphics.setColor(colors.white)
            love.graphics.draw(swordTemplate, TileFormationMenu.width / 2 - swordTemplate:getWidth() / 2, 14)
            love.graphics.draw(triTemplate, TileFormationMenu.width / 2 - triTemplate:getWidth() / 2, 203)
            love.graphics.draw(whirlwindTemplate, TileFormationMenu.width / 2 - whirlwindTemplate:getWidth() / 2, 392)
                
    love.graphics.setCanvas()
        love.graphics.setFont( font )
        love.graphics.setColor(colors.white)
    print(love.window.getMode())
end

function placement.draw()
    love.graphics.draw( buildCostDisplay, 640, 0)
    love.graphics.draw( TileFormationMenu.canvas, 640, 64)
    love.graphics.setColor(colors.white)
        love.graphics.setFont( love.graphics.newFont(30) )
            love.graphics.print(tostring(placement.getPlacementPoints()), 860, 10)
        love.graphics.setFont( font )
end

function placement.mousepressed(x, y, button)
    if button == "l" then
        if getPlacementState() == E_Placement_States["Tile Placement"] then
            if combat.mouseOverGrid(x, y) then
                if not (placement.getPlacementPoints() < 1) then
                    if not combat.tileAtLocation(x, y) then
                        placement.addTileAtLocation(x, y)
                        placement.decrementPlacementPoints()
                    end
                end
            end
             
        elseif getPlacementState() == E_Placement_States["Tile Selection"] then
            if combat.mouseOverGrid(x, y) then
                if combat.tileAtLocation(x, y) then addTileToSelection(x, y) end
                
            end
            
        end
        if mouseOverTileFormationMenu(x, y) then HandleTileFormationMenu(x, y) end
    end
end

function placement.addTileAtLocation(mouse_X, mouse_Y)
    local tile_X, tile_Y = combat.tileUnderMouse_X_And_Y(mouse_X, mouse_Y)
    combat.activeTiles[tile_X][tile_Y] = Tile(tile_X, tile_Y)

end

function placement.getPlacementPoints()
    return placementPoints
end

function placement.decrementPlacementPoints()
    placementPoints = placementPoints - 1
end

return placement