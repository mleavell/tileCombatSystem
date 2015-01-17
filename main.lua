-- main.lua

require 'class'
combat = require('combat')

colors = { 
    white = {255, 255, 255},
    red = {255, 0, 0},
    deepSkyBlue4 = {0,104,139},
    aquamarine = {107, 202, 226},
    permanentGreen = {10, 192, 43},
    blue = {255, 0, 255},
    purple = {85, 26, 139},
    yellow = {255, 255, 0},
    brownNutmegWoodFinish = {102, 51, 0}
 }
 
function love.load()
    combat.load()
    --print(thing)
end

function love.update(dt)

end

function love.draw()
    combat.draw()
end

function love.mousepressed(x, y, button)
    combat.mousepressed(x, y, button)
    
end

print("Placement Points: ",combat.placement.getPlacementPoints())
print(love.window.getMode())
--"C:\Program Files\LOVE\love.exe" "C:\Users\Maurice\Desktop\LuaProjects\LOVETestProjects\TestProject1" --console