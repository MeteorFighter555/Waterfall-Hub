local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/yarrosvault/landingpod/main/FR"))()

Library.load.CreateLoader({
    Title = "Moonrock Hub",
    Thumbnail = "35500340", -- This must be the ID of the image you want to be the thumbnail.
    Discord = {
        Invite = "rXbGpfuKmV" -- You do not need to have the "https://discord.gg/" part of the invite here, only the code.
    }
})

Library:CreateWindow({
    Title = "Moonrock │ discord.gg/rXbGpfuKmV │ Exploit with style",
    Discord = {
        Invite = "rXbGpfuKmV" -- You do not need to have the "https://discord.gg/" part of the invite here, only the code.
    },
    ConfigSaving = {
        Enabled = true,
        FolderTitle = "Moonrock",
        FileTitle = "Moonrock Hub"
    }
})

local ExampleTab = Library:CreateTab("Moonrock")

local ExampleSection = Library:CreateTabSection("Aimbot")
ExampleSection.CreateSectionTab("Visuals")
ExampleSection.CreateSectionTab("Trolling")
ExampleSection.CreateSectionTab("Misc")
ExampleSection.CreateSectionTab("Settings")

local GroupBox = Tab:CreateGroupBox({Title = "Moonrock", Side = "Left"})

GroupBox:CreateButton({
    Title = "Hello, world!",
    Callback = function()
        print("hello world")
    end
})
