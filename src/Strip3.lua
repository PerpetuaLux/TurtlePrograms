---
--- An advanced version of mine that uses functions and works a little better
---

--- Starts by setting the variable that controls the length of the strip
length = 32
--- And then refueling
turtle.select(2)
turtle.refuel()
turtle.select(1)

--- Then I define the functions, starting with deposit
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
        turtle.forward()
        turtle.digUp()
        turtle.digDown()
        --- Then it checks if it's inventory is full or not
        if turtle.getItemCount() > 0 then
            --- If it is full then it deposits it's items
            deposit()
        end
        --- Finally it makes sure the first slot is selected, and  decrements the length count by 1
        turtle.select(1)
        length = length - 1
    until length == 0
    --- Once it's finished digging it performs one last deposit
    deposit()
end

---The only actual code here is calling the dig function with the length variable
dig(length)


--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by jonathan.
--- DateTime: 17/05/2021 13:07
---