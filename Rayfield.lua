local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Player = game.Players.LocalPlayer
local Window = Rayfield:CreateWindow({
   Name = "Waterfall Hub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Waterfall Interface Suite",
   LoadingSubtitle = "by Meteorfighter",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Waterfall Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

Rayfield:Notify({
   Title = "Welcome To Waterfall Hub"..Player.Name..".",
   Content = "Thank You for using this "..Player.Name..".",
   Duration = 5,
   Image = House,
})

local HomeTab = Window:CreateTab("Home", 4483362458) -- Title, Image

local Label = HomeTab:CreateLabel("Waterfall Hub – The Ultimate Universal Exploit Hub", 4483362458, Color3.fromRGB(0, 0, 0), false) -- Title, Icon, Color, IgnoreTheme
local Label = HomeTab:CreateLabel("You are logged in as "..Player.Name..".", 4483362458, Color3.fromRGB(0, 0, 0), false) -- Title, Icon, Color, IgnoreTheme
local Button = HomeTab:CreateButton({
   Name = "Destroy Hub",
   Callback = function()
         Rayfield:Destroy()
         
   end,
})

local Button = HomeTab:CreateButton({
   Name = "Reset Character",
   Callback = function()
         --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
loadstring(game:HttpGet("https://raw.githubusercontent.com/2sneaky/rbxscripts.github.io/refs/heads/main/simple_reset"))()
         
   end,
})

local Button = HomeTab:CreateButton({
   Name = "Server Hop",
   Callback = function()
         
--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
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
         
   end,
})

local Button = HomeTab:CreateButton({
   Name = "Small Server Hop",
   Callback = function()
	--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
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
   end,
})

local Button = HomeTab:CreateButton({
   Name = "Rejoin",
   Callback = function()
         
local ts = game:GetService("TeleportService")

local p = game:GetService("Players").LocalPlayer



ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, p)
         
   end,
})

local UniTab = Window:CreateTab("Universal", 4483362458) -- Title, Image

local Label = UniTab:CreateLabel("Core Features", 4483362458, Color3.fromRGB(0, 0, 0), false) -- Title, Icon, Color, IgnoreTheme

local Slider = UniTab:CreateSlider({
   Name = "Speed Slider",
   Range = {16, 200},
   Increment = 1,
   Suffix = "Speed Value",
   CurrentValue = 16,
   Flag = "SpeedSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   -- The function that takes place when the slider changes
   -- The variable (Value) is a number which correlates to the value the slider is currently at
   end,
})

Slider:Set(16) -- The new slider integer value

local Slider = UniTab:CreateSlider({
   Name = "Jump Slider",
   Range = {50, 200},
   Increment = 1,
   Suffix = "Jump Value",
   CurrentValue = 50,
   Flag = "JumpSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
          local plr = game.Players.LocalPlayer
local char = plr.Character
 
char.Humanoid.JumpPower = (Value)
   -- The function that takes place when the slider changes
   -- The variable (Value) is a number which correlates to the value the slider is currently at
   end,
})

Slider:Set(50) -- The new slider integer value

local ColorPicker = UniTab:CreateColorPicker({
    Name = "Tracer Color Picker",
    Color = Color3.fromRGB(255,255,255),
    Flag = "TracerColor",
    Callback = function(Color)
        _G.TracerColor = Color -- Update tracer color dynamically
    end
})

local Button = UniTab:CreateButton({
   Name = "Tracker Esp",
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
   end,
})


local Button = UniTab:CreateButton({
   Name = "Click TP Tool",
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
   end,
})

local Button = UniTab:CreateButton({
   Name = "God Mode (Some games work)",
   Callback = function()
	--[[

     FE GodMode

     By: Unknown

]]--



local GodMode_IIIiil=select;local GodMode_iiiIllIllIilii=string.byte;local GodMode_illiIIIilIliilii=string.sub;local GodMode_IIIIIliiillIIiiI=string.char;local GodMode_lIIliIiliIIii=type;local GodMode_ilIiIlliiiIiiIiiliI=table.concat;local unpack=unpack;local setmetatable=setmetatable;local pcall=pcall;local GodMode_IlIll,GodMode_lIIIIiIl,GodMode_iIlliililiIIIll,GodMode_IlIlIiiili;if bit and bit.bxor then GodMode_IlIll=bit.bxor;GodMode_lIIIIiIl=function(GodMode_liiIiiIIiIllI,GodMode_lillIIiliIiI)local GodMode_IIiIlIllIiilIIIlll=GodMode_IlIll(GodMode_liiIiiIIiIllI,GodMode_lillIIiliIiI)if GodMode_IIiIlIllIiilIIIlll<0 then GodMode_IIiIlIllIiilIIIlll=4294967296+GodMode_IIiIlIllIiilIIIlll end;return GodMode_IIiIlIllIiilIIIlll end else GodMode_IlIll=function(GodMode_liiIiiIIiIllI,GodMode_lillIIiliIiI)local GodMode_iIIiIIIllillIll=function(GodMode_IiliIIiIIIIlilllliI,GodMode_illillIlillIllIl)return GodMode_IiliIIiIIIIlilllliI%(GodMode_illillIlillIllIl*2)>=GodMode_illillIlillIllIl end;local GodMode_iiliiI=0;for GodMode_lIlIIiiilIili=0,31 do GodMode_iiliiI=GodMode_iiliiI+(GodMode_iIIiIIIllillIll(GodMode_liiIiiIIiIllI,2^GodMode_lIlIIiiilIili)~=GodMode_iIIiIIIllillIll(GodMode_lillIIiliIiI,2^GodMode_lIlIIiiilIili)and 2^GodMode_lIlIIiiilIili or 0)end;return GodMode_iiliiI end;GodMode_lIIIIiIl=GodMode_IlIll end;GodMode_iIlliililiIIIll=function(GodMode_IllIIlIliIIl,GodMode_IiiliiIIIiliIIl,GodMode_lIiIIiIliil)return(GodMode_IllIIlIliIIl+GodMode_IiiliiIIIiliIIl)%GodMode_lIiIIiIliil end;GodMode_IlIlIiiili=function(GodMode_IllIIlIliIIl,GodMode_IiiliiIIIiliIIl,GodMode_lIiIIiIliil)return(GodMode_IllIIlIliIIl-GodMode_IiiliiIIIiliIIl)%GodMode_lIiIIiIliil end;local function GodMode_IIliIlIliiliiliIIi(GodMode_IIiIlIllIiilIIIlll)if GodMode_IIiIlIllIiilIIIlll<0 then GodMode_IIiIlIllIiilIIIlll=4294967296+GodMode_IIiIlIllIiilIIIlll end;return GodMode_IIiIlIllIiilIIIlll end;local getfenv=getfenv;if not getfenv then getfenv=function()return _ENV end end;local GodMode_IIIIlliiIlIliIlil={}local GodMode_IlliliilIIIl={}local GodMode_liIilI;local GodMode_lIilIiIlill;local GodMode_lIllIliiiilllIlllI={}local GodMode_IIiiliIII={}for GodMode_lIlIIiiilIili=0,255 do local GodMode_IIiiIIliiiilllIllIil,GodMode_IlIlIili=GodMode_IIIIIliiillIIiiI(GodMode_lIlIIiiilIili),GodMode_IIIIIliiillIIiiI(GodMode_lIlIIiiilIili,0)GodMode_lIllIliiiilllIlllI[GodMode_IIiiIIliiiilllIllIil]=GodMode_IlIlIili;GodMode_IIiiliIII[GodMode_IlIlIili]=GodMode_IIiiIIliiiilllIllIil end;local function GodMode_lIIlllli(GodMode_IIIIIIlI,GodMode_IllIiIiIillIIi,GodMode_iIIlilliii,GodMode_ilIIiiiiIIiIIIIllIII)if GodMode_iIIlilliii>=256 then GodMode_iIIlilliii,GodMode_ilIIiiiiIIiIIIIllIII=0,GodMode_ilIIiiiiIIiIIIIllIII+1;if GodMode_ilIIiiiiIIiIIIIllIII>=256 then GodMode_IllIiIiIillIIi={}GodMode_ilIIiiiiIIiIIIIllIII=1 end end;GodMode_IllIiIiIillIIi[GodMode_IIIIIliiillIIiiI(GodMode_iIIlilliii,GodMode_ilIIiiiiIIiIIIIllIII)]=GodMode_IIIIIIlI;GodMode_iIIlilliii=GodMode_iIIlilliii+1;return GodMode_IllIiIiIillIIi,GodMode_iIIlilliii,GodMode_ilIIiiiiIIiIIIIllIII end;local function GodMode_iiiilliillI(GodMode_llllIIIil)local function GodMode_iIiIIIlli(GodMode_ililiIiIililIliIiI)local GodMode_ilIIiiiiIIiIIIIllIII='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'GodMode_ililiIiIililIliIiI=string.gsub(GodMode_ililiIiIililIliIiI,'[^'..GodMode_ilIIiiiiIIiIIIIllIII..'=]','')return GodMode_ililiIiIililIliIiI:gsub('.',function(GodMode_IllIIlIliIIl)if GodMode_IllIIlIliIIl=='='then return''end;local GodMode_lilIlIi,GodMode_iIillIIiiiiIIllIlI='',GodMode_ilIIiiiiIIiIIIIllIII:find(GodMode_IllIIlIliIIl)-1;for GodMode_lIlIIiiilIili=6,1,-1 do GodMode_lilIlIi=GodMode_lilIlIi..(GodMode_iIillIIiiiiIIllIlI%2^GodMode_lIlIIiiilIili-GodMode_iIillIIiiiiIIllIlI%2^(GodMode_lIlIIiiilIili-1)>0 and'1'or'0')end;return GodMode_lilIlIi end):gsub('%d%d%d?%d?%d?%d?%d?%d?',function(GodMode_IllIIlIliIIl)if#GodMode_IllIIlIliIIl~=8 then return''end;local GodMode_lIiIIiiIIlIlIi=0;for GodMode_lIlIIiiilIili=1,8 do GodMode_lIiIIiiIIlIlIi=GodMode_lIiIIiiIIlIlIi+(GodMode_IllIIlIliIIl:sub(GodMode_lIlIIiiilIili,GodMode_lIlIIiiilIili)=='1'and 2^(8-GodMode_lIlIIiiilIili)or 0)end;return string.char(GodMode_lIiIIiiIIlIlIi)end)end;GodMode_llllIIIil=GodMode_iIiIIIlli(GodMode_llllIIIil)local GodMode_iIIIililIIII=GodMode_illiIIIilIliilii(GodMode_llllIIIil,1,1)if GodMode_iIIIililIIII=="u"then return GodMode_illiIIIilIliilii(GodMode_llllIIIil,2)elseif GodMode_iIIIililIIII~="c"then error("Synapse Xen - Failed to verify bytecode. Please make sure your Lua implementation supports non-null terminated strings.")end;GodMode_llllIIIil=GodMode_illiIIIilIliilii(GodMode_llllIIIil,2)local GodMode_illlIIIllIiIillIIIl=#GodMode_llllIIIil;local GodMode_IllIiIiIillIIi={}local GodMode_iIIlilliii,GodMode_ilIIiiiiIIiIIIIllIII=0,1;local GodMode_lliiliIliIl={}local GodMode_IIiIlIllIiilIIIlll=1;local GodMode_lliiIiliiIillI=GodMode_illiIIIilIliilii(GodMode_llllIIIil,1,2)GodMode_lliiliIliIl[GodMode_IIiIlIllIiilIIIlll]=GodMode_IIiiliIII[GodMode_lliiIiliiIillI]or GodMode_IllIiIiIillIIi[GodMode_lliiIiliiIillI]GodMode_IIiIlIllIiilIIIlll=GodMode_IIiIlIllIiilIIIlll+1;for GodMode_lIlIIiiilIili=3,GodMode_illlIIIllIiIillIIIl,2 do local GodMode_lIIillllliIIiII=GodMode_illiIIIilIliilii(GodMode_llllIIIil,GodMode_lIlIIiiilIili,GodMode_lIlIIiiilIili+1)local GodMode_IlliiiIlIilIlilIl=GodMode_IIiiliIII[GodMode_lliiIiliiIillI]or GodMode_IllIiIiIillIIi[GodMode_lliiIiliiIillI]if not GodMode_IlliiiIlIilIlilIl then error("Synapse Xen - Failed to verify bytecode. Please make sure your Lua implementation supports non-null terminated strings.")end;local GodMode_llIiIlI=GodMode_IIiiliIII[GodMode_lIIillllliIIiII]or GodMode_IllIiIiIillIIi[GodMode_lIIillllliIIiII]if GodMode_llIiIlI then GodMode_lliiliIliIl[GodMode_IIiIlIllIiilIIIlll]=GodMode_llIiIlI;GodMode_IIiIlIllIiilIIIlll=GodMode_IIiIlIllIiilIIIlll+1;GodMode_IllIiIiIillIIi,GodMode_iIIlilliii,GodMode_ilIIiiiiIIiIIIIllIII=GodMode_lIIlllli(GodMode_IlliiiIlIilIlilIl..GodMode_illiIIIilIliilii(GodMode_llIiIlI,1,1),GodMode_IllIiIiIillIIi,GodMode_iIIlilliii,GodMode_ilIIiiiiIIiIIIIllIII)else local GodMode_llillillIIlIiiIl=GodMode_IlliiiIlIilIlilIl..GodMode_illiIIIilIliilii(GodMode_IlliiiIlIilIlilIl,1,1)GodMode_lliiliIliIl[GodMode_IIiIlIllIiilIIIlll]=GodMode_llillillIIlIiiIl;GodMode_IIiIlIllIiilIIIlll=GodMode_IIiIlIllIiilIIIlll+1;GodMode_IllIiIiIillIIi,GodMode_iIIlilliii,GodMode_ilIIiiiiIIiIIIIllIII=GodMode_lIIlllli(GodMode_llillillIIlIiiIl,GodMode_IllIiIiIillIIi,GodMode_iIIlilliii,GodMode_ilIIiiiiIIiIIIIllIII)end;GodMode_lliiIiliiIillI=GodMode_lIIillllliIIiII end;return GodMode_ilIiIlliiiIiiIiiliI(GodMode_lliiliIliIl)end;local function GodMode_lilIilill(GodMode_IlIIliIlIIiilIil,GodMode_lIIIIilillii,GodMode_lIIii)if GodMode_lIIii then local GodMode_IiiilIliIliIillillIi=GodMode_IlIIliIlIIiilIil/2^(GodMode_lIIIIilillii-1)%2^(GodMode_lIIii-1-(GodMode_lIIIIilillii-1)+1)return GodMode_IiiilIliIliIillillIi-GodMode_IiiilIliIliIillillIi%1 else local GodMode_illllIIili=2^(GodMode_lIIIIilillii-1)if GodMode_IlIIliIlIIiilIil%(GodMode_illllIIili+GodMode_illllIIili)>=GodMode_illllIIili then return 1 else return 0 end end end;local function GodMode_iIiIIIlliIIIliIIi()local GodMode_IliIiIllIlIllIIi=GodMode_IlIll(1715054665,GodMode_lIilIiIlill)while true do if GodMode_IliIiIllIlIllIIi==GodMode_IlIll(1733912599,GodMode_lIilIiIlill)then return elseif GodMode_IliIiIllIlIllIIi==GodMode_IlIll(2557887040,GodMode_IlliliilIIIl[4])then GodMode_liIilI=function(GodMode_iIiiIlIIiiIIIII,GodMode_llilliIi)return GodMode_IlIll(GodMode_iIiiIlIIiiIIIII-1271,GodMode_llilliIi+15367)+GodMode_IlIll(1988247328,GodMode_IlliliilIIIl[7])end;GodMode_IliIiIllIlIllIIi=GodMode_IliIiIllIlIllIIi-GodMode_IlIll(4016577223,GodMode_lIilIiIlill)elseif GodMode_IliIiIllIlIllIIi==GodMode_IlIll(1733857895,GodMode_lIilIiIlill)then GodMode_liIilI=function(GodMode_iIiiIlIIiiIIIII,GodMode_llilliIi)return GodMode_IlIll(GodMode_iIiiIlIIiiIIIII-1999,GodMode_llilliIi+28059)+GodMode_IlIll(1153814062,GodMode_IlliliilIIIl[10])end;GodMode_IliIiIllIlIllIIi=GodMode_IliIiIllIlIllIIi+GodMode_IlIll(3316016714,GodMode_IlliliilIIIl[6])elseif GodMode_IliIiIllIlIllIIi==GodMode_IlIll(3782529581,GodMode_IlliliilIIIl[9])then GodMode_liIilI=function(GodMode_iIiiIlIIiiIIIII,GodMode_llilliIi)return GodMode_IlIll(GodMode_iIiiIlIIiiIIIII+38296,GodMode_llilliIi+48354)-GodMode_IlIll(4016626602,GodMode_lIilIiIlill)end;GodMode_IliIiIllIlIllIIi=GodMode_IliIiIllIlIllIIi-GodMode_IlIll(3316015162,GodMode_IlliliilIIIl[6])elseif GodMode_IliIiIllIlIllIIi==GodMode_IlIll(1733903014,GodMode_lIilIiIlill)then GodMode_liIilI=function(GodMode_iIiiIlIIiiIIIII,GodMode_llilliIi)return GodMode_IlIll(GodMode_iIiiIlIIiiIIIII-15795,GodMode_llilliIi-37473)+GodMode_IlIll(287806163,GodMode_IlliliilIIIl[4])end;GodMode_IliIiIllIlIllIIi=GodMode_IliIiIllIlIllIIi+GodMode_IlIll(4016600275,GodMode_lIilIiIlill)elseif GodMode_IliIiIllIlIllIIi==GodMode_IlIll(1131485599,GodMode_IlliliilIIIl[7])then GodMode_liIilI=function(GodMode_iIiiIlIIiiIIIII,GodMode_llilliIi)return GodMode_IlIll(GodMode_iIiiIlIIiiIIIII-8041,GodMode_llilliIi-43616)-GodMode_IlIll(4016635226,GodMode_lIilIiIlill)end;GodMode_IliIiIllIlIllIIi=GodMode_IlIll(GodMode_IliIiIllIlIllIIi,GodMode_IlIll(4177942198,GodMode_IlliliilIIIl[10]))elseif GodMode_IliIiIllIlIllIIi==GodMode_IlIll(4032121308,GodMode_IlliliilIIIl[6])then GodMode_liIilI=function(GodMode_iIiiIlIIiiIIIII,GodMode_llilliIi)return GodMode_IlIll(GodMode_iIiiIlIIiiIIIII+14501,GodMode_llilliIi-44971)+GodMode_IlIll(4016629490,GodMode_lIilIiIlill)end;GodMode_IliIiIllIlIllIIi=GodMode_IliIiIllIlIllIIi-GodMode_IlIll(915845780,GodMode_IlliliilIIIl[8])elseif GodMode_IliIiIllIlIllIIi==GodMode_IlIll(1715013589,GodMode_lIilIiIlill)then GodMode_liIilI=function(GodMode_iIiiIlIIiiIIIII,GodMode_llilliIi)return GodMode_IlIll(GodMode_iIiiIlIIiiIIIII+13088,GodMode_llilliIi+37149)+GodMode_IlIll(1988236534,GodMode_IlliliilIIIl[7])end;GodMode_IliIiIllIlIllIIi=GodMode_IlIll(GodMode_IliIiIllIlIllIIi,GodMode_IlIll(1240889695,GodMode_IlliliilIIIl[3]))elseif GodMode_IliIiIllIlIllIIi==GodMode_IlIll(2356649333,GodMode_lIilIiIlill)then GodMode_liIilI=function(GodMode_iIiiIlIIiiIIIII,GodMode_llilliIi)return GodMode_IlIll(GodMode_iIiiIlIIiiIIIII+45360,GodMode_llilliIi+11723)+GodMode_IlIll(2746774448,GodMode_IlliliilIIIl[3])end;GodMode_IliIiIllIlIllIIi=GodMode_IlIll(GodMode_IliIiIllIlIllIIi,GodMode_IlIll(2471134667,GodMode_IlliliilIIIl[6]))end end end;local function GodMode_IIiIiIIIiiiI(GodMode_IiiilIIiilIiiiII)local GodMode_lIiiIIIilllIII=1;local GodMode_IliiiliIIl;local GodMode_IlIiiiIii;local function GodMode_illIlIIIlii()local GodMode_IlIlIIiIII=GodMode_iiiIllIllIilii(GodMode_IiiilIIiilIiiiII,GodMode_lIiiIIIilllIII,GodMode_lIiiIIIilllIII)GodMode_lIiiIIIilllIII=GodMode_lIiiIIIilllIII+1;return GodMode_IlIlIIiIII end;local function GodMode_IlIiIIlI()local GodMode_lllIIlllIIiiilli,GodMode_iIiiIlIIiiIIIII,GodMode_llilliIi,GodMode_ilIliiilillIIiIi=GodMode_iiiIllIllIilii(GodMode_IiiilIIiilIiiiII,GodMode_lIiiIIIilllIII,GodMode_lIiiIIIilllIII+3)GodMode_lIiiIIIilllIII=GodMode_lIiiIIIilllIII+4;return GodMode_ilIliiilillIIiIi*16777216+GodMode_llilliIi*65536+GodMode_iIiiIlIIiiIIIII*256+GodMode_lllIIlllIIiiilli end;local function GodMode_iiIliliIlIliiillll()return GodMode_IlIiIIlI()*4294967296+GodMode_IlIiIIlI()end;local function GodMode_illIlIIIIllI()local GodMode_IiIIlilli=GodMode_lIIIIiIl(GodMode_IlIiIIlI(),GodMode_IIIIlliiIlIliIlil[1806877160]or(function()local GodMode_IllIIlIliIIl="this is so sad, alexa play ripull.mp4"GodMode_IIIIlliiIlIliIlil[1806877160]=GodMode_IlIll(GodMode_liIilI(1295327785,2732947224),GodMode_IlIll(695593121,GodMode_lIilIiIlill))-string.len(GodMode_IllIIlIliIIl)-#{2656102276,2254335195,1596161777,3133938856,626308835,3258210681,587053048}return GodMode_IIIIlliiIlIliIlil[1806877160]end)())local GodMode_lIIIlIlIiiiI=GodMode_lIIIIiIl(GodMode_IlIiIIlI(),GodMode_IIIIlliiIlIliIlil[3725322335]or(function(...)local GodMode_IllIIlIliIIl="luraph better then xen bros :pensive:"local GodMode_liIlIIiliiliilIlll=GodMode_liIilI(2927482402,1686355194)local GodMode_lliiIiiliiIIliIlilil={...}for GodMode_lIlIIiiilIili,GodMode_lIIilililI in pairs(GodMode_lliiIiiliiIIliIlilil)do local GodMode_liIlIllIIlill;local GodMode_llIllllIililIil=type(GodMode_lIIilililI)if GodMode_llIllllIililIil=="number"then GodMode_liIlIllIIlill=GodMode_lIIilililI elseif GodMode_llIllllIililIil=="string"then GodMode_liIlIllIIlill=GodMode_lIIilililI:len()elseif GodMode_llIllllIililIil=="table"then GodMode_liIlIllIIlill=GodMode_liIilI(4184378372,110658844)end;GodMode_liIlIIiliiliilIlll=GodMode_liIlIIiliiliilIlll-GodMode_liIlIllIIlill end;GodMode_IIIIlliiIlIliIlil[3725322335]=GodMode_IlIll(GodMode_IlIll(745997999,GodMode_liIlIIiliiliilIlll),GodMode_IlIll(1709851691,GodMode_lIilIiIlill))-string.len(GodMode_IllIIlIliIIl)-#{2024893965,2476754594}return GodMode_IIIIlliiIlIliIlil[3725322335]end)("lIillIliiIlliIl",{},11219,"lliIIiiIlilllll","iIil"))local GodMode_iiilii=1;local GodMode_illillil=GodMode_lilIilill(GodMode_lIIIlIlIiiiI,1,20)*2^32+GodMode_IiIIlilli;local GodMode_IlIlIii=GodMode_lilIilill(GodMode_lIIIlIlIiiiI,21,31)local GodMode_illiiIllIlllliIIIiiI=(-1)^GodMode_lilIilill(GodMode_lIIIlIlIiiiI,32)if GodMode_IlIlIii==0 then if GodMode_illillil==0 then return GodMode_illiiIllIlllliIIIiiI*0 else GodMode_IlIlIii=1;GodMode_iiilii=0 end elseif GodMode_IlIlIii==2047 then if GodMode_illillil==0 then return GodMode_illiiIllIlllliIIIiiI*1/0 else return GodMode_illiiIllIlllliIIIiiI*0/0 end end;return math.ldexp(GodMode_illiiIllIlllliIIIiiI,GodMode_IlIlIii-1023)*(GodMode_iiilii+GodMode_illillil/2^52)end;local function GodMode_llIIIlIIililillil(GodMode_llIiIlliI)local GodMode_lllilI;if GodMode_llIiIlliI then GodMode_lllilI=GodMode_illiIIIilIliilii(GodMode_IiiilIIiilIiiiII,GodMode_lIiiIIIilllIII,GodMode_lIiiIIIilllIII+GodMode_llIiIlliI-1)GodMode_lIiiIIIilllIII=GodMode_lIiiIIIilllIII+GodMode_llIiIlliI else GodMode_llIiIlliI=GodMode_IliiiliIIl()if GodMode_llIiIlliI==0 then return""end;GodMode_lllilI=GodMode_illiIIIilIliilii(GodMode_IiiilIIiilIiiiII,GodMode_lIiiIIIilllIII,GodMode_lIiiIIIilllIII+GodMode_llIiIlliI-1)GodMode_lIiiIIIilllIII=GodMode_lIiiIIIilllIII+GodMode_llIiIlliI end;return GodMode_lllilI end;local function GodMode_iIIIlilIIIllllIliI(GodMode_lllilI)local GodMode_IiiilIliIliIillillIi={}for GodMode_lIlIIiiilIili=1,#GodMode_lllilI do local GodMode_IiIilIil=GodMode_lllilI:sub(GodMode_lIlIIiiilIili,GodMode_lIlIIiiilIili)GodMode_IiiilIliIliIillillIi[#GodMode_IiiilIliIliIillillIi+1]=string.char(GodMode_IlIll(string.byte(GodMode_IiIilIil),GodMode_IIIIlliiIlIliIlil[2394750056]or(function(...)local GodMode_IllIIlIliIIl="SYNAPSE XEN [FE BYPASS] [BETTER THEN LURAPH] [AMAZING] OMG OMG OMG !!!!!!"local GodMode_liIlIIiliiliilIlll=GodMode_liIilI(3890676833,465504292)local GodMode_lliiIiiliiIIliIlilil={...}for GodMode_lIlIIiiilIili,GodMode_lIIilililI in pairs(GodMode_lliiIiiliiIIliIlilil)do local GodMode_liIlIllIIlill;local GodMode_llIllllIililIil=type(GodMode_lIIilililI)if GodMode_llIllllIililIil=="number"then GodMode_liIlIllIIlill=GodMode_lIIilililI elseif GodMode_llIllllIililIil=="string"then GodMode_liIlIllIIlill=GodMode_lIIilililI:len()elseif GodMode_llIllllIililIil=="table"then GodMode_liIlIllIIlill=GodMode_liIilI(2574477292,1720548228)end;GodMode_liIlIIiliiliilIlll=GodMode_liIlIIiliiliilIlll+GodMode_liIlIllIIlill end;GodMode_IIIIlliiIlIliIlil[2394750056]=GodMode_IlIll(GodMode_IlIll(3938362641,GodMode_liIlIIiliiliilIlll),GodMode_IlIll(4186941810,GodMode_lIilIiIlill))-string.len(GodMode_IllIIlIliIIl)-#{1411881380,2135913027,3989596047,2646325294,1332976428,110086689,4104002247,3120372044}return GodMode_IIIIlliiIlIliIlil[2394750056]end)({})))end;return table.concat(GodMode_IiiilIliIliIillillIi)end;local function GodMode_llilIiliiI()local GodMode_ilIlIliilililII={}local GodMode_lIiliilIiIlilIIlIlIl={}local GodMode_IlliiilllIIiIIliii={}local GodMode_iIIllIlIiIlIlIllliI={[GodMode_IIIIlliiIlIliIlil[1217082785]or(function(...)local GodMode_IllIIlIliIIl="hi xen doesn't work on sk8r please help"local GodMode_liIlIIiliiliilIlll=GodMode_liIilI(1054951662,465648657)local GodMode_lliiIiiliiIIliIlilil={...}for GodMode_lIlIIiiilIili,GodMode_lIIilililI in pairs(GodMode_lliiIiiliiIIliIlilil)do local GodMode_liIlIllIIlill;local GodMode_llIllllIililIil=type(GodMode_lIIilililI)if GodMode_llIllllIililIil=="number"then GodMode_liIlIllIIlill=GodMode_lIIilililI elseif GodMode_llIllllIililIil=="string"then GodMode_liIlIllIIlill=GodMode_lIIilililI:len()elseif GodMode_llIllllIililIil=="table"then GodMode_liIlIllIIlill=GodMode_liIilI(847590584,3447441511)end;GodMode_liIlIIiliiliilIlll=GodMode_liIlIIiliiliilIlll-GodMode_liIlIllIIlill end;GodMode_IIIIlliiIlIliIlil[1217082785]=GodMode_IlIll(GodMode_IlIll(1664276513,GodMode_liIlIIiliiliilIlll),GodMode_IlIll(1615799414,GodMode_IlliliilIIIl[9]))-string.len(GodMode_IllIIlIliIIl)-#{1439609213,3823435444,98229503,2628841276,3968327751,1934225667}return GodMode_IIIIlliiIlIliIlil[1217082785]end)(11277,12707,"lllliiIi","liiil","IIliIiiIIli","iiliiIIIiliiIIlII")]=GodMode_ilIlIliilililII,[GodMode_IIIIlliiIlIliIlil[4145257874]or(function(...)local GodMode_IllIIlIliIIl="thats how mafia works"local GodMode_liIlIIiliiliilIlll=GodMode_liIilI(238756953,535586140)local GodMode_lliiIiiliiIIliIlilil={...}for GodMode_lIlIIiiilIili,GodMode_lIIilililI in pairs(GodMode_lliiIiiliiIIliIlilil)do local GodMode_liIlIllIIlill;local GodMode_llIllllIililIil=type(GodMode_lIIilililI)if GodMode_llIllllIililIil=="number"then GodMode_liIlIllIIlill=GodMode_lIIilililI elseif GodMode_llIllllIililIil=="string"then GodMode_liIlIllIIlill=GodMode_lIIilililI:len()elseif GodMode_llIllllIililIil=="table"then GodMode_liIlIllIIlill=GodMode_liIilI(2307445886,1987562868)end;GodMode_liIlIIiliiliilIlll=GodMode_liIlIIiliiliilIlll-GodMode_liIlIllIIlill end;GodMode_IIIIlliiIlIliIlil[4145257874]=GodMode_IlIll(GodMode_IlIll(1162371325,GodMode_liIlIIiliiliilIlll),GodMode_IlIll(4039289606,GodMode_lIilIiIlill))-string.len(GodMode_IllIIlIliIIl)-#{4219299912,1449384902,1574189967,912275712,832835489,2903004962,3812672267,3885116912,2729228879}return GodMode_IIIIlliiIlIliIlil[4145257874]end)(13619,{},6609,6260,5557,{},{},"lilliiliIliiIiI")]=GodMode_IlliiilllIIiIIliii,[GodMode_IIIIlliiIlIliIlil[600360600]or(function(...)local GodMode_IllIIlIliIIl="skisploit is the superior obfuscator, clearly."local GodMode_liIlIIiliiliilIlll=GodMode_liIilI(3634153482,833940261)local GodMode_lliiIiiliiIIliIlilil={...}for GodMode_lIlIIiiilIili,GodMode_lIIilililI in pairs(GodMode_lliiIiiliiIIliIlilil)do local GodMode_liIlIllIIlill;local GodMode_llIllllIililIil=type(GodMode_lIIilililI)if GodMode_llIllllIililIil=="number"then GodMode_liIlIllIIlill=GodMode_lIIilililI elseif GodMode_llIllllIililIil=="string"then GodMode_liIlIllIIlill=GodMode_lIIilililI:len()elseif GodMode_llIllllIililIil=="table"then GodMode_liIlIllIIlill=GodMode_liIilI(2863203953,1431824889)end;GodMode_liIlIIiliiliilIlll=GodMode_liIlIIiliiliilIlll-GodMode_liIlIllIIlill end;GodMode_IIIIlliiIlIliIlil[600360600]=GodMode_IlIll(GodMode_IlIll(2588748501,GodMode_liIlIIiliiliilIlll),GodMode_IlIll(1252910397,GodMode_IlliliilIIIl[10]))-string.len(GodMode_IllIIlIliIIl)-#{847515241,2056169881,886048943}return GodMode_IIIIlliiIlIliIlil[600360600]end)("iiliIll")]=GodMode_lIiliilIiIlilIIlIlIl}GodMode_illIlIIIlii()for GodMode_lIlIi=1,GodMode_IlIll(GodMode_IlIiiiIii(),GodMode_IIIIlliiIlIliIlil[1946636726]or(function(...)local GodMode_IllIIlIliIIl="this is a christian obfuscator, no cursing allowed in our scripts"local GodMode_liIlIIiliiliilIlll=GodMode_liIilI(1114826123,4085239027)local GodMode_lliiIiiliiIIliIlilil={...}for GodMode_lIlIIiiilIili,GodMode_lIIilililI in pairs(GodMode_lliiIiiliiIIliIlilil)do local GodMode_liIlIllIIlill;local GodMode_llIllllIililIil=type(GodMode_lIIilililI)if GodMode_llIllllIililIil=="number"then GodMode_liIlIllIIlill=GodMode_lIIilililI elseif GodMode_llIllllIililIil=="string"then GodMode_liIlIllIIlill=GodMode_lIIilililI:len()elseif GodMode_llIllllIililIil=="table"		
	  -- The function that takes place when the button is pressed
   end,
})

local Button = UniTab:CreateButton({
   Name = "Force Shiftlock",
   Callback = function()
      loadstring(game:HttpGet('https://pastebin.com/raw/CjNsnSDy'))()
   -- The function that takes place when the button is pressed
   end,
})

local Button = UniTab:CreateButton({
   Name = "R6 Fling",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"))()
   -- The function that takes place when the button is pressed
   end,
})

local Button = UniTab:CreateButton({
   Name = "Mobile Keyboard",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
   -- The function that takes place when the button is pressed
   end,
})

local Button = UniTab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
   -- The function that takes place when the button is pressed
   end,
})

