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

        -- Preview: https://cdn.discordapp.com/attachments/796378086446333984/818089455897542687/unknown.png
-- Made by Blissful#4992
local Settings = {
    Box_Color = Color3.fromRGB(255, 0, 0),
    Tracer_Color = Color3.fromRGB(255, 0, 0),
    Tracer_Thickness = 1,
    Box_Thickness = 1,
    Tracer_Origin = "Bottom", -- Middle or Bottom if FollowMouse is on this won't matter...
    Tracer_FollowMouse = false,
    Tracers = true
}
local Team_Check = {
    TeamCheck = false, -- if TeamColor is on this won't matter...
    Green = Color3.fromRGB(0, 255, 0),
    Red = Color3.fromRGB(255, 0, 0)
}
local TeamColor = true

--// SEPARATION
local player = game:GetService("Players").LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local mouse = player:GetMouse()

local function NewQuad(thickness, color)
    local quad = Drawing.new("Quad")
    quad.Visible = false
    quad.PointA = Vector2.new(0,0)
    quad.PointB = Vector2.new(0,0)
    quad.PointC = Vector2.new(0,0)
    quad.PointD = Vector2.new(0,0)
    quad.Color = color
    quad.Filled = false
    quad.Thickness = thickness
    quad.Transparency = 1
    return quad
end

local function NewLine(thickness, color)
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color 
    line.Thickness = thickness
    line.Transparency = 1
    return line
end

local function Visibility(state, lib)
    for u, x in pairs(lib) do
        x.Visible = state
    end
end

local function ToColor3(col) --Function to convert, just cuz c;
    local r = col.r --Red value
    local g = col.g --Green value
    local b = col.b --Blue value
    return Color3.new(r,g,b); --Color3 datatype, made of the RGB inputs
end

local black = Color3.fromRGB(0, 0 ,0)
local function ESP(plr)
    local library = {
        --//Tracer and Black Tracer(black border)
        blacktracer = NewLine(Settings.Tracer_Thickness*2, black),
        tracer = NewLine(Settings.Tracer_Thickness, Settings.Tracer_Color),
        --//Box and Black Box(black border)
        black = NewQuad(Settings.Box_Thickness*2, black),
        box = NewQuad(Settings.Box_Thickness, Settings.Box_Color),
        --//Bar and Green Health Bar (part that moves up/down)
        healthbar = NewLine(3, black),
        greenhealth = NewLine(1.5, black)
    }

    local function Colorize(color)
        for u, x in pairs(library) do
            if x ~= library.healthbar and x ~= library.greenhealth and x ~= library.blacktracer and x ~= library.black then
                x.Color = color
            end
        end
    end

    local function Updater()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
                local HumPos, OnScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local head = camera:WorldToViewportPoint(plr.Character.Head.Position)
                    local DistanceY = math.clamp((Vector2.new(head.X, head.Y) - Vector2.new(HumPos.X, HumPos.Y)).magnitude, 2, math.huge)

                    local function Size(item)
                        item.PointA = Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY*2)
                        item.PointB = Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2)
                        item.PointC = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)
                        item.PointD = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2)
                    end
                    Size(library.box)
                    Size(library.black)

                    --//Tracer 
                    if Settings.Tracers then
                        if Settings.Tracer_Origin == "Middle" then
                            library.tracer.From = camera.ViewportSize*0.5
                            library.blacktracer.From = camera.ViewportSize*0.5
                        elseif Settings.Tracer_Origin == "Bottom" then
                            library.tracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y) 
                            library.blacktracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y)
                        end
                        if Settings.Tracer_FollowMouse then
                            library.tracer.From = Vector2.new(mouse.X, mouse.Y+36)
                            library.blacktracer.From = Vector2.new(mouse.X, mouse.Y+36)
                        end
                        library.tracer.To = Vector2.new(HumPos.X, HumPos.Y + DistanceY*2)
                        library.blacktracer.To = Vector2.new(HumPos.X, HumPos.Y + DistanceY*2)
                    else 
                        library.tracer.From = Vector2.new(0, 0)
                        library.blacktracer.From = Vector2.new(0, 0)
                        library.tracer.To = Vector2.new(0, 0)
                        library.blacktracer.To = Vector2.new(0, 02)
                    end

                    --// Health Bar
                    local d = (Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2) - Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)).magnitude 
                    local healthoffset = plr.Character.Humanoid.Health/plr.Character.Humanoid.MaxHealth * d

                    library.greenhealth.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2)
                    library.greenhealth.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2 - healthoffset)

                    library.healthbar.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2)
                    library.healthbar.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y - DistanceY*2)

                    local green = Color3.fromRGB(0, 255, 0)
                    local red = Color3.fromRGB(255, 0, 0)

                    library.greenhealth.Color = red:lerp(green, plr.Character.Humanoid.Health/plr.Character.Humanoid.MaxHealth);

                    if Team_Check.TeamCheck then
                        if plr.TeamColor == player.TeamColor then
                            Colorize(Team_Check.Green)
                        else 
                            Colorize(Team_Check.Red)
                        end
                    else 
                        library.tracer.Color = Settings.Tracer_Color
                        library.box.Color = Settings.Box_Color
                    end
                    if TeamColor == true then
                        Colorize(plr.TeamColor.Color)
                    end
                    Visibility(true, library)
                else 
                    Visibility(false, library)
                end
            else 
                Visibility(false, library)
                if game.Players:FindFirstChild(plr.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Updater)()
