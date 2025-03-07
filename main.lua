pcall(function(...)

---@diagnostic disable-next-line: deprecated
function Nothing() end
_G.SecureMethod = "NoSecure"
_G.Mobile = false
local randomString=function(a)
    if type(a)~="number" then 
        error("function string.random: count of char is not a number!")
        return""
    end
    local b=""
    for c=1,a do
        local rnd = math.random(1,3)
        if rnd == 1 then
            b=b..string.char(math.random(48,57))
        elseif rnd == 2 then
            b=b..string.char(math.random(65,90))
        else
            b=b..string.char(math.random(97,122))
        end
        
    end
    return b 
end
--local CFrame=CFrame;local Vector3 = Vector3;local Vector2=Vector2;local UDim2=UDim2;local Color3=Color3;local Instance=Instance;local spawn=spawn;local workspace=workspace;local Enum=Enum;local wait=wait;local math=math;local ColorSequence=ColorSequence;local ColorSequenceKeypoint=ColorSequenceKeypoint;local NumberSequence=NumberSequence;local NumberSequenceKeypoint=NumberSequenceKeypoint;
local coreLocked = pcall(function()
	local a=Instance.new("Folder",game:GetService("CoreGui"))
end)
coreLocked=not coreLocked
local guiPlacing
if coreLocked then 
	guiPlacing = game:GetService("Players").LocalPlayer.PlayerGui 
else 
	guiPlacing = game:GetService("CoreGui") 
end

local Colorize = {}
local Drawing = {}
if _G.OptimizeMenu ~= true then
    _G.OptimizeMenu = false
end
local gui = {
    objs = {
        Gui = Instance.new("ScreenGui", guiPlacing),
    },
    page = {nil, 1},
    Loaded = true
}
gui["Hooks"] = {}
gui.objs["Gui"].Name = "RobloxGui"
gui.objs["Gui"].IgnoreGuiInset = true
gui.objs["Gui"].Enabled = true
gui.objs["Gui"].ResetOnSpawn = false
local Draws = Instance.new("Folder", gui.objs["Gui"])
Draws.Name = "Drawings"
do
    local game = game
    local GetService, FindFirstChild = game.GetService, game.FindFirstChild
    local IsA = game.IsA
    local Vector2new, Instancenew, UDim2new = Vector2.new, Instance.new, UDim2.new

    local Workspace = GetService(game, "Workspace");
    local Camera = FindFirstChild(Workspace, "Camera");
    local CoreGui = GetService(game, "CoreGui");

    local BaseDrawingProperties = setmetatable({
        Visible = false,
        Color = Color3.new(),
        Transparency = 0,
        Remove = function()
        end
    }, {
        __add = function(tbl1, tbl2)
            local new = {}
            for i, v in next, tbl1 do
                new[i] = v
            end
            for i, v in next, tbl2 do
                new[i] = v
            end
            return new
        end
    })

    Drawing.new = function(Type, UI)
        UI = Draws
        if (Type == "Text") then
            local TextProperties = ({
                Text = "",
                Font = "",
                Size = 10,
                XAlign = "Center",
                YAlign = "Center",
            } + BaseDrawingProperties)
            local TextLabel = Instancenew("TextLabel")
            TextLabel.Parent = UI
            TextLabel.Text = ""
            TextLabel.BackgroundTransparency = 1
            TextLabel.TextColor3 = TextProperties.Color
            TextLabel.TextSize = TextProperties.Size
            TextLabel.TextXAlignment = Enum.TextXAlignment.Center
            TextLabel.Visible = false
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Position") then
                        TextLabel.Position = UDim2.fromOffset(Value.X,Value.Y)
                        TextProperties.Position = Value
                    end
                    if (Property == "Transparency") then
                        TextLabel.TextTransparency = Value
                        TextProperties.Transparency = Value
                    end
                    if (Property == "Text") then
                        TextLabel.Text = Value
                        TextProperties.Text = Value
                    end
                    if (Property == "Size") then
                        TextLabel.TextSize = Value
                        TextProperties.Size = Value
                    end
                    if (Property == "Color") then
                        TextLabel.TextColor3 = Value
                        TextProperties.Color = Value
                    end
                    if (Property == "XAlign") then
                        TextLabel.TextXAlignment = Enum.TextXAlignment[Value]
                        TextProperties.XAlign = Enum.TextXAlignment[Value]
                    end
                    if (Property == "YAlign") then
                        TextLabel.TextYAlignment = Enum.TextXYlignment[Value]
                        TextProperties.YAlign = Enum.TextXYlignment[Value]
                    end
                    if (Property == "Visible") then
                        TextLabel.Visible = Value
                        TextProperties.Visible = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            TextLabel:Destroy();
                        end)
                    end
                    
                    return TextProperties[Property]
                end)
            })
        end
        if (Type == "Line") then
            local LineProperties = ({
                To = Vector2new(),
                From = Vector2new(),
                Thickness = 1,
                Fade = {Enabled=false,Rotation=0,Color=Color3.new()},
            } + BaseDrawingProperties)

            local LineFrame = Instancenew("Frame");
            LineFrame.AnchorPoint = Vector2new(0.5, 0.5);
            LineFrame.BorderSizePixel = 0
            LineFrame.BackgroundColor3 = LineProperties.Color
            LineFrame.Visible = LineProperties.Visible
            LineFrame.BackgroundTransparency = LineProperties.Transparency
            LineFrame.Parent = UI
            
            local UIFade = Instance.new("UIGradient",LineFrame)

            UIFade.Rotation = LineProperties.Rotation
            UIFade.Enabled = LineProperties.Fade.Enabled

            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Fade") then
                        
                        if typeof(Value[1]) ~= typeof(Color3.new()) then 
                            warn("attempt set color to "..typeof(Value[1]).." value!")
                        else
                            LineProperties.Fade.Color = Value[1]
                        end
                        if Value[2] then
                            LineProperties.Fade.Rotation = Value[2]
                        end
                        if Value[3] then
                            LineProperties.Fade.Enabled = Value[3]
                        end
                    end
                    if (Property == "Color") then
                        LineFrame.BackgroundColor3 = Value
                        LineProperties.Color = Value
                    end
                    if (Property == "Visible") then
                        LineFrame.Visible = Value
                        LineProperties.Visible = Value
                    end
                    if (Property == "Thickness") then
                        --TODO
                        LineProperties.Thickness = Value
                    end
                    if (Property == "Transparency") then
                        LineFrame.BackgroundTransparency = Value
                        LineProperties.Transparency = Value
                    end

                    if (Property == "To") then
                        local To = Value
                        local Direction = (To - LineProperties.From);
                        local Center = (To + LineProperties.From) / 2
                        local Distance = Direction.Magnitude
                        local Theta = math.atan2(Direction.Y, Direction.X);

                        LineFrame.Position = UDim2.fromOffset(Center.X, Center.Y);
                        LineFrame.Rotation = math.deg(Theta);
                        LineFrame.Size = UDim2.fromOffset(Distance, LineProperties.Thickness);

                        LineProperties.To = To
                    end
                    if (Property == "From") then
                        local From = Value
                        local Direction = (LineProperties.To - From);
                        local Center = (LineProperties.To + From) / 2
                        local Distance = Direction.Magnitude
                        local Theta = math.atan2(Direction.Y, Direction.X);

                        LineFrame.Position = UDim2.fromOffset(Center.X, Center.Y);
                        LineFrame.Rotation = math.deg(Theta);
                        LineProperties.From = From
                    end
                    if (Property == "Visible") then
                        LineFrame.Visible = Value
                        LineProperties.Visible = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            LineFrame:Destroy();
                        end)
                    end
                    
                    return LineProperties[Property]
                end)
            })
        end
        if (Type == "Square") then
            local SquareProperties = ({
                Thickness = 1,
                Size = Vector2new(),
                Position = Vector2new(),
                Filled = false,
                XAlign = "Left",
                YAlign = "Top",
                Fade = {Enabled=false,Rotation=0,Color=Color3.new()},
            } + BaseDrawingProperties);

            local SquareFrame = Instance.new("Frame");
            SquareFrame.AnchorPoint = Vector2new(0, 0);
            SquareFrame.BorderSizePixel = 0
            SquareFrame.Visible = false
            SquareFrame.Parent = UI
            local UIFade = Instance.new("UIGradient",SquareFrame)
            UIFade.Rotation = SquareProperties.Rotation
            UIFade.Enabled = SquareProperties.Fade.Enabled
            local UIOutline = Instance.new("UIStroke")
            UIOutline.Thickness = SquareProperties.Thickness
            UIOutline.Enabled = false
            UIOutline.Parent = SquareFrame
            local UIFade2 = UIFade:Clone()
            UIFade2.Parent = UIOutline
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Fade") then
                        --print(Value[1],Value[2],Value[3])
                        if typeof(Value[1]) ~= typeof(Color3.new()) then 
                            warn("attempt set color to "..typeof(Value[1]).." value!")
                        else
                            SquareProperties.Fade.Color = Value[1]
                        end
                        if Value[2] then
                            SquareProperties.Fade.Rotation = Value[2]
                        end
                        if Value[3] then
                            SquareProperties.Fade.Enabled = Value[3]
                        end
                    end
                    if (Property == "Size") then
                        SquareFrame.Size = UDim2new(0, Value.X, 0, Value.Y);
                        SquareProperties.Size = Value
                    end
                    if (Property == "Position") then
                        SquareFrame.Position = UDim2new(0, Value.X, 0, Value.Y);
                        SquareProperties.Position = Value
                    end
                    if (Property == "Color") then
                        SquareFrame.BackgroundColor3 = Value
                        UIOutline.Color = Value
                        SquareProperties.Color = Value
                    end
                    if (Property == "Transparency") then
                        if SquareProperties.Filled == true then
                            SquareFrame.BackgroundTransparency = Value
                        else
                            UIOutline.Transparency = Value
                        end
                        SquareProperties.Transparency = Value
                    end
                    if (Property == "Visible") then
                        if Value == true then
                            SquareFrame.Visible = true
                            if SquareProperties.Filled == true then
                                SquareFrame.BackgroundTransparency = SquareProperties.Transparency
                                UIOutline.Enabled = false
                            else
                                SquareFrame.BackgroundTransparency = 1
                                UIOutline.Enabled = true
                            end
                        else
                            SquareFrame.Visible = false
                            UIOutline.Enabled = false
                        end
                        SquareProperties.Visible = Value
                    end
                    if (Property == "Filled") then -- idi naxyi
                        if SquareProperties.Visible == true then
                            if Value == false then
                                SquareFrame.BackgroundTransparency = 1
                            else
                                SquareFrame.BackgroundTransparency = SquareProperties.Transparency
                            end
                            UIOutline.Enabled = not Value
                        end
                        SquareProperties.Filled = Value
                    end
                    if (Property == "XAlign") then
                        if Value == "Left" then
                            SquareFrame.AnchorPoint = Vector2new(0,SquareFrame.AnchorPoint.Y)
                        elseif Value == "Center" then
                            SquareFrame.AnchorPoint = Vector2new(0.5,SquareFrame.AnchorPoint.Y)
                        elseif Value == "Right" then
                            SquareFrame.AnchorPoint = Vector2new(-1,SquareFrame.AnchorPoint.Y)
                        end
                        SquareProperties.XAlign = Value
                    end
                    if (Property == "YAlign") then
                        if Value == "Top" then
                            SquareFrame.AnchorPoint = Vector2new(SquareFrame.AnchorPoint.X, 0)
                        elseif Value == "Center" then
                            SquareFrame.AnchorPoint = Vector2new(SquareFrame.AnchorPoint.X, 0.5)
                        elseif Value == "Bottom" then
                            SquareFrame.AnchorPoint = Vector2new(SquareFrame.AnchorPoint.X, -1)
                        end
                        SquareProperties.YAlign = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            SquareFrame:Destroy();
                        end)
                    end
                    
                    return SquareProperties[Property]
                end)
            })
        end
        if (Type == "Image") then
            local ImageProperties = ({
                Data = "rbxassetid://848623155",
                Size = Vector2new(),
                Position = Vector2new(),
                Rounding = 0,
            });

            local ImageLabel = Instancenew("ImageLabel");

            ImageLabel.AnchorPoint = Vector2new(0.5, 0.5);
            ImageLabel.BorderSizePixel = 0
            ImageLabel.ScaleType = Enum.ScaleType.Stretch
            ImageLabel.Transparency = 1
            
            ImageLabel.Visible = false
            ImageLabel.Parent = UI

            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Position") then
                        ImageLabel.Position = UDim2new(0, Value.X, 0, Value.Y);
                        ImageProperties.Position = Value
                    end
                    if (Property == "Size") then
                        ImageLabel.Size = UDim2new(0, Value.X, 0, Value.Y);
                        ImageProperties.Size = Value
                    end
                    if (Property == "Transparency") then
                        ImageLabel.ImageTransparency = Value
                        ImageProperties.Transparency = Value
                    end
                    if (Property == "Visible") then
                        ImageLabel.Visible = Value
                        ImageProperties.Visible = Value
                    end
                    if (Property == "Color") then
                        ImageLabel.ImageColor3 = Value
                        ImageLabel.Color = Value
                    end
                    if (Property == "Data") then
                        ImageLabel.Image = Value
                        ImageProperties.Data = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            ImageLabel:Destroy();
                        end)
                    end
                    
                    return ImageLabel[Property]
                end)
            })
        end
        if (Type == "Circle") then
            local CircleProperties = ({
                Radius = 50,
                Thickness = 1,
                Position = Vector2new(),
                Filled = false,
                XAlign = "Center",
                YAlign = "Center",
            } + BaseDrawingProperties);

            local CircleFrame = Instancenew("Frame");
            CircleFrame.AnchorPoint = Vector2new(0.5, 0.5);
            CircleFrame.BorderSizePixel = 0
            CircleFrame.Visible = false
            CircleFrame.Parent = UI
            CircleFrame.Size = UDim2new(0, 100, 0, 100);
            local UIOutline = Instancenew("UIStroke")
            UIOutline.Thickness = CircleProperties.Thickness
            UIOutline.Enabled = false
            UIOutline.Parent = CircleFrame
            local UICorner = Instancenew("UICorner")
            UICorner.CornerRadius = UDim.new(1,0)
            UICorner.Parent = CircleFrame
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Radius") then
                        CircleFrame.Size = UDim2new(0, Value, 0, Value);
                        CircleProperties.Radius = Value
                    end
                    if (Property == "Thickness") then
                        UIOutline.Thickness = Value
                        CircleProperties.Thickness = Value
                    end
                    if (Property == "XAlign") then
                        if Value == "Left" then
                            CircleFrame.AnchorPoint = Vector2new(0,CircleFrame.AnchorPoint.Y)
                        elseif Value == "Center" then
                            CircleFrame.AnchorPoint = Vector2new(0.5,CircleFrame.AnchorPoint.Y)
                        elseif Value == "Right" then
                            CircleFrame.AnchorPoint = Vector2new(-1,CircleFrame.AnchorPoint.Y)
                        end
                        CircleProperties.XAlign = Value
                    end
                    if (Property == "YAlign") then
                        if Value == "Top" then
                            CircleFrame.AnchorPoint = Vector2new(CircleFrame.AnchorPoint.X, 0)
                        elseif Value == "Center" then
                            CircleFrame.AnchorPoint = Vector2new(CircleFrame.AnchorPoint.X, 0.5)
                        elseif Value == "Bottom" then
                            CircleFrame.AnchorPoint = Vector2new(CircleFrame.AnchorPoint.X, -1)
                        end
                        CircleProperties.YAlign = Value
                    end
                    if (Property == "Position") then
                        local x = Value.X
                        local y = Value.Y
                        CircleFrame.Position = UDim2new(0, x, 0, y);
                        CircleProperties.Position = Value
                    end
                    if (Property == "Color") then
                        CircleFrame.BackgroundColor3 = Value
                        UIOutline.Color = Value
                        CircleProperties.Color = Value
                    end
                    if (Property == "Transparency") then
                        if CircleProperties.Filled == true then
                            CircleFrame.BackgroundTransparency = Value
                        else
                            UIOutline.Transparency = Value
                        end
                        CircleProperties.Transparency = Value
                    end
                    if (Property == "Visible") then
                        if Value == true then
                            CircleFrame.Visible = true
                            if CircleProperties.Filled == true then
                                CircleFrame.BackgroundTransparency = CircleProperties.Transparency
                                UIOutline.Enabled = false
                            else
                                CircleFrame.BackgroundTransparency = 1
                                UIOutline.Enabled = true
                            end
                        else
                            CircleFrame.Visible = false
                            UIOutline.Enabled = false
                        end
                        CircleProperties.Visible = Value
                    end
                    if (Property == "Filled") then -- idi naxyi
                        if CircleProperties.Visible == true then
                            if Value == false then
                                CircleFrame.BackgroundTransparency = 1
                            else
                                CircleFrame.BackgroundTransparency = CircleProperties.Transparency
                            end
                            UIOutline.Enabled = not Value
                        end
                        CircleProperties.Filled = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            CircleFrame:Destroy();
                        end)
                    end
                    
                    return CircleProperties[Property]
                end)
            });
        end
        if (Type == "Quad") then -- will add later
            return setmetatable({}, {
                
            });
        end
    end