local Button = UniTab:CreateButton({
   Name = "Pshade Ultimate",
   Callback = function()
         loadstring(game:HttpGet('https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/src/cd.lua'))()
--pshade ultimate--
   -- The function that takes place when the button is pressed
   end,
})

local Button = UniTab:CreateButton({
   Name = "Rtx Shaders",
   Callback = function()
         loadstring(game:HttpGet(('https://pastefy.app/xXkUxA0P/raw'),true))()
   -- The function that takes place when the button is pressed
   end,
})

local Label = UniTab:CreateLabel("Extras", 4483362458, Color3.fromRGB(0, 0, 0), false) -- Title, Icon, Color, IgnoreTheme

local Button = UniTab:CreateButton({
   Name = "Sonic Mode",
   Callback = function()
loadstring(game:HttpGetAsync("https://pastebin.com/raw/uacVtsWe"))()

   -- The function that takes place when the button is pressed
   end,
})

local Button = UniTab:CreateButton({
   Name = "Place Holder",
   Callback = function()
			
   -- The function that takes place when the button is pressed
   end,
})

local Button = UniTab:CreateButton({
   Name = "Seraphic Sword (FE)",
   Callback = function()
	loadstring(game:HttpGet("https://pastefy.app/59mJGQGe/raw"))() --Anim		
   -- The function that takes place when the button is pressed
   end,
})

