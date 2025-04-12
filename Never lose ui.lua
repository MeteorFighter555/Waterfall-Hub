local Neverlose_Main = loadstring(game:HttpGet"https://github.com/Mana42138/Neverlose-UI/blob/main/Source.lua")()

local Win = Neverlose_Main:Window({
    Title = "NEVERLOSE",
    CFG = "Neverlose",
    Key = Enum.KeyCode.H,
    External = {
        KeySystem = true,
        Key = {
            "Test",
            "Beta"
        }
    }
})

local TabSection1 = Win:TSection("Misc")

local Main = TabSection1:Tab("Main")
local MainSection = Main:Section("Main Section")
local ConfigSection = Main:Section("Config")

local ToggleVar = MainSection:Toggle("Toggle", function(t)
    ValueToggle = t
end)
ToggleVar:Set(true) -- can be true or false

local HelloVar = World:Slider("Hello", 1, 500, 50, function(t)
    ValueSlider = t
end)
HelloVar:Set(75) -- any number within the range 1 - 500 since it has been preset

World:Button("Press Me", function()
    Neverlose_Main:Notify({
    Title = "Neverlose",
    Text = "Yay you pressed me :DD",
    Time = 2 -- in seconds
    })
end)

Config:Colorpicker("Background", Color3.fromRGB(0,20,38), function(t)
    print(t)
end)
