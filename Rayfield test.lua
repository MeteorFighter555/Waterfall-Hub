local ArrayField = loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/MC%3AArrayfield%20Library"))()
--Documentation url: https://docs.sirius.menu/community/arrayfield

local Window = ArrayField:CreateWindow({
        Name = "Waterfall Hub",
        LoadingTitle = "Waterfall Interface Suite",
        LoadingSubtitle = "by Meteorfighter555",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = nil, -- Create a custom folder for your hub/game
            FileName = "Waterfall"
        },
        Discord = {
            Enabled = false,
            Invite = "skibidi", -- The Discord invite code, do not include discord.gg/
            RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
        KeySystem = true, -- Set this to true to use our key system
        KeySettings = {
            Title = "Waterfall Key System",
            Subtitle = "For Private Use Only",
            Note = "Only Special users can get access to the key",
            FileName = "ArrayFieldsKeys",
            SaveKey = false,
            GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like ArrayField to get the key from
            Key = {"U2FsdGVkX1+swGe5EB0AmgaTPqccOA7tc7cTnLJ2pEU="},
            Actions = {
                [1] = {
                    Text = 'No Key link Provided loser',
                    OnPress = function()

                    end,
                }
            },
        }
    })
    local Tab = Window:CreateTab("Home", 4483362458) -- Title, Image
    local Tab2 = Window:CreateTab("Tab Example 2") -- Title, Image
    