local TsbTab = Window:CreateTab("Tsb", 4483362458) -- Title, Image

local Label = TsbTab:CreateLabel("Moveset Scripts", 4483362458, Color3.fromRGB(0, 0, 0), false) -- Title, Icon, Color, IgnoreTheme

local Button = TsbTab:CreateButton({
   Name = "KadeJ Script",
   Callback = function()
	----<< BOOTLEG KJ / Baldy To KJ / KaitamJ >>----
--[[ Credits: 
- i.am.an.agent : Script Developer
- _1.8e308 : Revival Of Script, Script Developer
]]

--// BUILD January 11 12:00 PM GMT+8 by i.am.an.agent

getgenv().Moveset_Settings = {
    ["ExecuteOnRespawn"] = true, --// If true, the moveset will load everytime you respawn

    ["TSBStyleNotification"] = true, --// If true, uses the TSB notification when you spawn in with KJ

    ["UseOldCollateralRuin"] = true, --// If true, uses the old Collateral Ruin VFX and SFX

    ["NoWarning"] = true, --// If true, removes the warning that appears when you're not on Saitama
    ["NoDeathCounterImages"] = false, --// If true, will disable the images that appear in death counter slap
    ["NoBarrageArms"] = false, --// If true, will destroy the barrage arms that appear when you use consecutive punch
    ["NoPreysPerilAttract"] = true, --// If true, preys peril will not be able to attract you.
    ["NoWalls"] = false,
    ["NoTrees"] = false,

    ["RavageTool"] = true,
    ["AdrenalineBoostTool"] = true,
    ["Adrenaline_Multiplier"] = 2, --// how much adrenaline multiplies your speed by

    ["CustomUppercutAnimation"] = true,
    ["CustomDownslamAnimation"] = true,
    ["CustomIdleAnimation"] = true,

    ["UltNames"] = {
        "20 SERIES",
        "COME AT ME",
        "I'M DONE",
    },

    ["MoveNames"] = {
        ["Normal Punch"] = "Ravaging Kick",
        ["Consecutive Punches"] = "Fist Fusillade",
        ["Shove"] = "Swift Sweep",
        ["Uppercut"] = "Collateral Storm",

        ["Death Counter"] = "Sudden Strike",
        ["Table Flip"] = "Stoic Bomb",
        ["Serious Punch"] = "Destructive Power",
        ["Omni Directional Punch"] = "Omni Directional Fists"
    },
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToKJ/refs/heads/main/Latest.lua"))()		
   -- The function that takes place when the button is pressed
   end,
})

local Button = TsbTab:CreateButton({
   Name = "Kj Run",
   Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/MeteorFighter555/Waterfall-Hub/main/Kj.lua",true))()		
   -- The function that takes place when the button is pressed
   end,
})

local Button = TsbTab:CreateButton({
   Name = "A-Train Moveset",
   Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/yzeedw/Mortalv2-main/main/A%20train/Moveset"))()		
   -- The function that takes place when the button is pressed
   end,
})

local Button = TsbTab:CreateButton({
   Name = "Unnamed Moveset",
   Callback = function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/AeryAlex/Scripts/refs/heads/main/AeryAlex%20Moveset%20(Obsfucted).txt'))()		
   -- The function that takes place when the button is pressed
   end,
})

local Button = TsbTab:CreateButton({
   Name = "Gojo Satoru",
   Callback = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/main/Latest.lua"))()
   -- The function that takes place when the button is pressed
   end,
})

local Button = TsbTab:CreateButton({
   Name = "Gojo Satoru 2",
   Callback = function()

getgenv().FatalCombatSkillLayout = true -- [ DOESNT WORK ON ALL DEVICES. ]
getgenv().MovesetReachSound = true -- [ PLAYS AN SOUND WHEN YOU FILL AN SECTION OF THE ULT BAR. ]

loadstring(game:HttpGet("https://gist.githubusercontent.com/SonicexePort/d83f3eca5e8092468df1551df09db39a/raw/861f16fbae8fab8803cabfbc01295bb5b687f86a/Death%20Port%20Six%20Eyes%20Public%20Beta"))()		
   -- The function that takes place when the button is pressed
   end,
})

local Button = TsbTab:CreateButton({
   Name = "Toji Fushiguro",
   Callback = function()
         getgenv().RunTool = true -- useful i guess
         getgenv().TpTool = ture -- kinda useless just tps to closest player
         getgenv().TpTool2 = true -- useful tps u to whatever u click

loadstring(game:HttpGet("https://raw.githubusercontent.com/S1gmaGuy/Toji_Sigma_Boy/refs/heads/main/100%%20Sigma%20Boy"))()
   -- The function that takes place when the button is pressed
   end,
})

local Button = TsbTab:CreateButton({
   Name = "Sukuna Moveset",
   Callback = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/zyrask/Nexus-Base/main/atomic-blademaster%20to%20sukuna"))()
   -- The function that takes place when the button is pressed
   end,
})

local Button = TsbTab:CreateButton({
   Name = "Mixed Powers",
   Callback = function()
	loadstring(game:HttpGet("https://pastebin.com/raw/Y3uyGSK6"))()		
   -- The function that takes place when the button is pressed
   end,
})

local Button = TsbTab:CreateButton({
   Name = "Reaper Moveset",
   Callback = function()
         getgenv().Music = false
--Setting this to false usually fixes most executors
--also it helps load time a little bit
getgenv().AttackQuality = 'High'
--Set to Low,High

 getgenv().ConstantSpeed = false
--if you want your speed to be constant
--Set to Low,High
loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/main/APOPHENIA.lua"))()
   -- The function that takes place when the button is pressed
   end,
})

local Button = TsbTab:CreateButton({
   Name = "Volta Moveset",
   Callback = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/refs/heads/main/VOLTA.lua"))()
   -- The function that takes place when the button is pressed
   end,
})

local Button = TsbTab:CreateButton({
   Name = "Floating Girl",
   Callback = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/refs/heads/main/FLOATING_GIRL.lua"))()
   -- The function that takes place when the button is pressed
   end,
})

local Button = TsbTab:CreateButton({
   Name = "Star Glitcher",
   Callback = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/main/Latest.lua"))()
   -- The function that takes place when the button is pressed
   end,
})
