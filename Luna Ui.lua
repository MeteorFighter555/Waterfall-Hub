local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()
local Player = game.Players.LocalPlayer
local Window = Luna:CreateWindow({
	Name = "Waterfall Hub", -- This Is Title Of Your Window
	Subtitle = nil, -- A Gray Subtitle next To the main title.
	LogoID = "82795327169782", -- The Asset ID of your logo. Set to nil if you do not have a logo for Luna to use.
	LoadingEnabled = true, -- Whether to enable the loading animation. Set to false if you do not want the loading screen or have your own custom one.
	LoadingTitle = "Waterfall Interface Suite", -- Header for loading screen
	LoadingSubtitle = "by Meteorfighter", -- Subtitle for loading screen

	ConfigSettings = {
		RootFolder = nil, -- The Root Folder Is Only If You Have A Hub With Multiple Game Scripts and u may remove it. DO NOT ADD A SLASH
		ConfigFolder = "Waterfall Hub" -- The Name Of The Folder Where Luna Will Store Configs For This Script. DO NOT ADD A SLASH
	},

	KeySystem = false, -- As Of Beta 6, Luna Has officially Implemented A Key System!
	KeySettings = {
		Title = "Luna Example Key",
		Subtitle = "Key System",
		Note = "Best Key System Ever! Also, Please Use A HWID Keysystem like Pelican, Luarmor etc. that provide key strings based on your HWID since putting a simple string is very easy to bypass",
		SaveInRoot = false, -- Enabling will save the key in your RootFolder (YOU MUST HAVE ONE BEFORE ENABLING THIS OPTION)
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		Key = {"Example Key"}, -- List of keys that will be accepted by the system, please use a system like Pelican or Luarmor that provide key strings based on your HWID since putting a simple string is very easy to bypass
		SecondAction = {
			Enabled = true, -- Set to false if you do not want a second action,
			Type = "Link", -- Link / Discord.
			Parameter = "" -- If Type is Discord, then put your invite link (DO NOT PUT DISCORD.GG/). Else, put the full link of your key system here.
		}
	}
})

local Tab = Window:CreateTab({
	Name = "Universal",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})

Tab:CreateSection("These scripts works almost every game")

local Slider = Tab:CreateSlider({
	Name = "Slider Example",
	Range = {16, 200}, -- The Minimum And Maximum Values Respectively
	Increment = 1, -- Basically The Changing Value/Rounding Off
	CurrentValue = 16, -- The Starting Value
    	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)	
       	 -- The function that takes place when the slider changes
       	 -- The variable (Value) is a number which correlates to the value the slider is currently at
    	end
}, "SpeedSlider") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

local Slider = Tab:CreateSlider({
	Name = "Slider Example",
	Range = {50, 200}, -- The Minimum And Maximum Values Respectively
	Increment = 1, -- Basically The Changing Value/Rounding Off
	CurrentValue = 50, -- The Starting Value
    	Callback = function(Value)
		local plr = game.Players.LocalPlayer
local char = plr.Character
 
char.Humanoid.JumpPower = (Value)
       	 -- The function that takes place when the slider changes
       	 -- The variable (Value) is a number which correlates to the value the slider is currently at
    	end
}, "JumpSlider") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

local ColorPicker = Tab:CreateColorPicker({
	Name = "Tracer Color Picker",
	Color = Color3.fromRGB(86, 171, 128),
	Flag = "TracerColorPicker", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Color)
		_G.TracerColor = Color -- Update tracer color dynamically	
		-- The function that takes place every time the color picker is moved/changed
		-- The variable (Value) is a Color3fromRGB value based on which color is selected
	end
}, "TracerColorPicker") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

