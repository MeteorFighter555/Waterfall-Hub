local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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
   Title = "Welcome User",
   Content = "Welcome to Waterfall Hub",
   Duration = 6.5,
   Image = House,
})

local HomeTab = Window:CreateTab("Home", 4483362458) -- Title, Image

local Label = HomeTab:CreateLabel("Welcome to Waterfall Hub", 4483362458, Color3.fromRGB(0, 0, 0), false) -- Title, Icon, Color, IgnoreTheme
local Button = HomeTab:CreateButton({
   Name = "Destroy Hub",
   Callback = function()
         Rayfield:Destroy()
         
   end,
})

local UniTab = Window:CreateTab("Universal", 4483362458) -- Title, Image

local Label = UniTab:CreateLabel("Useful Part", 4483362458, Color3.fromRGB(0, 0, 0), false) -- Title, Icon, Color, IgnoreTheme

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

local ColorPicker = UniTab:CreateColorPicker({
    Name = "Color Picker",
    Color = Color3.fromRGB(255,255,255),
    Flag = "ColorPicker1",
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

local Label = UniTab:CreateLabel("Fun Scripts", 4483362458, Color3.fromRGB(0, 0, 0), false) -- Title, Icon, Color, IgnoreTheme

local Button = UniTab:CreateButton({
   Name = "Sonic Mode",
   Callback = function()
loadstring(game:HttpGetAsync("https://pastebin.com/raw/uacVtsWe"))()

   -- The function that takes place when the button is pressed
   end,
})

local Button = UniTab:CreateButton({
   Name = "Good Cop Bad Cop",
   Callback = function()
loadstring(game:HttpGetAsync("https://pastebin.com/raw/hSqRZPLd"))()
   -- The function that takes place when the button is pressed
   end,
})

local TsbTab = Window:CreateTab("Tsb", 4483362458) -- Title, Image

local Label = TsbTab:CreateLabel("Moveset Scripts", 4483362458, Color3.fromRGB(0, 0, 0), false) -- Title, Icon, Color, IgnoreTheme

local Button = TsbTab:CreateButton({
   Name = "Gojo Satoru",
   Callback = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/main/Latest.lua"))()
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
