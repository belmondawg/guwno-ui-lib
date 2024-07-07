local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/belmondawg/guwno-ui-lib/main/library.lua"))();

local Window = Library:CreateWindow("guwnohook", {
    AccentColor = Color3.fromRGB(255, 255, 255),
    Size = UDim2.new(0, 400, 0, 500)
})

local Tab1 = Window:AddTab("tab 1")

local LeftGroupbox = Tab1:AddLeftGroupbox("groupbox 1")

local Checkbox = LeftGroupbox:AddCheckbox("checkbox") -- Checkbox.State to read value
Checkbox:OnChanged(function()
    print(Checkbox.State)
end)

local Slider = LeftGroupbox:AddSlider("slider", { -- Slider.CurrentValue to read value
    DefaultValue = 10, 
    Rounding = 0, 
    -- Rounding 0: 1
    -- Rounding 1: 1.1
    -- Rounding 2: 1.11
    MinValue=1, 
    MaxValue=20 
}) 
Slider:OnChanged(function()
    print(Slider.CurrentValue)
end)

local Button = LeftGroupbox:AddButton("button", function()
    print("clicked");
end);

local Dropdown = LeftGroupbox:AddDropdown("dropdown", { 
    Multi = true,
    Items = {"item 1", "item 2", "item 3"}
})
Dropdown:OnChanged(function()
    for _, v in next, Dropdown.CurrentItems do 
        print(v.Name)
    end
end)