local Button = Tab:CreateButton({
	Name = "Tracer Esp",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		       -- Define a global variable to track the state of the tracers
       if _G.TracersEnabled == nil then
           _G.TracersEnabled = false
       end

       local function API_Check()
           if Drawing == nil then
               return "No"
           else
               return "Yes"
           end
       end

       local Find_Required = API_Check()

       if Find_Required == "No" then
           game:GetService("StarterGui"):SetCore("SendNotification", {
               Title = "Meteorfighter";
               Text = "Tracer script could not be loaded because your exploit is unsupported.";
               Duration = math.huge;
               Button1 = "OK"
           })
           return
       end

       local RunService = game:GetService("RunService")
       local Players = game:GetService("Players")
       local Camera = game:GetService("Workspace").CurrentCamera
       local UserInputService = game:GetService("UserInputService")

       _G.SendNotifications = true
       _G.DefaultSettings = false
       _G.TeamCheck = false
       _G.FromMouse = false
       _G.FromCenter = true
       _G.FromBottom = false
       _G.TracersVisible = true
       _G.TracerColor = Color3.fromRGB(255, 255, 255) -- Default color (White)
       _G.TracerThickness = 1
       _G.TracerTransparency = 0.7
       _G.ModeSkipKey = Enum.KeyCode.E
       _G.DisableKey = Enum.KeyCode.Q

       -- Table to store all tracer lines
       local TracerLines = {}

       local function CreateTracers()
           for _, v in next, Players:GetPlayers() do
               if v.Name ~= game.Players.LocalPlayer.Name then
                   local TracerLine = Drawing.new("Line")
                   table.insert(TracerLines, TracerLine)

                   RunService.RenderStepped:Connect(function()
                       if workspace:FindFirstChild(v.Name) and workspace[v.Name]:FindFirstChild("HumanoidRootPart") then
                           local HumanoidRootPart_Position = workspace[v.Name].HumanoidRootPart.CFrame.Position
                           local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart_Position)

                           -- Update tracer properties
                           TracerLine.Thickness = _G.TracerThickness
                           TracerLine.Transparency = _G.TracerTransparency
                           TracerLine.Color = _G.TracerColor -- **Dynamic color update**

                           if _G.FromMouse then
                               TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                           elseif _G.FromCenter then
                               TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                           elseif _G.FromBottom then
                               TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                           end

                           if OnScreen then
                               TracerLine.To = Vector2.new(Vector.X, Vector.Y)
                               if _G.TeamCheck then
                                   if Players.LocalPlayer.Team ~= v.Team then
                                       TracerLine.Visible = _G.TracersVisible and _G.TracersEnabled
                                   else
                                       TracerLine.Visible = false
                                   end
                               else
                                   TracerLine.Visible = _G.TracersVisible and _G.TracersEnabled
                               end
                           else
                               TracerLine.Visible = false
                           end
                       else
                           TracerLine.Visible = false
                       end
                   end)

                   Players.PlayerRemoving:Connect(function()
                       TracerLine.Visible = false
                   end)
               end
           end
       end

       local function ClearTracers()
           for _, TracerLine in pairs(TracerLines) do
               TracerLine:Remove()
           end
           TracerLines = {}
       end

       -- Toggle tracers on/off
       if _G.TracersEnabled then
           ClearTracers()
           _G.TracersEnabled = false
           if _G.SendNotifications then
               game:GetService("StarterGui"):SetCore("SendNotification", {
                   Title = "Meteorfighter";
                   Text = "Tracers have been disabled.";
                   Duration = 5;
               })
           end
       else
           _G.TracersEnabled = true
           CreateTracers()
           if _G.SendNotifications then
               game:GetService("StarterGui"):SetCore("SendNotification", {
                   Title = "Meteorfighter";
                   Text = "Tracers have been enabled.";
                   Duration = 5;
               })
           end
       end	
         -- The function that takes place when the button is pressed
    	end
})

local Button = Tab:CreateButton({
	Name = "Click Tp Tool",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		mouse = game.Players.LocalPlayer:GetMouse()
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Click Teleport"
tool.Activated:connect(function()
local pos = mouse.Hit+Vector3.new(0,2.5,0)
pos = CFrame.new(pos.X,pos.Y,pos.Z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end)
tool.Parent = game.Players.LocalPlayer.Backpack	
         -- The function that takes place when the button is pressed
    	end
})

local Button = Tab:CreateButton({
	Name = "God Mode (some games work)",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		loadstring(game:HttpGet("https://freenote.biz/raw/Fhpx5r5A8M"))()	
         -- The function that takes place when the button is pressed
    	end
})

local Button = Tab:CreateButton({
	Name = "Force Shiftlock",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		loadstring(game:HttpGet('https://pastebin.com/raw/CjNsnSDy'))()	
         -- The function that takes place when the button is pressed
    	end
})

local Button = Tab:CreateButton({
	Name = "R6 Fling",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"))()	
         -- The function that takes place when the button is pressed
    	end
})

local Button = Tab:CreateButton({
	Name = "Mobile Keyboard",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()	
         -- The function that takes place when the button is pressed
    	end
})

local Button = Tab:CreateButton({
	Name = "Infinite Yield",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()	
         -- The function that takes place when the button is pressed
    	end
})

local Button = Tab:CreateButton({
	Name = "Dark Dex Explorer",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		loadstring(game:GetObjects('rbxassetid://2180084478')[1].Source)()	
         -- The function that takes place when the button is pressed
    	end
})

Tab:CreateSection("Server")

local Button = Tab:CreateButton({
	Name = "Server Hop",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

-- If you'd like to use a script before server hopping (Like a Automatic Chest collector you can put the Teleport() after it collected everything.
Teleport()	
         -- The function that takes place when the button is pressed
    	end
})

local Button = Tab:CreateButton({
	Name = "Small Server Hop",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		local Lowest = "ping" -- set to "playing" to find the lowest player server

local HTTPService = game:GetService("HttpService")

local success, servers = pcall(function()
   return HTTPService:JSONDecode(game:HttpGet(
       "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?limit=100"
   )).data
end)

if not success then return end

local server = servers[1]

for i,svr in pairs(servers) do
   if svr[Lowest] < server[Lowest] then
       server = svr
   end
end

game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id)		
   -- The function that takes place when the button is pressed	
         -- The function that takes place when the button is pressed
    	end
})

