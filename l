local MyRayfieldLibrary = {}

-- Função para criar uma janela
function MyRayfieldLibrary:CreateWindow(options)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = options.Name or "MyRayfield"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Text = options.Name or "Janela Principal"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    Title.Parent = MainFrame

    -- Retorna a janela para que elementos possam ser adicionados
    return MainFrame
end

-- Função para criar um botão
function MyRayfieldLibrary:CreateButton(parent, options)
    local Button = Instance.new("TextButton")
    Button.Name = options.Name or "Button"
    Button.Text = options.Text or "Clique Aqui"
    Button.Size = UDim2.new(0, 200, 0, 50)
    Button.Position = UDim2.new(0.5, -100, 0, 50)
    Button.AnchorPoint = Vector2.new(0.5, 0)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 18
    Button.Parent = parent

    -- Conectar o callback ao clique do botão
    Button.MouseButton1Click:Connect(function()
        if options.Callback then
            options.Callback()
        end
    end)

    return Button
end

-- Função para criar um slider
function MyRayfieldLibrary:CreateSlider(parent, options)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = "SliderFrame"
    SliderFrame.Size = UDim2.new(0, 300, 0, 50)
    SliderFrame.Position = UDim2.new(0.5, -150, 0, 120)
    SliderFrame.AnchorPoint = Vector2.new(0.5, 0)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderFrame.Parent = parent

    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Name = "SliderLabel"
    SliderLabel.Text = options.Name or "Slider"
    SliderLabel.Size = UDim2.new(1, 0, 0.5, 0)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextSize = 18
    SliderLabel.Parent = SliderFrame

    local SliderBar = Instance.new("Frame")
    SliderBar.Name = "SliderBar"
    SliderBar.Size = UDim2.new(1, -20, 0.25, 0)
    SliderBar.Position = UDim2.new(0, 10, 0.5, 0)
    SliderBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    SliderBar.Parent = SliderFrame

    local SliderButton = Instance.new("Frame")
    SliderButton.Name = "SliderButton"
    SliderButton.Size = UDim2.new(0.05, 0, 1, 0)
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.Parent = SliderBar
    SliderButton.Active = true
    SliderButton.Draggable = true

    -- Atualizar valor com base na posição do botão
    SliderButton:GetPropertyChangedSignal("Position"):Connect(function()
        local percentage = math.clamp(SliderButton.Position.X.Scale, 0, 1)
        if options.Callback then
            local value = options.Min + (options.Max - options.Min) * percentage
            options.Callback(value)
        end
    end)

    return SliderFrame
end

return MyRayfieldLibrary
