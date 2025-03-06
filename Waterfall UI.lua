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
