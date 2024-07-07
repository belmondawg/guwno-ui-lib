local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Library = {
    Instances = {},
    Connections = {}
}

function Library:Create(Class, Properties)
    local _Instance = Instance.new(Class);

    for Property, Value in next, Properties do
        _Instance[Property] = Value;
    end;

    return _Instance;
end;

function Library:CreateWindow(Title, Properties)
    local Window = {
        CurrentTab = nil,
        AccentColor = Properties.AccentColor,
        Size = Properties.Size,
        DragHover = false
    }

    if getgenv().Library ~= nil then
        getgenv().Library:Unload();
    end

    do
        Library.Instances["ScreenGui"] = Library:Create("ScreenGui", {
            Parent = game.CoreGui,
            ZIndexBehavior = Enum.ZIndexBehavior.Global
        })
    
        Library.Instances["MainFrame"] = Library:Create("Frame", {
            Parent = Library.Instances["ScreenGui"],
            BackgroundColor3 = Properties.AccentColor,
            Size = Window.Size,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0.5)
        })
    
        Library:Create("UIStroke", {
            Parent = Library.Instances["MainFrame"],
            Color = Color3.fromRGB(1, 1, 1)
        })
    
        Library.Instances["InnerBorder"] = Library:Create("Frame", {
            Parent = Library.Instances["MainFrame"],
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, -2, 1, -2),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 1, 0, 1)
        })
        
        Library.Instances["Body"] = Library:Create("Frame", {
            Parent = Library.Instances["InnerBorder"],
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            Size = UDim2.new(1, -2, 1, -2),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 1, 0, 1)
        })

        Library:Create("UIListLayout", {
            Parent = Library.Instances["Body"],
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    
        Library:Create("UIPadding", {
            Parent = Library.Instances["Body"],
            PaddingTop = UDim.new(0, 0),
            PaddingBottom = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8)
        })

        Library.Instances["TitleLabel"] = Library:Create("TextLabel", {
            Parent = Library.Instances["Body"],
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 20),
            Font = Enum.Font.Ubuntu,
            Text = Title,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 15.000,
            TextStrokeTransparency = 0.000,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        })
        
        Library.Instances["InnerBody"] = Library:Create("Frame", {
            Parent = Library.Instances["Body"],
            BackgroundColor3 = Color3.fromRGB(16, 16, 16),
            Size = UDim2.new(1, 0, 1, -20),
            BorderSizePixel = 0,
        })

        Library:Create("UIStroke", {
            Parent = Library.Instances["InnerBody"],
            Color = Color3.fromRGB(53, 53, 53)
        })
            
        Library:Create("UIPadding", {
            Parent = Library.Instances["InnerBody"],
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8)
        })

        Library:Create("UIListLayout", {
            Parent = Library.Instances["InnerBody"],
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        Library.Instances["TabsContainer"] = Library:Create("Frame", {
            Parent = Library.Instances["InnerBody"],
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 24),
            BorderSizePixel = 0
        })

        Library:Create("UIListLayout", {
            Parent = Library.Instances["TabsContainer"],
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    end

    function Window:AddTab(Name)
        local Tab = {
            Name = "Tab"..Name,
            Active = false,
            Hover = false,
            Groupboxes = {};
        }

        -- Render
        do 
            Library.Instances[Tab.Name] = Library:Create("Frame", {
                Parent = Library.Instances["TabsContainer"],
                Size = UDim2.new(0, 80, 1, 0),
                BorderColor3 = Color3.fromRGB(53, 53, 53),
                BorderSizePixel = 0,
              
            })
    
            Library.Instances[Tab.Name.."Button"] = Library:Create("TextButton", {
                Parent = Library.Instances[Tab.Name],
                AutoButtonColor = false,
                BackgroundColor3 = Color3.fromRGB(24, 24, 24),
                BorderColor3 = Color3.fromRGB(53, 53, 53),
                BorderSizePixel = 1,
                Selectable = false,
                Size = UDim2.new(1, 0, 1, -1),
                ZIndex = 3,
                Font = Enum.Font.Ubuntu,
                Text = Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
                TextStrokeTransparency = 0
            })
   
            Library.Instances[Tab.Name.."MainBody"] = Library:Create("Frame", {
                Parent = Library.Instances["InnerBody"],
                BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                Size = UDim2.new(1, 0, 1, -24),
                BorderSizePixel = 0,
                Visible = false
            })

            Library:Create("UIStroke", {
                Parent = Library.Instances[Tab.Name.."MainBody"],
                Color = Color3.fromRGB(53, 53, 53)
            })

            Library:Create("UIListLayout", {
                Padding = UDim.new(0, 8),
                Parent = Library.Instances[Tab.Name.."MainBody"],
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            Library:Create("UIPadding", {
                Parent = Library.Instances[Tab.Name.."MainBody"],
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 8),
                PaddingRight = UDim.new(0, 8)
            })

            Library.Instances[Tab.Name.."LeftGroupboxContainer"] = Library:Create("Frame", {
                Parent = Library.Instances[Tab.Name.."MainBody"],
                BackgroundTransparency = 1,
                Size = UDim2.new(0.5, -4, 1, 0),
                BorderSizePixel = 0,
            })

            Library:Create("UIListLayout", {
                Parent = Library.Instances[Tab.Name.."LeftGroupboxContainer"],
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            
            Library.Instances[Tab.Name.."RightGroupboxContainer"] = Library:Create("Frame", {
                Parent = Library.Instances[Tab.Name.."MainBody"],
                BackgroundTransparency = 1,
                Size = UDim2.new(0.5, -4, 1, 0),
                BorderSizePixel = 0,
            })

            Library:Create("UIListLayout", {
                Parent = Library.Instances[Tab.Name.."RightGroupboxContainer"],
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            })

        end

        -- Functions
        do 
            function Tab:Activate()         
                if not Tab.Active then
                    if Window.CurrentTab ~= nil then
                        Window.CurrentTab:Deactivate()
                    end
    
                    Tab.Active = true
    
                    Library.Instances[Tab.Name].BorderSizePixel = 1
    
                    Library.Instances[Tab.Name.."Button"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    Library.Instances[Tab.Name.."Button"].BorderSizePixel = 0
                    Library.Instances[Tab.Name.."Button"].Size = UDim2.new(1, 0, 1, 1)
                    Library.Instances[Tab.Name.."Button"].ZIndex = 2
    
                    Library.Instances[Tab.Name.."MainBody"].Visible = true
                    Window.CurrentTab = Tab
                end
            end
    
            function Tab:Deactivate()
                if Tab.Active then
                    Tab.Active = false
                    Tab.Hover = false
                    
                    Library.Instances[Tab.Name].BorderSizePixel = 0
    
                    Library.Instances[Tab.Name.."Button"].BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    Library.Instances[Tab.Name.."Button"].BorderSizePixel = 1
                    Library.Instances[Tab.Name.."Button"].Size = UDim2.new(1, 0, 1, -1)
                    Library.Instances[Tab.Name.."Button"].ZIndex = 3
            
                    Library.Instances[Tab.Name.."MainBody"].Visible = false
                end
            end
        end
        
        -- Connections
        do 
            Library.Connections[Tab.Name.."MouseEnter"] = Library.Instances[Tab.Name.."Button"].MouseEnter:Connect(function()
                Tab.Hover = true
            end)
    
            Library.Connections[Tab.Name.."MouseLeave"] = Library.Instances[Tab.Name.."Button"].MouseLeave:Connect(function()
                Tab.Hover = false
            end)
    
            Library.Connections[Tab.Name.."InputBegan"] = UserInputService.InputBegan:Connect(function(Input, GameProcessed)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if Tab.Hover then
                        Tab:Activate()
                    end
                end
            end)
        end

        -- Other
        do 
            function Tab:AddGroupbox(Title, Side)
                local Groupbox = {
                    Name = "Groupbox"..Title,
                    Toggles = {},
                    Sliders = {},
                    Buttons = {},
                };

                -- Render
                do 
                    Library.Instances[Groupbox.Name.."OuterGroupbox"] = Library:Create("Frame", {
                        Parent = Library.Instances[Tab.Name..Side],
                        Size = UDim2.new(1, 0, 0, 80),
                        BackgroundColor3 = Color3.fromRGB(16, 16, 16),
                        BorderSizePixel = 0
                    })
    
                    Library:Create("UIPadding", {
                        Parent = Library.Instances[Groupbox.Name.."OuterGroupbox"],
                        PaddingTop = UDim.new(0, 12),
                        PaddingBottom = UDim.new(0, 0),
                        PaddingLeft = UDim.new(0, 0),
                        PaddingRight = UDim.new(0, 0)
                    })
    
                    Library:Create("UIStroke", {
                        Parent = Library.Instances[Groupbox.Name.."OuterGroupbox"],
                        Color = Color3.fromRGB(53, 53, 53)
                    })
    
                    Library:Create("TextLabel", {
                        Parent = Library.Instances[Groupbox.Name.."OuterGroupbox"],
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 12, 0, -22),
                        Size = UDim2.new(1, 0, 0, 20),
                        Font = Enum.Font.Ubuntu,
                        Text = Title,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 15,
                        TextStrokeTransparency = 0,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })
    
                    Library.Instances[Groupbox.Name.."GroupboxBody"] = Library:Create("Frame", {
                        Parent = Library.Instances[Groupbox.Name.."OuterGroupbox"],
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderColor3 = Color3.fromRGB(53, 53, 53),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                    })
    
                    Library.Instances[Groupbox.Name.."GroupboxUIListLayout"] = Library:Create("UIListLayout", {
                        Parent = Library.Instances[Groupbox.Name.."GroupboxBody"],
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 6)
                    })
                end

                -- Functions
                do 
                    function Groupbox:Resize()
                        Library.Instances[Groupbox.Name.."OuterGroupbox"].Size = UDim2.new(1, 0, 0, Library.Instances[Groupbox.Name.."GroupboxUIListLayout"].AbsoluteContentSize.Y + 18)
                    end

                    function Groupbox:AddCheckbox(Title)
                        local Checkbox = {
                            Name = "Checkbox"..Title,
                            State = false,
                            Hover = false,
                            Changed = function() end
                        }

                        -- Render
                        do 
                            Library.Instances[Checkbox.Name.."Body"] = Library:Create("Frame", {
                                Parent = Library.Instances[Groupbox.Name.."GroupboxBody"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 0, 18),
                                BorderSizePixel = 0,
                            })
    
                            Library:Create("UIPadding", {
                                Parent = Library.Instances[Checkbox.Name.."Body"],
                                PaddingTop = UDim.new(0, 0),
                                PaddingBottom = UDim.new(0, 0),
                                PaddingLeft = UDim.new(0, 32),
                                PaddingRight = UDim.new(0, 0)
                            })
    
                            Library:Create("TextLabel", {
                                Parent = Library.Instances[Checkbox.Name.."Body"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 1, 0),
                                Font = Enum.Font.Ubuntu,
                                Text = Title,
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                TextSize = 15,
                                TextStrokeTransparency = 0,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextYAlignment = Enum.TextYAlignment.Top,
                            })
    
                            Library.Instances[Checkbox.Name.."Check"] = Library:Create("Frame", {
                                Parent = Library.Instances[Checkbox.Name.."Body"],
                                BackgroundColor3 = Color3.fromRGB(36, 36, 36),
                                Position = UDim2.new(0, -24, 0, 0),
                                Size = UDim2.new(0, 16, 0, 16),
                                BorderSizePixel = 0,
                            })
    
                            Library:Create("UIStroke", {
                                Parent = Library.Instances[Checkbox.Name.."Check"],
                            })
    
                            Library.Instances[Checkbox.Name.."InnerCheck"] = Library:Create("Frame", {
                                Parent = Library.Instances[Checkbox.Name.."Check"],
                                BackgroundColor3 = Color3.fromRGB(36, 36, 36),
                                Position = UDim2.new(0, 1, 0, 1),
                                Size = UDim2.new(1, -2, 1, -2),
                                BorderSizePixel = 0,
                            })
    
                            Library:Create("UIStroke", {
                                Parent = Library.Instances[Checkbox.Name.."InnerCheck"],
                                Color = Color3.fromRGB(53, 53, 53)
                            })
                        end

                        -- Functions
                        do
                            function Checkbox:OnChanged(Func)
                                Checkbox.Changed = Func
                                Func()
                            end

                            function Checkbox:Activate()
                                if Checkbox.State then
                                    Checkbox:Deactivate()
                                    return
                                end

                                Checkbox.State = true
                                Library.Instances[Checkbox.Name.."InnerCheck"].BackgroundColor3 = Window.AccentColor
                            end

                            function Checkbox:Deactivate()
                                Checkbox.State = false
                                Library.Instances[Checkbox.Name.."InnerCheck"].BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                            end
                        end

                        -- Connections
                        do                           
                            Library.Connections[Checkbox.Name.."MouseEnter"] = Library.Instances[Checkbox.Name.."Body"].MouseEnter:Connect(function()
                                Checkbox.Hover = true
                            end)

                            Library.Connections[Checkbox.Name.."MouseLeave"] = Library.Instances[Checkbox.Name.."Body"].MouseLeave:Connect(function()
                                Checkbox.Hover = false
                            end)

                            Library.Connections[Checkbox.Name.."InputBegan"] = UserInputService.InputBegan:Connect(function(Input, GameProcessed)

                                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    if Checkbox.Hover then
                                        Checkbox:Activate()
                                        Checkbox.Changed()
                                    end
                                end
                            end)
                        end

                        Groupbox:Resize()
                        return Checkbox
                    end

                    function Groupbox:AddSlider(Title, Properties)
                        local Slider = {
                            Name = "Slider"..Title,
                            CurrentValue = 0,
                            MaxSize = 0,
                            MaxValue = 20,
                            MinValue = 1,
                            DefaultValue = 1,
                            Rounding = 0,
                            Changed = function()
                            end
                        }

                        -- Unpack args
                        if Properties then
                            if Properties.DefaultValue then
                                Slider.DefaultValue = Properties.DefaultValue
                            end

                            if Properties.Rounding then
                                Slider.Rounding = Properties.Rounding
                            end

                            if Properties.MaxValue then
                                Slider.MaxValue = Properties.MaxValue
                            end

                            if Properties.MinValue then
                                Slider.MinValue = Properties.MinValue
                            end
                        end
                        
                        -- Render
                        do 
                            Library.Instances[Slider.Name.."Body"] = Library:Create("Frame", {
                                Parent = Library.Instances[Groupbox.Name.."GroupboxBody"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 0, 34),
                                BorderSizePixel = 0,
                            })

                            Library:Create("UIListLayout", {
                                Parent = Library.Instances[Slider.Name.."Body"],
                                FillDirection = Enum.FillDirection.Vertical,
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                Padding = UDim.new(0, 2)
                            })

                            Library:Create("UIPadding", {
                                Parent = Library.Instances[Slider.Name.."Body"],
                                PaddingTop = UDim.new(0, 0),
                                PaddingBottom = UDim.new(0, 0),
                                PaddingLeft = UDim.new(0, 8),
                                PaddingRight = UDim.new(0, 8)
                            })

                            Library:Create("TextLabel", {
                                Parent = Library.Instances[Slider.Name.."Body"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 0.4, 0),
                                Font = Enum.Font.Ubuntu,
                                Text = Title,
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                TextSize = 15,
                                TextStrokeTransparency = 0,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextYAlignment = Enum.TextYAlignment.Top,
                            })
                            
                            Library.Instances[Slider.Name.."OuterSliderBody"] = Library:Create("Frame", {
                                Parent = Library.Instances[Slider.Name.."Body"],
                                Size = UDim2.new(1, 0, 0, 16),
                                BorderSizePixel = 0,
                            })
                            
                            Library:Create("UIStroke", {
                                Parent =  Library.Instances[Slider.Name.."OuterSliderBody"],
                            })

                            Library.Instances[Slider.Name.."InnerSliderBody"] = Library:Create("Frame", {
                                Parent = Library.Instances[Slider.Name.."OuterSliderBody"],
                                BackgroundColor3 = Color3.fromRGB(36, 36, 36),
                                Position = UDim2.new(0, 1, 0, 1),
                                Size = UDim2.new(1, -2, 1, -2),
                                BorderSizePixel = 0,
                            })

                            Library:Create("UIStroke", {
                                Parent =  Library.Instances[Slider.Name.."InnerSliderBody"],
                                Color = Color3.fromRGB(53, 53, 53)
                            })

                            Library.Instances[Slider.Name.."SliderValue"] = Library:Create("TextLabel", {
                                Parent = Library.Instances[Slider.Name.."InnerSliderBody"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 1, 0),
                                Font = Enum.Font.Ubuntu,
                                Text = Slider.CurrentValue,
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                TextSize = 15,
                                TextStrokeTransparency = 0,
                                TextXAlignment = Enum.TextXAlignment.Center,
                                TextYAlignment = Enum.TextYAlignment.Bottom,
                                ZIndex = 3
                            })

                            Library.Instances[Slider.Name.."SliderThumb"] = Library:Create("Frame", {
                                Parent = Library.Instances[Slider.Name.."InnerSliderBody"],
                                Size = UDim2.new(0, 0, 1, 0),
                                BackgroundColor3 = Window.AccentColor,
                                BorderSizePixel = 0,
                            })

                            Library:Create("UIStroke", {
                                Parent =  Library.Instances[Slider.Name.."SliderThumb"],
                                Color = Color3.fromRGB(53, 53, 53)
                            })

                            Slider.MaxSize = Library.Instances[Slider.Name.."InnerSliderBody"].AbsoluteSize.X
                        end
                        
                        -- Functions
                        do
                            function Slider:Map(Value, MinA, MaxA, MinB, MaxB)
                                return (1 - ((Value - MinA) / (MaxA - MinA))) * MinB +
                                    ((Value - MinA) / (MaxA - MinA)) * MaxB
                            end

                            function Slider:Update()
                                local X =
                                    math.ceil(
                                    Slider:Map(Slider.CurrentValue, Slider.MinValue, Slider.MaxValue, 0, Slider.MaxSize)
                                )
                                Library.Instances[Slider.Name.."SliderValue"].Text = Slider.CurrentValue
                                Library.Instances[Slider.Name.."SliderThumb"].Size = UDim2.new(0, X, 1, 0)
                            end

                            function Slider:OnChanged(Func)
                                Slider.Changed = Func
                                Func()
                            end

                            function Slider:Round(Value)
                                if Slider.Rounding == 0 then
                                    return math.floor(Value)
                                end

                                local Str = Value .. ""
                                local Dot = Str:find("%.")

                                return Dot and tonumber(Str:sub(1, Dot + Slider.Rounding)) or Value
                            end

                            function Slider:GetValueFromXOffset(X)
                                return Slider:Round(Slider:Map(X, 0, Slider.MaxSize, Slider.MinValue, Slider.MaxValue))
                            end
                        end

                        -- Connections
                        do                           
                            Library.Connections[Slider.Name.."SliderLogic"] = Library.Instances[Slider.Name.."InnerSliderBody"].InputBegan:Connect(function(Input, GameProcessed)
                                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    local MPos = Mouse.X
                                    local GPos = Library.Instances[Slider.Name.."SliderThumb"].Size.X.Offset
                                    local Diff = MPos - (Library.Instances[Slider.Name.."SliderThumb"].AbsolutePosition.X + GPos)

                                    while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                                        local nMPos = Mouse.X
                                        local nX = math.clamp(GPos + (nMPos - MPos) + Diff, 0, Slider.MaxSize)
                                        local nValue = Slider:GetValueFromXOffset(nX)
                                      
                                        local OldValue = Slider.CurrentValue
                                        Slider.CurrentValue = nValue
                                 
                                        Slider:Update()
                                        if nValue ~= OldValue and Slider.Changed then
                                            Slider.Changed()
                                        end
                                        RunService.RenderStepped:Wait()
                                    end

                                end
                            end)
                        end

                        Slider.CurrentValue = Slider.DefaultValue
                        Slider:Update()
                        Groupbox:Resize()
                        return Slider
                    end

                    function Groupbox:AddButton(Title, Callback)
                        local Button = {
                            Name = "Button"..Title,
                            Hover = false
                        }
                                
                        -- Render
                        do 
                            Library.Instances[Button.Name.."OuterFrame"] = Library:Create("Frame", {
                                Parent = Library.Instances[Groupbox.Name.."GroupboxBody"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 0, 16),
                                BorderSizePixel = 0,
                            })

                            Library:Create("UIPadding", {
                                Parent = Library.Instances[Button.Name.."OuterFrame"],
                                PaddingTop = UDim.new(0, 0),
                                PaddingBottom = UDim.new(0, 0),
                                PaddingLeft = UDim.new(0, 8),
                                PaddingRight = UDim.new(0, 8)
                            })

                            Library.Instances[Button.Name.."OuterBody"] = Library:Create("Frame", {
                                Parent = Library.Instances[Button.Name.."OuterFrame"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 1, 0),
                                BorderSizePixel = 0,
                            })

                            Library.Instances[Button.Name.."ButtonStroke"] = Library:Create("UIStroke", {
                                Parent = Library.Instances[Button.Name.."OuterBody"],
                            })

                            Library.Instances[Button.Name.."InnerBody"] = Library:Create("Frame", {
                                Parent = Library.Instances[Button.Name.."OuterBody"],
                                BackgroundColor3 = Color3.fromRGB(36, 36, 36),
                                Position = UDim2.new(0, 1, 0, 1),
                                Size = UDim2.new(1, -2, 1, -2),
                                BorderSizePixel = 0,
                            })

                            Library:Create("UIStroke", {
                                Parent = Library.Instances[Button.Name.."InnerBody"],
                                Color = Color3.fromRGB(53, 53, 53)
                            })

                            
                            Library:Create("TextLabel", {
                                Parent = Library.Instances[Button.Name.."InnerBody"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 1, 0),
                                Font = Enum.Font.Ubuntu,
                                Text = Title,
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                TextSize = 15,
                                TextStrokeTransparency = 0,
                                TextXAlignment = Enum.TextXAlignment.Center,
                                TextYAlignment = Enum.TextYAlignment.Center,
                            })                            
                        end
                        
                        -- Connections
                        do
                            Library.Connections[Button.Name.."MouseEnter"] = Library.Instances[Button.Name.."OuterFrame"].MouseEnter:Connect(function()
                                Button.Hover = true
                                Library.Instances[Button.Name.."ButtonStroke"].Color = Window.AccentColor
                            end)

                            Library.Connections[Button.Name.."MouseLeave"] = Library.Instances[Button.Name.."OuterFrame"].MouseLeave:Connect(function()
                                Button.Hover = false
                                Library.Instances[Button.Name.."ButtonStroke"].Color = Color3.fromRGB(0, 0, 0)
                            end)

                            Library.Connections[Button.Name.."InputBegan"] = UserInputService.InputBegan:Connect(function(Input, GPE)
                                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    if Button.Hover then
                                        Callback()
                                    end
                                end
                            end)
                        end

                        Groupbox:Resize()
                        return Button
                    end

                    function Groupbox:AddDropdown(Title, Properties)
                        local Dropdown = {
                            Name = "Dropdown"..Title,
                            Items = Properties.Items,
                            Multi = Properties.Multi,
                            CurrentItem = "nan",
                            CurrentItems = {},
                            Hover = false,
                            Changed = function()
                            end
                        }                  
                        
                        -- Render
                        do 
                            Library.Instances[Dropdown.Name.."Body"] = Library:Create("Frame", {
                                Parent = Library.Instances[Groupbox.Name.."GroupboxBody"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 0, 34),
                                BorderSizePixel = 0,
                            })

                            Library:Create("UIListLayout", {
                                Parent = Library.Instances[Dropdown.Name.."Body"],
                                FillDirection = Enum.FillDirection.Vertical,
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                Padding = UDim.new(0, 2)
                            })

                            Library:Create("UIPadding", {
                                Parent = Library.Instances[Dropdown.Name.."Body"],
                                PaddingTop = UDim.new(0, 0),
                                PaddingBottom = UDim.new(0, 0),
                                PaddingLeft = UDim.new(0, 8),
                                PaddingRight = UDim.new(0, 8)
                            })

                            Library:Create("TextLabel", {
                                Parent = Library.Instances[Dropdown.Name.."Body"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 0.4, 0),
                                Font = Enum.Font.Ubuntu,
                                Text = Title,
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                TextSize = 15,
                                TextStrokeTransparency = 0,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextYAlignment = Enum.TextYAlignment.Top,
                            })
                            
                            Library.Instances[Dropdown.Name.."OuterDropdownBody"] = Library:Create("Frame", {
                                Parent = Library.Instances[Dropdown.Name.."Body"],
                                Size = UDim2.new(1, 0, 0, 16),
                                BorderSizePixel = 0,
                            })
                            
                            Library:Create("UIStroke", {
                                Parent =  Library.Instances[Dropdown.Name.."OuterDropdownBody"],
                            })

                            Library.Instances[Dropdown.Name.."InnerDropdownBody"] = Library:Create("Frame", {
                                Parent = Library.Instances[Dropdown.Name.."OuterDropdownBody"],
                                BackgroundColor3 = Color3.fromRGB(36, 36, 36),
                                Position = UDim2.new(0, 1, 0, 1),
                                Size = UDim2.new(1, -2, 1, -2),
                                BorderSizePixel = 0,
                            })

                            Library:Create("UIStroke", {
                                Parent =  Library.Instances[Dropdown.Name.."InnerDropdownBody"],
                                Color = Color3.fromRGB(53, 53, 53)
                            })

                            Library:Create("UIPadding", {
                                Parent =  Library.Instances[Dropdown.Name.."InnerDropdownBody"],
                                PaddingTop = UDim.new(0, 0),
                                PaddingBottom = UDim.new(0, 0),
                                PaddingLeft = UDim.new(0, 2),
                                PaddingRight = UDim.new(0, 2)
                            })

                            Library:Create("UIListLayout", {
                                Parent =  Library.Instances[Dropdown.Name.."InnerDropdownBody"],
                                FillDirection = Enum.FillDirection.Horizontal,
                                SortOrder = Enum.SortOrder.LayoutOrder,
                            })

                            Library.Instances[Dropdown.Name.."DropdownValue"] = Library:Create("TextLabel", {
                                Parent = Library.Instances[Dropdown.Name.."InnerDropdownBody"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, -20, 1, 0),
                                Font = Enum.Font.Ubuntu,
                                Text = Dropdown.CurrentItem,
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                TextSize = 15,
                                TextStrokeTransparency = 0,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextYAlignment = Enum.TextYAlignment.Bottom,
                                ZIndex = 3
                            })    

                            Library.Instances[Dropdown.Name.."DropdownIndicator"] = Library:Create("TextLabel", {
                                Parent = Library.Instances[Dropdown.Name.."InnerDropdownBody"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(0, 20, 1, 0),
                                Font = Enum.Font.Ubuntu,
                                Text = "+",
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                TextSize = 15,
                                TextStrokeTransparency = 0,
                                TextXAlignment = Enum.TextXAlignment.Right,
                                TextYAlignment = Enum.TextYAlignment.Bottom,
                                ZIndex = 3
                            })        

                            Library.Instances[Dropdown.Name.."DropdownMenuBody"] = Library:Create("Frame", {
                                Parent = Library.Instances[Dropdown.Name.."Body"],
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 0, 80),
                                BorderSizePixel = 0,
                                ZIndex = 5,
                                Visible = false
                            })

                            Library:Create("UIStroke", {
                                Parent =  Library.Instances[Dropdown.Name.."DropdownMenuBody"],
                                Color = Color3.fromRGB(0, 0, 0)
                            })

                            Library.Instances[Dropdown.Name.."DropdownMenuInnerBody"] = Library:Create("Frame", {
                                Parent = Library.Instances[Dropdown.Name.."DropdownMenuBody"],
                                BackgroundColor3 = Color3.fromRGB(36, 36, 36),
                                Position = UDim2.new(0, 1, 0, 1),
                                Size = UDim2.new(1, -2, 1, -2),
                                BorderSizePixel = 0,
                                ZIndex = 5,
                            })

                            Library:Create("UIStroke", {
                                Parent =  Library.Instances[Dropdown.Name.."DropdownMenuInnerBody"],
                                Color = Color3.fromRGB(53, 53, 53)
                            })

                            Library:Create("UIPadding", {
                                Parent =  Library.Instances[Dropdown.Name.."DropdownMenuInnerBody"],
                                PaddingTop = UDim.new(0, 0),
                                PaddingBottom = UDim.new(0, 0),
                                PaddingLeft = UDim.new(0, 2),
                                PaddingRight = UDim.new(0, 2)
                            })

                            Library.Instances[Dropdown.Name.."DropdownMenuUIListLayout"] = Library:Create("UIListLayout", {
                                Parent =  Library.Instances[Dropdown.Name.."DropdownMenuInnerBody"],
                                FillDirection = Enum.FillDirection.Vertical,
                                SortOrder = Enum.SortOrder.LayoutOrder
                            })     
                        end
                        
                        -- Functions
                        do 
                            function Dropdown:Resize()
                                Library.Instances[Dropdown.Name.."DropdownMenuBody"].Size = UDim2.new(1, 0, 0, Library.Instances[Dropdown.Name.."DropdownMenuUIListLayout"] .AbsoluteContentSize.Y + 4)
                            end

                            function Dropdown:OnChanged(Func)
                                Dropdown.Changed = Func
                                Func()
                            end

                            function Dropdown:SetActive(Item) -- :skull: todo: refactor this monstrosity
                                if Dropdown.Multi then 
                                    local exit = false
                                    for _, _Item in next, Dropdown.CurrentItems do 
                                        if _Item == Item then 
                                            Dropdown.CurrentItems[Item.Name] = nil
                                            Library.Instances[Dropdown.Name.."Item"..Item.Name].BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                                            exit = true
                                            break
                                        end
                                    end
                                    if exit then 
                                        return
                                    else 
                                        Library.Instances[Dropdown.Name.."Item"..Item.Name].BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                                        Dropdown.CurrentItems[Item.Name] = Item
                                    end
                                else 
                                    for Key, _Item in next, Dropdown.CurrentItems do 
                                        if _Item ~= Item then 
                                            Library.Instances[Dropdown.Name.."Item".._Item.Name].BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                                            Dropdown.CurrentItems = {}
                                        end
                                    end
                                    Dropdown.CurrentItems[Item.Name] = Item
                                    Library.Instances[Dropdown.Name.."Item"..Item.Name].BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                                end
                            end

                            function Dropdown:UpdateIndicator()
                                local Value = ""

                                for _, Item in next, Dropdown.CurrentItems do 
                                    Value = Value.." "..Item.Name
                                end

                                Library.Instances[Dropdown.Name.."DropdownValue"].Text = string.sub(Value, 1, 20)

                                if string.len(Value) == 0 then 
                                    Library.Instances[Dropdown.Name.."DropdownValue"].Text = "nan"
                                end
                            end

                            function Dropdown:AddItem(Item)
                                local ItemData = {
                                    Name = Item,
                                    IsSelected = false,
                                    Hover = false,
                                }

                                -- Render
                                do 
                                    Library.Instances[Dropdown.Name.."Item"..ItemData.Name] = Library:Create("Frame", {
                                        Parent = Library.Instances[Dropdown.Name.."DropdownMenuInnerBody"],
                                        BackgroundColor3 = Color3.fromRGB(36, 36, 36),
                                        Size = UDim2.new(1, 0, 0, 18),
                                        BorderSizePixel = 0,
                                        ZIndex = 7
                                    })

                                    Library:Create("UIPadding", {
                                        Parent = Library.Instances[Dropdown.Name.."Item"..ItemData.Name],
                                        PaddingTop = UDim.new(0, 0),
                                        PaddingBottom = UDim.new(0, 0),
                                        PaddingLeft = UDim.new(0, 2),
                                        PaddingRight = UDim.new(0, 2)
                                    })
    
                                    Library:Create("TextLabel", {
                                        Parent = Library.Instances[Dropdown.Name.."Item"..ItemData.Name],
                                        BackgroundTransparency = 1,
                                        Size = UDim2.new(1, 0, 1, 0),
                                        Font = Enum.Font.Ubuntu,
                                        Text = ItemData.Name,
                                        TextColor3 = Color3.fromRGB(255, 255, 255),
                                        TextSize = 15,
                                        TextStrokeTransparency = 0,
                                        TextXAlignment = Enum.TextXAlignment.Left,
                                        TextYAlignment = Enum.TextYAlignment.Center,
                                        ZIndex = 8
                                    }) 
                                end 

                                -- Connections
                                do 
                                    Library.Connections[Dropdown.Name..Item.."MouseEnter"] =  Library.Instances[Dropdown.Name.."Item"..Item].MouseEnter:Connect(function()
                                        ItemData.Hover = true
                                    end)
        
                                    Library.Connections[Dropdown.Name..Item.."MouseLeave"] =  Library.Instances[Dropdown.Name.."Item"..Item].MouseLeave:Connect(function()
                                        ItemData.Hover = false              
                                    end)
        
                                    Library.Connections[Dropdown.Name..Item.."InputBegan"] = UserInputService.InputBegan:Connect(function(Input, GPE)
                                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                            if ItemData.Hover then
                                                Dropdown:SetActive(ItemData)
                                                Dropdown.Changed()
                                                Dropdown:UpdateIndicator()
                                            end
                                        end
                                    end)
                                end
                                if next(Dropdown.CurrentItems) == nil then 
                                    Dropdown:SetActive(ItemData)
                                    Dropdown.Changed()
                                    Dropdown:UpdateIndicator()
                                end
                                Dropdown:Resize()
                                return ItemData
                            end
                            
                            function Dropdown:RemoveItem(Item)
                                if not Library.Instances[Dropdown.Name.."Item"..Item] then 
                                    return 
                                end

                                Library.Instances[Dropdown.Name.."Item"..Item]:Destroy()
                                Library.Connections[Dropdown.Name..Item.."MouseEnter"]:Disconnect()
                                Library.Connections[Dropdown.Name..Item.."MouseLeave"]:Disconnect()
                                Library.Connections[Dropdown.Name..Item.."InputBegan"]:Disconnect()

                                Dropdown:Resize()
                                return ItemData
                            end

                            for _, Item in next, Dropdown.Items  do
                                Dropdown:AddItem(Item)
                            end
                        end

                        -- Connections
                        do
                            Library.Connections[Dropdown.Name.."MouseEnter"] = Library.Instances[Dropdown.Name.."OuterDropdownBody"].MouseEnter:Connect(function()
                                Dropdown.Hover = true
                            end)

                            Library.Connections[Dropdown.Name.."MouseLeave"] = Library.Instances[Dropdown.Name.."OuterDropdownBody"].MouseLeave:Connect(function()
                                Dropdown.Hover = false              
                            end)

                            Library.Connections[Dropdown.Name.."InputBegan"] = UserInputService.InputBegan:Connect(function(Input, GPE)
                                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    if Dropdown.Hover then
                                        Library.Instances[Dropdown.Name.."DropdownMenuBody"].Visible = not Library.Instances[Dropdown.Name.."DropdownMenuBody"].Visible
                                        if Library.Instances[Dropdown.Name.."DropdownMenuBody"].Visible then 
                                            Library.Instances[Dropdown.Name.."DropdownIndicator"].Text = "-"
                                        else 
                                            Library.Instances[Dropdown.Name.."DropdownIndicator"].Text = "+"
                                        end
                                    end
                                end
                            end)
                        end

                        Groupbox:Resize()
                        return Dropdown
                    end
                end

                return Groupbox
            end

            function Tab:AddLeftGroupbox(Title)
                return Tab:AddGroupbox(Title, "LeftGroupboxContainer")
            end
    
            function Tab:AddRightGroupbox(Title)
                return Tab:AddGroupbox(Title, "RightGroupboxContainer")
            end
        end 
        
        if Window.CurrentTab == nil then
            Tab:Activate()
        end
        return Tab
    end

    function Window:HandleInput()
        Library.Connections["MainInput"] = UserInputService.InputBegan:Connect(function(Input)
            -- Hide/Open
            if Input.KeyCode == Enum.KeyCode.Insert then
                Library.Instances["ScreenGui"].Enabled = not Library.Instances["ScreenGui"].Enabled
            end

            -- Drag
            do
                Library.Connections["MainMouseEnter"] = Library.Instances["TitleLabel"].MouseEnter:Connect(function()
                    Window.DragHover = true
                end)

                Library.Connections["MainMouseLeave"] = Library.Instances["TitleLabel"].MouseLeave:Connect(function()
                    Window.DragHover = false 
                end)

                if Input.UserInputType == Enum.UserInputType.MouseButton1 and Window.DragHover then
                    local ObjPos =
                        Vector2.new(
                        Mouse.X - Library.Instances["MainFrame"].AbsolutePosition.X,
                        Mouse.Y - Library.Instances["MainFrame"].AbsolutePosition.Y
                    )
                    while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                        Library.Instances["MainFrame"].Position =
                        UDim2.new(
                            0,
                            Mouse.X - ObjPos.X + (Library.Instances["MainFrame"].Size.X.Offset * Library.Instances["MainFrame"].AnchorPoint.X),
                            0,
                            Mouse.Y - ObjPos.Y + (Library.Instances["MainFrame"].Size.Y.Offset * Library.Instances["MainFrame"].AnchorPoint.Y)
                        )
                        RunService.RenderStepped:Wait()
                    end
                end
            end
        end)
    end

    Window:HandleInput()

    getgenv().Library = Library
    return Window 
end

function Library:Unload()
    for _, _Instance in next, Library.Instances do 
        _Instance:Destroy()
    end

    for _, Connection in next, Library.Connections do 
        Connection:Disconnect()
    end

    Library = nil;
end

return Library