end
do
    Colorize.RGB = {}
    function Colorize.RGB:Darkness(color, factor)
        color.R = math.clamp(color.R * factor,0,255)
        color.G = math.clamp(color.G * factor,0,255)
        color.B = math.clamp(color.B * factor,0,255)
        return color
    end
end
gui["pages"] = {}
if guiPlacing.Name == "CoreGui" then
    gui.objs["NotifyCore"] = guiPlacing:WaitForChild("RobloxGui")
else
    gui.objs["NotifyCore"] = Instance.new("ScreenGui", guiPlacing)
end
gui.objs["NotifyCore"].ResetOnSpawn = false

gui.objs["Notify"] = Instance.new("Frame", gui.objs["NotifyCore"])
gui.objs["Notify"].BorderSizePixel = 1
gui.objs["Notify"].BorderColor3 = Color3.new(0,0,0)
gui.objs["Notify"].Position = UDim2.new(0, 50, 0, game:GetService("Workspace").CurrentCamera.ViewportSize.y - 150)
gui.objs["Notify"].Size = UDim2.new(0, 220, 0, 100)
gui.objs["Notify"].BackgroundColor3 = Color3.fromRGB(50,50,50)
gui.objs["Notify"].Visible = false

gui.objs["NotifyUp"] = Instance.new("Frame", gui.objs["Notify"])
gui.objs["NotifyUp"].Name = "Bar"
gui.objs["NotifyUp"].BorderSizePixel = 0
gui.objs["NotifyUp"].Size = UDim2.new(0, 220, 0, 10)
gui.objs["NotifyUp"].Position = UDim2.fromOffset(0, 0)
gui.objs["NotifyUp"].BackgroundColor3 = Color3.fromRGB(68,68,68)

