---
--- A program to harvest wood automatically
---

waitTime = 20

--- Function to deposit the items
function deposit ()
    --- It makes sure slot 1 is selected, which should hold the remote chest, and then places it above itself
    --- It also makes sure the space above it is clear
    turtle.digUp()
    turtle.select(1)
    turtle.placeUp()
    --- It then sets the variable for the repeat block to go through the inventory
    a = 16
    repeat
        --- It selects the next slot, and puts the items into the chest below
        turtle.select(a)
        turtle.dropUp()
        a = a - 1
    until a == 2
    --- Finally it makes sure the first slot is selected, and picks the chest back up
    turtle.select(1)
    turtle.digUp()
end

--- Function to check for wood
function waitForWood ()
    while true do
        --- inspect block in front
        local isBlock, blockData = turtle.inspect()
        --- If there is not block, then plant saplings
        if not isBlock then
            plant()
        else
            --- If there is a block, see if it's wood
            --- If it is wood, then chop
            if blockData.name == "minecraft:spruce_log" then
                chop()
                plant()
            end
        end
        --- After checking and before checking again, wait for 20 seconds to prevent server lag
        sleep(waitTime)
    end
end

--- Function to chop the tree
function chop ()
    --- Move forward once
    turtle.dig()
    turtle.forward()
    --- Dig forward and up and move up until wood is no longer above
    repeat
        local isBlock, _ = turtle.inspect()
        turtle.dig()
        turtle.digUp()
        turtle.up()
    until isBlock == false
    --- Move right and then repeat the process going down
    turtle.turnRight()
    turtle.dig()
    turtle.forward()
    turtle.turnLeft()
    repeat
        turtle.dig()
        turtle.digDown()
        turtle.down()
        local _, blockData = turtle.inspectDown()
    until blockData.name == "minecraft:podzol"
    turtle.dig()
    --- Move back to the starting position
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    turtle.turnLeft()
    --- Deposit wood
    deposit()
end

--- Function to replenish saplings
function plant ()
    --- Select sapling
    turtle.select(2)
    --- Move forward twice, turn right and plant
    turtle.forward()
    turtle.forward()
    turtle.turnRight()
    turtle.place()
    --- Turn right, move forward, then turn around and plant
    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()
    turtle.turnRight()
    turtle.place()
    --- Turn right and plant, then turn right and move forward
    turtle.turnRight()
    turtle.place()
    turtle.turnRight()
    turtle.forward()
    --- Turn around and plant
    turtle.turnRight()
    turtle.turnRight()
    turtle.place()

    turtle.select(1)
end

waitForWood()

---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by jonathan.
--- DateTime: 08/06/2021 09:17
---