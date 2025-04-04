local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()
local Window = WindUI:CreateWindow({
    Title = "Waterfall Hub", -- UI Title
    Icon = "droplets", -- Url or rbxassetid or lucide
    Author = "Meteorfighter", -- Author & Creator
    Folder = "WaterfallHub", -- Folder name for saving data (And key)
    Size = UDim2.fromOffset(580, 460), -- UI Size
    KeySystem = { -- Creates key system
        Key = "SkibidiSigma", -- key
        Note = "Its SkibidiSigma", -- Note
        URL = "https://discord.gg/vsauztQYNX", -- URL To get key (example: Discord)
        SaveKey = false, -- Saves the key in the folder specified above
    }, 
    Transparent = true,-- UI Transparency
    Theme = "Dark", -- UI Theme
    SideBarWidth = 170, -- UI Sidebar Width (number)
    HasOutline = true, -- Adds Outlines to the window
})

local Tab = Window:Tab({
    Title = "Home",
    Icon = "house", -- lucide or rbxassetid
})

local Section = Tab:Section({ 
    Title = "Universal Scripts",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local Paragraph = Tab:Paragraph({
    Title = "Infinite Yield",
    Desc = "A sophisticated command hub",
    Image = "droplet", -- lucide or URL or rbxassetid://
    ImageSize = 20,
    Buttons = {
        {
            Title = "Execute",
            Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() print("Executed!") end
        },
     
    }
})
