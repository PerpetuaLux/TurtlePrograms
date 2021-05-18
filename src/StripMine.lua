---
--- This will be an advanced implementation of Strip3 made in my IDE rather than in-game
---
---

--- First declare variables
maxStrips = 0 --- Maximum number of strips, should be multiple of 2 for efficiency, 0 for unlimited
stripLength = 32 --- Length of strips, 32 default, don't go too high or chunks may not be loaded
preventInefficient = true --- Whether to allow odd multiples of strips, which wastes fuel and is inefficient
direction = 0 --- Which direction relative to where the turtle is facing do you want it to progress, left = 0, right = 1


--- Then I define the functions, starting with deposit, the first 2 are the same as with Strip3
function deposit ()
    --- It makes sure slot 1 is selected, which should hold the remote chest, and then places it below itself
    turtle.select(1)
    turtle.placeDown()
    --- It then sets the variable for the repeat block to go through the inventory
    a = 16
    repeat
        --- It selects the next slot, and puts the items into the chest below
        turtle.select(a)
        turtle.dropDown()
        a = a -1
    until a == 1
    --- Finally it makes sure the first slot is selected, and picks the chest back up
    turtle.select(1)
    turtle.digDown()
end

--- Then I define the dig function
function dig (length)
    --- A repeat block that will go for the length of the parameter variable
    repeat
        --- First it digs in front of itself, then moves into the hole it dug and digs above and below
        turtle.dig()
        --- This is to stop gravel from breaking things
        while turtle.detect() do
            turtle.dig()
            end
        turtle.forward()
        turtle.digUp()
        turtle.digDown()
        --- Then it checks if it's inventory is full or not
        turtle.select(16)
        if turtle.getItemCount() > 0 then
            --- If it is full then it deposits it's items
            deposit()
        end
        --- Finally it makes sure the first slot is selected, and  decrements the length count by 1
        turtle.select(1)
        length = length - 1
    until length == 0
end

function turn()
    if direction == 0 then
        turtle.turnLeft()
        dig(3)
        turtle.turnLeft()
        direction = 1
    elseif direction == 1 then
        turtle.turnRight()
        dig(3)
        turtle.turnRight()
        direction = 0
    end
end

--- Now for the strip function (ooo, saucy)
function strip ()
    --- Clean up the maxStrips if needed
    if preventInefficient then
        if maxStrips % 2 == 1 then
            maxStrips = maxStrips - 1
            if maxStrips == 0 then
                error("Number of Strips cannot be 1 unless preventInefficient is false")
                exit()
            end
        end
    end

    --- Get the maximum number of strips based on fuel
    a = turtle.getFuelLevel()
    fuelStrips = math.floor(a / (stripLength * 1.2))
    --- check if maxStrips is 0, therefore infinite, and then set maxStrips based on fuel level
    if maxStrips == 0 then
        maxStrips = fuelStrips
    else
        --- Set the maxStrips to the lowest of either maxStrips or fuelStrips
        maxStrips = math.min(fuelStrips, maxStrips)
    end

    --- Start strip mining
    strips = maxStrips
    repeat
        --- Digs the strip, turns and moves 3 blocks, then digs back
        dig(stripLength)
        strips = strips - 1
        --- If there is another strip to dig, it loops back
        if strips ~= 0 then
            turn()
            dig(stripLength)
            --- decrements the strips by 1
            strips = strips - 1
        end
        --- If there are more strips to dig, it moves to where the next one will start
        if strips ~= 0 then
           turn()
        end
    until strips == 0
    --- Once it's finished digging it performs one last deposit
    deposit()
end

--- Now the actual code

---Refuels
turtle.select(2)
turtle.refuel()
turtle.select(1)
--- Strips
strip()

---
---
---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by jonathan.
--- DateTime: 17/05/2021 13:42
---