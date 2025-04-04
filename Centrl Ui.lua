local centrl = loadstring(game:HttpGet("https://raw.githubusercontent.com/yarrosvault/CentrlV2/refs/heads/main/centrl",true))()

centrl:load({
    Logo = '14258098097', -- ID Only (required, optional soon)
    ConfigEnabled = {
        Enabled = true, -- If Config Saving is desired leave true
        Cfolder = 'WaterfallHub', -- Folder Name
        Cfile = 'WaterfallConfig' -- Config File Name (credits to rayfield for layout (not skidded)
    },
    Theme = {
        Accent = Color3.fromRGB(33, 89, 194), -- Accent color
        Hitbox =  Color3.fromRGB(234, 9, 215) -- Hitbox color (ex. toggle, slider)
    }
})

local main = centrl:int({
    Title = 'CrudeHub', -- Title of UI
    Sub = 'Pet Sim x' -- Sub Text
})

local Tab = main:IntTab('Main') -- More Features Coming Soon!

local s1 = Tab:IntSection('Main', {
    Side = 'L' -- Side of section ('L' - Left, 'R' - Right)
})
