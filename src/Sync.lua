---
--- A program meant to fetch and if needed update my various programs automatically - pastebin get hv06VNpm sync
---

--- It's possible to make a table containing tables containing the strings for things, and then just iterate through it instead of manually setting all the stuff, but I wont, I'm lazy

--- Create the strings for all the filenames
consumeLocation = '/consume.lua'
tunnelLocation = '/tunnel.lua'
stripMineLocation = '/stripmine.lua'
tunnelTorchLocation = '/tunneltorch.lua'
stripTorchLocation = '/striptorch.lua'
woodcutterLocation = '/woodcutter.lua'

--- Create strings for all the url locations
consumeURL = "https://raw.githubusercontent.com/PerpetuaLux/TurtlePrograms/main/src/Consume.lua"
tunnelURL = "https://raw.githubusercontent.com/PerpetuaLux/TurtlePrograms/main/src/Tunnel.lua"
stripMineURL = "https://raw.githubusercontent.com/PerpetuaLux/TurtlePrograms/main/src/StripMine.lua"
tunnelTorchURL = "https://raw.githubusercontent.com/PerpetuaLux/TurtlePrograms/main/src/TunnelTorch.lua"
stripTorchURL = "https://raw.githubusercontent.com/PerpetuaLux/TurtlePrograms/main/src/StripTorch.lua"
woodcutterURL = "https://raw.githubusercontent.com/PerpetuaLux/TurtlePrograms/main/src/Woodcutter.lua"

--- Create strings for all the plaintext names
consumeName = 'Consume'
tunnelName = 'Tunnel'
stripMineName = 'StripMine'
tunnelTorchName = 'TunnelTorch'
stripTorchName = 'StripTorch'
woodcutterName = 'Woodcutter'

--- A function to update the code
function updateCode(code, location, name)
    --- Check if the file already exists, and if it doesn't make it and place the appropriate code inside

    if not (fs.exists(location)) then
        local newFile = fs.open(location, 'w')
        newFile.write(code)
        print(name .. " has been created")
        --- If it does, put it into a variable as old code to be compared later
    else
        local currentFile = fs.open(location, 'r')
        local oldCode = currentFile.readAll()
        currentFile.close()

        local newFile = fs.open(location, 'w')

        --- Then compare the new code with the old code to see if there are changes
        --- If there are, update it and print some info about the changes (bytes changed) if not then print that there are no changes
        ---
        if oldCode == code then
            newFile.write(code)
            print("No changes made to " .. name)
        else
            newFile.write(code)
            print("Writing code to " .. name)
            bytesChanged = string.len(code) - string.len(oldCode)

            if bytesChanged >= 0 then
                print(tostring(math.abs(bytesChanged)) .. " bytes added to " .. name)
            else
                print(tostring(math.abs(bytesChanged)) .. " bytes removed from " .. name)
            end
        end
    end
end

--- A function to get the file from the internet
function getFile(url)
    --- Download the files, using Cache-Control = no-store to make sure it's always a fresh file
    --- Check if file downloaded or Errored out, if Errored then print the error
    local response, consumeError = http.get(url, { ["Cache-Control"] = "no-store" })
    if response == nil then
        error(consumeError)
    end
    return response.readAll()
end

--- Put the files into variables that can be used later
consumeCode = getFile(consumeURL)
tunnelCode = getFile(tunnelURL)
stripMineCode = getFile(stripMineURL)
tunnelTorchCode = getFile(tunnelTorchURL)
stripTorchCode = getFile(stripTorchURL)
woodcutterCode = getFile(woodcutterURL)

--- Checks if the code is present, if it is it updates the code
if consumeCode ~= nil then
    updateCode(consumeCode, consumeLocation, consumeName)
end
if tunnelCode ~= nil then
    updateCode(tunnelCode, tunnelLocation, tunnelName)
end
if stripMineCode ~= nil then
    updateCode(stripMineCode, stripMineLocation, stripMineName)
end
if tunnelTorchCode ~= nil then
    updateCode(tunnelTorchCode, tunnelTorchLocation, tunnelTorchName)
end
if stripTorchCode ~= nil then
    updateCode(stripTorchCode, stripTorchLocation, stripTorchName)
end
if woodcutterCode ~= nil then
    updateCode(woodcutterCode, woodcutterLocation, woodcutterName)
end

---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by jonathan.
--- DateTime: 07/06/2021 09:43
---