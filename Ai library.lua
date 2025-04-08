-- Gradient UI Library
local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Utility Functions
local function Create(instanceType)
    return function(properties)
        local instance = Instance.new(instanceType)
        for property, value in pairs(properties) do
            instance[property] = value
        end
        return instance
    end
end

local function CreateGradient(parent, color1, color2, transparency)
    local gradient = Create("UIGradient"){
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color1),
            ColorSequenceKeypoint.new(1, color2)
        }),
        Transparency = transparency or NumberSequence.new(0),
        Rotation = 45,
        Parent = parent
    }
    return gradient
end

-- Main Library Functions
function Library:CreateWindow(title)
    local Window = {}
    
    -- Main GUI
    local ScreenGui = Create("ScreenGui"){
        Name = "ExploitUI",
        Parent = game.CoreGui
    }
    
    local MainFrame = Create("Frame"){
        Name = "MainFrame",
        Size = UDim2.new(0, 600, 0, 400),
        Position = UDim2.new(0.5, -300, 0.5, -200),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        Parent = ScreenGui
    }
    
    -- Add rounded corners
    Create("UICorner"){
        CornerRadius = UDim.new(0, 6),
        Parent = MainFrame
    }
    
    -- Add main gradient
    CreateGradient(MainFrame, 
        Color3.fromRGB(30, 30, 30),
        Color3.fromRGB(20, 20, 20)
    )
    
    -- Title bar
    local TitleBar = Create("Frame"){
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BorderSizePixel = 0,
        Parent = MainFrame
    }
    
    Create("UICorner"){
        CornerRadius = UDim.new(0, 6),
        Parent = TitleBar
    }
    
    CreateGradient(TitleBar,
        Color3.fromRGB(40, 40, 40),
        Color3.fromRGB(30, 30, 30)
    )
    
    local TitleText = Create("TextLabel"){
        Name = "Title",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        Font = Enum.Font.SourceSansBold,
        Parent = TitleBar
    }
    
    -- Tab Container
    local TabContainer = Create("Frame"){
        Name = "TabContainer",
        Size = UDim2.new(0, 150, 1, -30),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        Parent = MainFrame
    }
    
    local TabList = Create("ScrollingFrame"){
        Name = "TabList",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 0,
        Parent = TabContainer
    }
    
    -- Content Container
    local ContentContainer = Create("Frame"){
        Name = "ContentContainer",
        Size = UDim2.new(1, -150, 1, -30),
        Position = UDim2.new(0, 150, 0, 30),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderSizePixel = 0,
        Parent = MainFrame
    }
    
    -- Make window draggable
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Tab Creation Function
    function Window:CreateTab(tabName)
        local Tab = {}
        
        local TabButton = Create("TextButton"){
            Name = tabName,
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            BorderSizePixel = 0,
            Text = tabName,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14,
            Font = Enum.Font.SourceSansBold,
            Parent = TabList
        }
        
        CreateGradient(TabButton,
            Color3.fromRGB(40, 40, 40),
            Color3.fromRGB(30, 30, 30)
        )
        
        local TabContent = Create("ScrollingFrame"){
            Name = tabName.."Content",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 4,
            Visible = false,
            Parent = ContentContainer
        }
        
        -- Add elements to tab
        function Tab:AddButton(buttonText, callback)
            local Button = Create("TextButton"){
                Name = buttonText,
                Size = UDim2.new(0.9, 0, 0, 35),
                Position = UDim2.new(0.05, 0, 0, #TabContent:GetChildren() * 45),
                BackgroundColor3 = Color3.fromRGB(45, 45, 45),
                BorderSizePixel = 0,
                Text = buttonText,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
                Font = Enum.Font.SourceSansBold,
                Parent = TabContent
            }
            
            Create("UICorner"){
                CornerRadius = UDim.new(0, 4),
                Parent = Button
            }
            
            CreateGradient(Button,
                Color3.fromRGB(50, 50, 50),
                Color3.fromRGB(40, 40, 40)
            )
            
            Button.MouseButton1Click:Connect(function()
                callback()
            end)
            
            -- Hover effect
            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                }):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                }):Play()
            end)
        end
        
        -- Tab button click handler
        TabButton.MouseButton1Click:Connect(function()
            for _, content in pairs(ContentContainer:GetChildren()) do
                content.Visible = false
            end
            TabContent.Visible = true
            
            -- Animate tab selection
            for _, button in pairs(TabList:GetChildren()) do
                TweenService:Create(button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                }):Play()
            end
            
            TweenService:Create(TabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            }):Play()
        end)
        
        return Tab
    end
    
    return Window
end

return Library
