local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer

local function createMenu()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CustomMenu"
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MainFrame.Active = true
    MainFrame.Draggable = true -- Enables dragging
    MainFrame.Parent = ScreenGui

    local DragArea = Instance.new("Frame")
    DragArea.Size = UDim2.new(1, 0, 0, 30)
    DragArea.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DragArea.Parent = MainFrame

    local Tabs = Instance.new("Frame")
    Tabs.Size = UDim2.new(1, 0, 0, 40)
    Tabs.Position = UDim2.new(0, 0, 0, 30)
    Tabs.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Tabs.Parent = MainFrame

    local function createTabButton(name, position, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0.33, 0, 1, 0)
        Button.Position = UDim2.new(position, 0, 0, 0)
        Button.Text = name
        Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        Button.TextColor3 = Color3.new(1, 1, 1)
        Button.Parent = Tabs
        Button.MouseButton1Click:Connect(callback)
        return Button
    end

    local MainContainer = Instance.new("Frame")
    MainContainer.Size = UDim2.new(1, 0, 1, -70)
    MainContainer.Position = UDim2.new(0, 0, 0, 70)
    MainContainer.BackgroundTransparency = 1
    MainContainer.Parent = MainFrame

    local OtherContainer = MainContainer:Clone()
    OtherContainer.Parent = MainFrame
    OtherContainer.Visible = false

    local AdvancedContainer = MainContainer:Clone()
    AdvancedContainer.Parent = MainFrame
    AdvancedContainer.Visible = false

    local function createButton(parent, eventName, folderName)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 0, 30)
        Button.Text = eventName
        Button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        Button.TextColor3 = Color3.new(1, 1, 1)
        Button.Parent = parent
        
        Button.MouseButton1Click:Connect(function()
            local remoteFolder = ReplicatedStorage:FindFirstChild(folderName)
            if remoteFolder then
                local event = remoteFolder:FindFirstChild(eventName)
                if event and event:IsA("RemoteEvent") then
                    event:FireServer()
                end
            end
        end)
    end

    local MainLayout = Instance.new("UIListLayout")
    MainLayout.Parent = MainContainer

    local OtherLayout = Instance.new("UIListLayout")
    OtherLayout.Parent = OtherContainer

    local AdvancedLayout = Instance.new("UIListLayout")
    AdvancedLayout.Parent = AdvancedContainer

    local mainEvents = { "Beatdown", "Blue", "Blue2", "Container", "ContainerKick", "DomainSlashes", "HoraHora", "IdleDeathGamble", "ImaginaryPurple", "LuckyBeatdown", "Pachinko", "PachinkoBall", "PlayfulCloud", "PlayfulCloud2", "Punches", "Purple", "Red", "Red2", "ShutterDoors", "UltimateBeatdown", "Vanish" }
    for _, eventName in ipairs(mainEvents) do
        createButton(MainContainer, eventName, "Remotes")
    end

    local otherEvents = { "IdleDeathGamble", "MalevolentShrine", "SelfEmbodimentOfPerfection", "ShadowGarden", "UnlimitedVoid", "UnlimitedVoid0.2" }
    for _, eventName in ipairs(otherEvents) do
        createButton(OtherContainer, eventName, "Events")
    end

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, 0, 0, 30)
    TextBox.PlaceholderText = "Enter item name"
    TextBox.Parent = AdvancedContainer

    local EnterButton = Instance.new("TextButton")
    EnterButton.Size = UDim2.new(1, 0, 0, 30)
    EnterButton.Text = "Enter"
    EnterButton.Parent = AdvancedContainer
    EnterButton.MouseButton1Click:Connect(function()
        local item = Player.Backpack:FindFirstChild(TextBox.Text)
        if item and item:FindFirstChild("LocalScript") then
            item.LocalScript.Event:FireServer()
        end
    end)

    local function switchTab(selectedTab)
        MainContainer.Visible = (selectedTab == "Main")
        OtherContainer.Visible = (selectedTab == "Other")
        AdvancedContainer.Visible = (selectedTab == "Advanced")
    end

    createTabButton("Main", 0, function() switchTab("Main") end)
    createTabButton("Other", 0.33, function() switchTab("Other") end)
    createTabButton("Advanced", 0.66, function() switchTab("Advanced") end)

    switchTab("Main")

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.M then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end)

    return ScreenGui
end

Players.LocalPlayer.CharacterAdded:Connect(function(character)
    local existingMenu = Player.PlayerGui:FindFirstChild("CustomMenu")
    if existingMenu then
        existingMenu:Destroy()
    end
    
    createMenu()
end)

createMenu()