local Button = Tab:CreateButton({
	Name = "Rejoin",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		local ts = game:GetService("TeleportService")

local p = game:GetService("Players").LocalPlayer



ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, p)	
         -- The function that takes place when the button is pressed
    	end
})

Tab:CreateSection("Shaders")

local Button = Tab:CreateButton({
	Name = "PShader Ultimate",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
	       loadstring(game:HttpGet('https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/src/cd.lua'))()		
         -- The function that takes place when the button is pressed
    	end
})

local Button = Tab:CreateButton({
	Name = "FullBright",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		if not _G.FullBrightExecuted then

	_G.FullBrightEnabled = false

	_G.NormalLightingSettings = {
		Brightness = game:GetService("Lighting").Brightness,
		ClockTime = game:GetService("Lighting").ClockTime,
		FogEnd = game:GetService("Lighting").FogEnd,
		GlobalShadows = game:GetService("Lighting").GlobalShadows,
		Ambient = game:GetService("Lighting").Ambient
	}

	game:GetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
		if game:GetService("Lighting").Brightness ~= 1 and game:GetService("Lighting").Brightness ~= _G.NormalLightingSettings.Brightness then
			_G.NormalLightingSettings.Brightness = game:GetService("Lighting").Brightness
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").Brightness = 1
		end
	end)

	game:GetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
		if game:GetService("Lighting").ClockTime ~= 12 and game:GetService("Lighting").ClockTime ~= _G.NormalLightingSettings.ClockTime then
			_G.NormalLightingSettings.ClockTime = game:GetService("Lighting").ClockTime
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").ClockTime = 12
		end
	end)

	game:GetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
		if game:GetService("Lighting").FogEnd ~= 786543 and game:GetService("Lighting").FogEnd ~= _G.NormalLightingSettings.FogEnd then
			_G.NormalLightingSettings.FogEnd = game:GetService("Lighting").FogEnd
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").FogEnd = 786543
		end
	end)

	game:GetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
		if game:GetService("Lighting").GlobalShadows ~= false and game:GetService("Lighting").GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
			_G.NormalLightingSettings.GlobalShadows = game:GetService("Lighting").GlobalShadows
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").GlobalShadows = false
		end
	end)

	game:GetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
		if game:GetService("Lighting").Ambient ~= Color3.fromRGB(178, 178, 178) and game:GetService("Lighting").Ambient ~= _G.NormalLightingSettings.Ambient then
			_G.NormalLightingSettings.Ambient = game:GetService("Lighting").Ambient
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
		end
	end)

	game:GetService("Lighting").Brightness = 1
	game:GetService("Lighting").ClockTime = 12
	game:GetService("Lighting").FogEnd = 786543
	game:GetService("Lighting").GlobalShadows = false
	game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)

	local LatestValue = true
	spawn(function()
		repeat
			wait()
		until _G.FullBrightEnabled
		while wait() do
			if _G.FullBrightEnabled ~= LatestValue then
				if not _G.FullBrightEnabled then
					game:GetService("Lighting").Brightness = _G.NormalLightingSettings.Brightness
					game:GetService("Lighting").ClockTime = _G.NormalLightingSettings.ClockTime
					game:GetService("Lighting").FogEnd = _G.NormalLightingSettings.FogEnd
					game:GetService("Lighting").GlobalShadows = _G.NormalLightingSettings.GlobalShadows
					game:GetService("Lighting").Ambient = _G.NormalLightingSettings.Ambient
				else
					game:GetService("Lighting").Brightness = 1
					game:GetService("Lighting").ClockTime = 12
					game:GetService("Lighting").FogEnd = 786543
					game:GetService("Lighting").GlobalShadows = false
					game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
				end
				LatestValue = not LatestValue
			end
		end
	end)
end

_G.FullBrightExecuted = true
_G.FullBrightEnabled = not _G.FullBrightEnabled
   -- The function that takes place when the button is pressed	
         -- The function that takes place when the button is pressed
    	end
})

Tab:CreateSection("Extras")

local Button = Tab:CreateButton({
	Name = "Sonic Mode",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		loadstring(game:HttpGetAsync("https://pastebin.com/raw/uacVtsWe"))()	
         -- The function that takes place when the button is pressed
    	end
})

local Button = Tab:CreateButton({
	Name = "Seraphic Sword Gui",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/59mJGQGe/raw"))() --Anim	
         -- The function that takes place when the button is pressed
    	end
})

Window:CreateHomeTab({
	SupportedExecutors = {}, -- A Table Of Executors Your Script Supports. Add strings of the executor names for each executor.
	DiscordInvite = "1234", -- The Discord Invite Link. Do Not Include discord.gg/ | Only Include the code.
	Icon = 1, -- By Default, The Icon Is The Home Icon. If You would like to change it to dashboard, replace the interger with 2
})
