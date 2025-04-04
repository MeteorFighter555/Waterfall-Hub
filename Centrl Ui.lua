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
        Hitbox =  Color3.fromRGB(33, 89, 194) -- Hitbox color (ex. toggle, slider)
    }
})

local main = centrl:int({
    Title = 'Waterfall Hub', -- Title of UI
    Sub = 'Almost Professinal Roblox Scripting Hub' -- Sub Text
})

local Tab = main:IntTab('Universal') -- More Features Coming Soon!

local s1 = Tab:IntSection('Universal Scripts', {
    Side = 'L' -- Side of section ('L' - Left, 'R' - Right)
})

s1:createSlider({
	Title = 'Speed Slider',
	Sliders = {
		{
			title = 'Speed',
			range = {1,200},
			increment = 1,
			startvalue = 16,
			callback = function(speed)

				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed

			end,
		},
		{
			title = 'Smoothness',
			range = {1,200},
			increment = 1,
			startvalue = 16,
			callback = function(lol)


			end,
		},
	}
})
