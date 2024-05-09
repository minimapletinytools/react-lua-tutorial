-- this is the entry point for our tutorial

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Shared.Packages.react)
local ReactRoblox = require(ReplicatedStorage.Shared.Packages:FindFirstChild("react-roblox"))
local Dash = require(ReplicatedStorage.Shared.Packages.dash)
local Tutorial = require(ReplicatedStorage.Shared.Tutorial)
local ExamplePicker = require(ReplicatedStorage.Shared.ExamplePicker)
local Players = game:GetService("Players")

local function runExample()
    
    print("initializing ScreenGui")
    -- initialize React for the local player
    local handle = Instance.new("ScreenGui",Players.LocalPlayer.PlayerGui)
    local root = ReactRoblox.createRoot(handle)

    print("running example!")

    -- choose an example below by uncommenting the one you want
    -- you can only run one example at once (the last one you call will be the one that runs)
    --root:render(React.createElement(Tutorial.MyTestFrame, {}))
    --root:render(React.createElement(Tutorial.MyCuteTestFrame, {}))
    root:render(React.createElement(Tutorial.MyMostCuteTestFrame, {}))
    --root:render(React.createElement(Tutorial.MyCustomTextLabel, { Text = "I love Giraffes!" }))
    --root:render(React.createElement(Tutorial.MyCustomFrameWithContents, {}))
    --root:render(React.createElement(Tutorial.MyBasicButton, {}))
    --root:render(React.createElement(Tutorial.MyColorfulScrollingFrame, {}))
    --root:render(React.createElement(Tutorial.MyColorfulClickableSquare, {}))
    --root:render(React.createElement(Tutorial.MyClickableButton, { OnClick = function(time: string) print("Clickaroo! It is " .. time) end }, {}))
    --root:render(React.createElement(Tutorial.MyCounter, {}))
    --root:render(React.createElement(Tutorial.MyClock, {}))
    --root:render(React.createElement(Tutorial.MyBoringKeyboard, {}))
    --root:render(React.createElement(Tutorial.MyQuackyKeyboard, {}))
    --root:render(React.createElement(Tutorial.UnderstandingUseEffectExample, {}))
    --root:render(React.createElement(Tutorial.MyEggCounter, { numberEggsToCount = 9511245 }))
    --root:render(React.createElement(Tutorial.BAD_MyInfiniteLoop, {}))
    --root:render(React.createElement(Tutorial.BAD_MyBoopMachine, {}))
    --root:render(React.createElement(Tutorial.MyBoopMachine, {}))
    --root:render(React.createElement(Tutorial.MySillyClock, {}))
    --TW flashing colors 
    --root:render(React.createElement(Tutorial.ColorJumper, {}))
    --root:render(React.createElement(Tutorial.MyToggleWoggle, {}))
    --root:render(React.createElement(Tutorial.MyReallyReallyCuteFrame, { child = React.createElement(Tutorial.MyCustomTextLabel, { Text = "I love Giraffes!" })}))
    --root:render(React.createElement(Tutorial.MyLayoutExample, {}))
    
end



-- run the example!
runExample()

-- OR you can use the example picker to easily view all examples, however the code setup for the picker is a little more complicated
--ExamplePicker.runExamplePicker()