gui.objs["NotifyTitle"] = Instance.new("TextLabel", gui.objs["NotifyUp"])
gui.objs["NotifyTitle"].Name = "Title"
gui.objs["NotifyTitle"].BackgroundTransparency = 1
gui.objs["NotifyTitle"].TextSize = 7
gui.objs["NotifyTitle"].TextColor3 = Color3.fromRGB(255,255,255)
gui.objs["NotifyTitle"].Text = "Title"
gui.objs["NotifyTitle"].Size = UDim2.new(0, 220, 0, 10)

gui.objs["NotifyText"] = Instance.new("TextLabel", gui.objs["NotifyUp"])
gui.objs["NotifyText"].Name = "Text"
gui.objs["NotifyText"].BackgroundTransparency = 1
gui.objs["NotifyText"].TextSize = 10
gui.objs["NotifyText"].Text = "Text"
gui.objs["NotifyText"].TextColor3 = Color3.fromRGB(255,255,255)
gui.objs["NotifyText"].Size = UDim2.new(0, 220, 0, 90)
gui.objs["NotifyText"].Position = UDim2.fromOffset(0, 10)

local notifyQueue = {}
local notifyCount = 0

function gui:Notify(Title,Text,time)
    notifyCount = notifyCount + 1
    gui.objs["NotifyTitle"].Text = Title or ""
    gui.objs["NotifyText"].Text = Text or ""
    gui.objs["Notify"].Visible = true
    spawn(function()
        wait(time or 3.5)
        gui.objs["Notify"].Visible = false
    end)
    --return true
