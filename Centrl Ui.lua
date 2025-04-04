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
	Title = 'Player Ajustments',
	Sliders = {
		{
			title = 'Speed Slider',
			range = {16,200},
			increment = 1,
			startvalue = 16,
			callback = function(speed)

				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed

			end,
		},
		{
			title = 'Jump Slider',
			range = {50,200},
			increment = 1,
			startvalue = 50,
			callback = function(value)

local plr = game.Players.LocalPlayer
local char = plr.Character
 
char.Humanoid.JumpPower = (value)
			end,
		},
	}
})

s2:createColorpicker({
	Title = 'Tracer Color',
	Color = Color3.fromRGB(255, 255, 255), -- Starter Color
	Callback = function(Color)
              _G.TracerColor = Color -- Update tracer color dynamically
	end,
})

s1:createButton({
	Title = 'Tracer Esp',
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
