local Library = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/L3nyFromV3rm/Leny-UI/refs/heads/main/Library.lua", true))()

Library.new({
	sizeX = 470,
	sizeY = 300,
	title = "Waterfall Hub",
	tabWidth = 200, -- (72 for icons only)
	PrimaryBackgroundColor = Color3.fromRGB(15, 18, 23),   -- Deep blue-gray for the main background
    	SecondaryBackgroundColor = Color3.fromRGB(10, 12, 17), -- Darker background for secondary elements
    	TertiaryBackgroundColor = Color3.fromRGB(240, 248, 255), -- Light misty blue for lighter UI elements
    	TabBackgroundColor = Color3.fromRGB(50, 60, 80),     -- Medium dark blue for tabs
    	PrimaryTextColor = Color3.fromRGB(255, 255, 255),     -- White text for readability
    	SecondaryTextColor = Color3.fromRGB(180, 210, 230),   -- Soft light blue for secondary text
    	PrimaryColor = Color3.fromRGB(90, 160, 255),       -- Vibrant blue for primary accents and buttons
    	ScrollingBarImageColor = Color3.fromRGB(135, 170, 195), -- Muted blue-gray for scrollbar
    	Line = Color3.fromRGB(35, 40, 50),
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

Section:createButton({
	text = "Click Tp",
	callback = function()
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
	end
})

Section:createButton({
	text = "God Mode (some games work)",
	callback = function()
		loadstring(game:HttpGet("https://freenote.biz/raw/Fhpx5r5A8M"))()
	end
})

Section:createButton({
	text = "Force Shiftlock",
	callback = function()
		loadstring(game:HttpGet('https://pastebin.com/raw/CjNsnSDy'))()
	end
})

Section:createButton({
	text = "R6 Fling",
	callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"))()
	end
})

Section:createButton({
	text = "Mobile Keyboard",
	callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()	
	end
})

Section:createButton({
	text = "Infinite Yield",
	callback = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
	end
})

Section:createButton({
	text = "Dark Dex Explorer",
	callback = function()
		loadstring(game:GetObjects('rbxassetid://2180084478')[1].Source)()
	end
})

-- Creates the theme changer, config manager, etc
Library:createManager({
	folderName = "brah",
	icon = "124718082122263", -- 20x20 icon you want here
})
