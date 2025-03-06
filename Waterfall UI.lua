    local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
local GUI = Mercury:Create{
    Name = "Waterfall Hub",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Serika,
    Link = "https://github.com/MeteorFighter555/Waterfall-Hub"
}

local Tab = GUI:Tab{
        Name = "Universal",
        Icon = "rbxassetid://8569322835"
}

Tab:Textbox{
        Name = "Universal",
        Callback = function(text) end
}

Tab:Button{
        Name = "Infinite Jump",
        Description = nil,
        Callback = function() 

local InfiniteJumpEnabled = true
game:GetService("UserInputService").JumpRequest:connect(function()
        if InfiniteJumpEnabled then
                game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
        end
end)

end
}

Tab:Button{
        Name = "Shiftlock",
        Description = nil,
        Callback = function() 

loadstring(game:HttpGet('https://pastebin.com/raw/CjNsnSDy'))()

end
}

Tab:Button{
        Name = "Mobile Keyboard",
        Description = nil,
        Callback = function() 

loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()


end
}

Tab:Button{
        Name = "Touch Fling R6",
        Description = nil,
        Callback = function() 

loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"))()


end
}

Tab:Button{
        Name = "Click TP",
        Description = nil,
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

end
}

Tab:Textbox{
        Name = "Fun Scripts (Use mobile keyboard if your on mobile)",
        Callback = function(text) end
}

Tab:Button{
        Name = "Sonic Mode",
        Description = nil,
        Callback = function() 

loadstring(game:HttpGetAsync("https://pastebin.com/raw/uacVtsWe"))()


end
}

Tab:Button{
        Name = "Good Cop Bad Cop",
        Description = nil,
        Callback = function() 

loadstring(game:HttpGetAsync("https://pastebin.com/raw/hSqRZPLd"))()


end
}

local Tab = GUI:Tab{
        Name = "Utility",
        Icon = "rbxassetid://8569322835"
}

Tab:Textbox{
        Name = "Sense ESP",
        Callback = function(text) end
}

Tab:Button{
        Name = "Sense ESP",
        Description = nil,
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
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Exunys Developer";
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
local TestService = game:GetService("TestService")

local Typing = false

_G.SendNotifications = true   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
_G.DefaultSettings = false   -- If set to true then the tracer script would run with default settings regardless of any changes you made.

_G.TeamCheck = false   -- If set to true then the script would create tracers only for the enemy team members.

--[!]-- ONLY ONE OF THESE VALUES SHOULD BE SET TO TRUE TO NOT ERROR THE SCRIPT --[!]--

_G.FromMouse = false   -- If set to true, the tracers will come from the position of your mouse curson on your screen.
_G.FromCenter = true   -- If set to true, the tracers will come from the center of your screen.
_G.FromBottom = false   -- If set to true, the tracers will come from the bottom of your screen.

_G.TracersVisible = true   -- If set to true then the tracers will be visible and vice versa.
_G.TracerColor = Color3.fromRGB(255, 255, 255)   -- White color for tracers
_G.TracerThickness = 1   -- The thickness of the tracers.
_G.TracerTransparency = 0.7   -- The transparency of the tracers.

_G.ModeSkipKey = Enum.KeyCode.E   -- The key that changes between modes that indicate where will the tracers come from.
_G.DisableKey = Enum.KeyCode.Q   -- The key that disables / enables the tracers.

-- Table to store all tracer lines
local TracerLines = {}

local function CreateTracers()
    for _, v in next, Players:GetPlayers() do
        if v.Name ~= game.Players.LocalPlayer.Name then
            local TracerLine = Drawing.new("Line")
            table.insert(TracerLines, TracerLine)  -- Store the tracer line for later removal
    
            RunService.RenderStepped:Connect(function()
                if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                    local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * 1
                    local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(0, -HumanoidRootPart_Size.Y, 0).p)
                    
                    TracerLine.Thickness = _G.TracerThickness
                    TracerLine.Transparency = _G.TracerTransparency
                    TracerLine.Color = _G.TracerColor

                    if _G.FromMouse == true and _G.FromCenter == false and _G.FromBottom == false then
                        TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                    elseif _G.FromMouse == false and _G.FromCenter == true and _G.FromBottom == false then
                        TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)  -- Center of the screen
                    elseif _G.FromMouse == false and _G.FromCenter == false and _G.FromBottom == true then
                        TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    end

                    if OnScreen == true  then
                        TracerLine.To = Vector2.new(Vector.X, Vector.Y)
                        if _G.TeamCheck == true then 
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

    Players.PlayerAdded:Connect(function(Player)
        Player.CharacterAdded:Connect(function(v)
            if v.Name ~= game.Players.LocalPlayer.Name then
                local TracerLine = Drawing.new("Line")
                table.insert(TracerLines, TracerLine)  -- Store the tracer line for later removal
        
                RunService.RenderStepped:Connect(function()
                    if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                        local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * 1
                    	local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(0, -HumanoidRootPart_Size.Y, 0).p)
                        
                        TracerLine.Thickness = _G.TracerThickness
                        TracerLine.Transparency = _G.TracerTransparency
                        TracerLine.Color = _G.TracerColor

                        if _G.FromMouse == true and _G.FromCenter == false and _G.FromBottom == false then
                            TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                        elseif _G.FromMouse == false and _G.FromCenter == true and _G.FromBottom == false then
                            TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)  -- Center of the screen
                        elseif _G.FromMouse == false and _G.FromCenter == false and _G.FromBottom == true then
                            TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        end

                        if OnScreen == true  then
                            TracerLine.To = Vector2.new(Vector.X, Vector.Y)
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
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
        end)
    end)
