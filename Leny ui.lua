local Library = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/L3nyFromV3rm/Leny-UI/refs/heads/main/Library.lua", true))()

Library.new({
	sizeX = 770,
	sizeY = 600,
	title = "yo",
	tabWidth = 200, -- (72 for icons only)
	PrimaryBackgroundColor = Library.Theme.PrimaryBackgroundColor,
	SecondaryBackgroundColor = Library.Theme.SecondaryBackgroundColor,
	TertiaryBackgroundColor = Library.Theme.TertiaryBackgroundColor,
	TabBackgroundColor = Library.Theme.TabBackgroundColor,
	PrimaryTextColor = Library.Theme.PrimaryTextColor,
	SecondaryTextColor = Library.Theme.SecondaryTextColor,
	PrimaryColor = Library.Theme.PrimaryColor,
	ScrollingBarImageColor = Library.Theme.ScrollingBarImageColor,
	Line = Library.Theme.Line,
})

Library:notify({
	title = "Notification",
	text = "Hello world",
	maxSizeX = 300,
	scaleX = 0.165,
	sizeY = 200,
})

local Main = Library:createLabel({text = "Main"})

local Tab = Library:createTab({
	text = "Exploits",
	icon = "124718082122263", -- 20x20 icon you want here
})

local Page1 = Tab:createSubTab({
	text = "Universal",
	sectionStyle = "Double", -- Make the page a single section style or double, "Single", "Double"
})

local Section = Page1:createSection({
	text = "Section",
	position = "Left",
})

Section:createSlider({
	text = "Speed Slider",
	min = 16,
	max = 200,
	step = 1,
	callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)	
	end
}) -- :getValue(), :updateValue({value = 100})

Section:createSlider({
	text = "Jump Slider",
	min = 50,
	max = 200,
	step = 1,
	callback = function(Value)
		local plr = game.Players.LocalPlayer
local char = plr.Character
 
char.Humanoid.JumpPower = (Value)
	end
}) -- :getValue(), :updateValue({value = 100})

Section:createPicker({
	text = "Tracer ColorPicker",
	default = Color3.fromRGB(255, 255, 255),
	callback = function(Color)
		_G.TracerColor = Color
	end
}) -- :getColor(), :updateColor({color = Color3.fromRGB(255, 255, 0)})

Section:createButton({
	text = "Tracer ESP",
	callback = function()
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
	end
})



-- Creates the theme changer, config manager, etc
Library:createManager({
	folderName = "brah",
	icon = "124718082122263", -- 20x20 icon you want here
})