end

for i, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v.Name ~= player.Name then
        coroutine.wrap(ESP)(v)
    end
end

game.Players.PlayerAdded:Connect(function(newplr)
    if newplr.Name ~= player.Name then
        coroutine.wrap(ESP)(newplr)
    end
end)

local lplr = game:GetService('Players').LocalPlayer
local cam = workspace.CurrentCamera
local Vectorasd, OnScreen = cam:WorldToViewportPoint(workspace:WaitForChild('viewcheck').Position)
local tov2 = Vector2.new(Vectorasd.X, Vectorasd.Y)
local fromv2 = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 1)
local thickness = 2
local LineProperties = {}
LineProperties.To = tov2
LineProperties.from = fromv2
game:GetService('RunService').RenderStepped:Connect(function()
        local tracer = script.Parent

        local Vector, OnScreen = cam:WorldToViewportPoint(workspace:WaitForChild('viewcheck').Position)

        -- tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)

        coroutine.resume(coroutine.create((function()
                local To = Vector2.new(Vector.X, Vector.Y)
                local Direction = (To - LineProperties.From);
                local Center = (To + LineProperties.From) / 2
                local Distance = Direction.Magnitude
                local Theta = math.atan2(Direction.Y, Direction.X);

                tracer.Position = UDim2.fromOffset(Center.X, Center.Y);
                tracer.Rotation = math.deg(Theta);
                tracer.Size = UDim2.fromOffset(Distance, 1);

                LineProperties.To = To
        end)))
        coroutine.resume(coroutine.create((function()
                local From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
                local Direction = (LineProperties.To - From);
                local Center = (LineProperties.To + From) / 2
                local Distance = Direction.Magnitude
                local Theta = math.atan2(Direction.Y, Direction.X);

                tracer.Position = UDim2.fromOffset(Center.X, Center.Y);
                tracer.Rotation = math.deg(Theta);
                tracer.Size = UDim2.fromOffset(Distance, 1);

                LineProperties.From = From
        end)))
end)                

local FillColor = Color3.fromRGB(175,25,255)
local DepthMode = "AlwaysOnTop"
local FillTransparency = 0.5
local OutlineColor = Color3.fromRGB(255,255,255)
local OutlineTransparency = 0

local CoreGui = game:FindService("CoreGui")
local Players = game:FindService("Players")
local lp = Players.LocalPlayer
local connections = {}

local Storage = Instance.new("Folder")
Storage.Parent = CoreGui
Storage.Name = "Highlight_Storage"

local function Highlight(plr)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = plr.Name
    Highlight.FillColor = FillColor
    Highlight.DepthMode = DepthMode
    Highlight.FillTransparency = FillTransparency
    Highlight.OutlineColor = OutlineColor
    Highlight.OutlineTransparency = 0
    Highlight.Parent = Storage

    local plrchar = plr.Character
    if plrchar then
        Highlight.Adornee = plrchar
    end

    connections[plr] = plr.CharacterAdded:Connect(function(char)
        Highlight.Adornee = char
    end)
end

Players.PlayerAdded:Connect(Highlight)
for i,v in next, Players:GetPlayers() do
    Highlight(v)
end

Players.PlayerRemoving:Connect(function(plr)
    local plrname = plr.Name
    if Storage[plrname] then
        Storage[plrname]:Destroy()
    end
    if connections[plr] then
        connections[plr]:Disconnect()
    end
end)

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