end

local function ClearTracers()
    for _, TracerLine in pairs(TracerLines) do
        TracerLine:Remove()  -- Remove all tracer lines
    end
    TracerLines = {}  -- Clear the table
end

-- Toggle tracers on/off
if _G.TracersEnabled then
    ClearTracers()  -- Disable tracers
    _G.TracersEnabled = false
    if _G.SendNotifications then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Exunys Developer";
            Text = "Tracers have been disabled.";
            Duration = 5;
        })
    end
else
    _G.TracersEnabled = true
    CreateTracers()  -- Enable tracers
    if _G.SendNotifications then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Exunys Developer";
            Text = "Tracers have been enabled.";
            Duration = 5;
        })
    end
		end
		

		
end
}

Tab:Button{
        Name = "Infinite Yield",
        Description = nil,
        Callback = function() 

loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()

end
}

Tab:Button{
        Name = "Aimbot",
        Description = nil,
        Callback = function() 

loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Universal-Aimbot-23560"))()

end
}

local Tab = GUI:Tab{
        Name = "Strongest Battlegrounds",
        Icon = "rbxassetid://8569322835"
}

Tab:Textbox{
	Name = "Custom Moveset Scripts",
	Callback = function(text) end
}


Tab:Button{
        Name = "Gojo Satoru",
        Description = nil,
        Callback = function() 

loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/main/Latest.lua"))()

end
}

Tab:Button{
        Name = "Toji Fushiguro",
        Description = nil,
        Callback = function() 

getgenv().RunTool = true -- useful i guess
getgenv().TpTool = ture -- kinda useless just tps to closest player
getgenv().TpTool2 = true -- useful tps u to whatever u click

loadstring(game:HttpGet("https://raw.githubusercontent.com/S1gmaGuy/Toji_Sigma_Boy/refs/heads/main/100%%20Sigma%20Boy"))()

end
}

Tab:Button{
        Name = "Sukuna",
        Description = nil,
        Callback = function() 

loadstring(game:HttpGet("https://raw.githubusercontent.com/zyrask/Nexus-Base/main/atomic-blademaster%20to%20sukuna"))()

end
}

Tab:Button{
        Name = "Reaper Moveset",
        Description = nil,
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

end
}

Tab:Button{
        Name = "Volta",
        Description = nil,
        Callback = function() 

loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/refs/heads/main/VOLTA.lua"))()

end
}

Tab:Button{
        Name = "Floating Girl",
        Description = nil,
        Callback = function() 

loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/refs/heads/main/FLOATING_GIRL.lua"))()

end
}

Tab:Button{
        Name = "Button",
        Description = nil,
        Callback = function() 



end
}

local Tab = GUI:Tab{
        Name = "Shaders",
        Icon = "rbxassetid://8569322835"
}

Tab:Button{
        Name = "Pshade Ultimate",
        Description = nil,
        Callback = function() 


loadstring(game:HttpGet('https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/src/cd.lua'))()
--pshade ultimate--


end
}

Tab:Button{
        Name = "Rtx Shaders",
        Description = nil,
        Callback = function() 

loadstring(game:HttpGet(('https://pastefy.app/xXkUxA0P/raw'),true))()

end
}