end

--[[gui.objs["Gui"].Name = randomString(math.random(5,13))
game:GetService("RunService").RenderStepped:Connect(function()
    gui.objs["Gui"].Name = randomString(math.random(5,20))
end)]]

function gui:Modal(title, button1, button2)
    local selection = false
    local startup = {}
    startup["Frame"] = Instance.new("Frame")
    startup["Frame"].Parent = gui.objs["Gui"]
    startup["Frame"].BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    startup["Frame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["Frame"].BorderSizePixel = 0
    startup["Frame"].Size = UDim2.new(0, 182, 0, 58)
    startup["Frame"].Position = UDim2.fromOffset(gui.objs["Gui"].AbsoluteSize.X/2-startup["Frame"].AbsoluteSize.X/2, gui.objs["Gui"].AbsoluteSize.Y/2-startup["Frame"].AbsoluteSize.Y/2)
    startup["UIStroke"] = Instance.new("UIStroke")
    startup["UIStroke"].Color = Color3.new(1,1,1)
    startup["UIStroke"].Thickness = 1
    startup["UIStroke"].Parent = startup["Frame"]
    startup["Title"] = Instance.new("TextLabel")
    startup["Title"].Name = "Title"
    startup["Title"].Parent = startup["Frame"]
    startup["Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    startup["Title"].BackgroundTransparency = 1.000
    startup["Title"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["Title"].BorderSizePixel = 0
    startup["Title"].Size = UDim2.new(0, 181, 0, 15)
    startup["Title"].Font = Enum.Font.SourceSans
    startup["Title"].Text = " "..title
    startup["Title"].TextColor3 = Color3.fromRGB(255, 255, 255)
    startup["Title"].TextSize = 14.000
    startup["Title"].TextXAlignment = Enum.TextXAlignment.Left
    startup["UIGradient"] = Instance.new("UIGradient")
    startup["UIGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(184, 184, 184))}
    startup["UIGradient"].Rotation = -90
    startup["UIGradient"].Parent = startup["Title"]
    startup["UIGradient_2"] = Instance.new("UIGradient")
    startup["UIGradient_2"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(186, 186, 186))}
    startup["UIGradient_2"].Rotation = 52
    startup["UIGradient_2"].Parent = startup["Frame"]
    startup["UIGradient_21"] = Instance.new("UIGradient")
    startup["UIGradient_21"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
    startup["UIGradient_21"].Rotation = 70
    startup["UIGradient_21"].Parent = startup["UIStroke"]
    startup["Frame_2"] = Instance.new("Frame")
    startup["Frame_2"].Parent = startup["Frame"]
    startup["Frame_2"].BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    startup["Frame_2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["Frame_2"].Position = UDim2.new(0, 10, 0, 23)
    startup["Frame_2"].Size = UDim2.new(0, 77, 0, 24)
    startup["UIGradient_3"] = Instance.new("UIGradient")
    startup["UIGradient_3"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(213, 213, 213))}
    startup["UIGradient_3"].Rotation = -125
    startup["UIGradient_3"].Parent = startup["Frame_2"]
    startup["TextLabel"] = Instance.new("TextLabel")
    startup["TextLabel"].Parent = startup["Frame_2"]
    startup["TextLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    startup["TextLabel"].BackgroundTransparency = 1.000
    startup["TextLabel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["TextLabel"].BorderSizePixel = 0
    startup["TextLabel"].Size = UDim2.new(0, 77, 0, 24)
    startup["TextLabel"].Font = Enum.Font.SourceSans
    startup["TextLabel"].Text = button1
    startup["TextLabel"].TextColor3 = Color3.fromRGB(255, 255, 255)
    startup["TextLabel"].TextSize = 14.000
    startup["UIGradient_4"] = Instance.new("UIGradient")
    startup["UIGradient_4"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.24, Color3.fromRGB(253, 253, 253)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(102, 102, 102))}
    startup["UIGradient_4"].Rotation = -125
    startup["UIGradient_4"].Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.63, 0.36), NumberSequenceKeypoint.new(1.00, 0.00)}
    startup["UIGradient_4"].Parent = startup["TextLabel"]
    startup["Frame_3"] = Instance.new("Frame")
    startup["Frame_3"].Parent = startup["Frame"]
    startup["Frame_3"].BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    startup["Frame_3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["Frame_3"].Position = UDim2.new(0, 96, 0, 23)
    startup["Frame_3"].Size = UDim2.new(0, 77, 0, 24)
    startup["UIGradient_5"] = Instance.new("UIGradient")
    startup["UIGradient_5"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(213, 213, 213))}
    startup["UIGradient_5"].Rotation = -125
    startup["UIGradient_5"].Parent = startup["Frame_3"]
    startup["TextLabel_2"] = Instance.new("TextLabel")
    startup["TextLabel_2"].Parent = startup["Frame_3"]
    startup["TextLabel_2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    startup["TextLabel_2"].BackgroundTransparency = 1.000
    startup["TextLabel_2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["TextLabel_2"].BorderSizePixel = 0
    startup["TextLabel_2"].Size = UDim2.new(0, 77, 0, 24)
    startup["TextLabel_2"].Font = Enum.Font.SourceSans
    startup["TextLabel_2"].Text = button2
    startup["TextLabel_2"].TextColor3 = Color3.fromRGB(255, 255, 255)
    startup["TextLabel_2"].TextSize = 14.000
    startup["UIGradient_6"] = Instance.new("UIGradient")
    startup["UIGradient_6"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.24, Color3.fromRGB(253, 253, 253)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(102, 102, 102))}
    startup["UIGradient_6"].Rotation = -125
    startup["UIGradient_6"].Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.63, 0.36), NumberSequenceKeypoint.new(1.00, 0.00)}
    startup["UIGradient_6"].Parent = startup["TextLabel_2"]

    local methodSelected = false

    local c1 = startup["Frame_2"].InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            methodSelected = true
        end
    end)

    local c2 = startup["Frame_3"].InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            selection = true
            methodSelected = true
        end
    end)

    repeat
        wait(0.05)
    until methodSelected
    
    
    c1:Disconnect()
    c2:Disconnect()
    startup["Frame"]:Destroy()

    return selection
end

if gui:Modal("Пащёл нахой", "ОК", "ОК") then
    
end
	end)
