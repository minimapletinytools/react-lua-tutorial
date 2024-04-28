--!strict

-- TODO, LOOKS TOO UGLY :( Maybe you can help make it look nicer :)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Shared.Packages.react)
local ReactRoblox = require(ReplicatedStorage.Shared.Packages:FindFirstChild("react-roblox"))
local Dash = require(ReplicatedStorage.Shared.Packages.dash)
local Tutorial = require(ReplicatedStorage.Shared.Tutorial)
local Players = game:GetService("Players")


local layoutOrder_ = 0
local function nextLayoutOrder() : number
	layoutOrder_ = layoutOrder_ + 1
	return layoutOrder_
end

type ExamplePickerProps = {
	tutorialPairs : {[string] : React.React_Element} 
}

local ExamplePicker = function(props : ExamplePickerProps)

	local currentExample, setCurrentExample = React.useState(React.createElement("Frame", {
		Size = UDim2.new(1,0,1,0),
		BackgroundColor3 = Color3.fromRGB(255,255,255)
	}))

	local tutorialChildren = React.useMemo(function()
		local tutorialChildren = {}	
		local i = 10000
		for key, value in pairs(props.tutorialPairs) do
			i = i-1
			table.insert(tutorialChildren, React.createElement("TextButton", {
				Size = UDim2.new(1,0,0,50),
				BackgroundColor3 = Color3.fromRGB(255,255,255),
				Text = key,
				LayoutOrder = i,
				[React.Event.MouseButton1Click] = function()
					print("Clicked on " .. key)
					setCurrentExample(value)
				end
			}))
		end
		return tutorialChildren
	end, {props.tutorialPairs})
	

	return React.createElement("Frame", {
		Size = UDim2.new(1,0,1,0),
		BackgroundTransparency = 1,
	}, {
		Layout = React.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		
		Picker = React.createElement("ScrollingFrame", {
			Size = UDim2.new(0,200,1,0),
			LayoutOrder = nextLayoutOrder(),
			BackgroundColor3 = Color3.fromRGB(141,182,199),
		}, Dash.join(
			{
				Layout = React.createElement("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder
				}),
				Stroke = React.createElement("UIStroke", {
					Thickness = 8,
					Color = Color3.fromRGB(90, 81, 138)
				})
			}, 
			tutorialChildren)
		),

		Example = React.createElement("Frame", {
			Size = UDim2.new(1,-200,1,0),
			LayoutOrder = nextLayoutOrder(),
			BackgroundTransparency = 1,
		}, currentExample)


	})

end

local function runSingleExample(example : React.React_Element, props : any?)
	-- initialize React for the local player
	local handle = Instance.new("ScreenGui",Players.LocalPlayer.PlayerGui)
	local root = ReactRoblox.createRoot(handle)

	root:render(React.createElement(example, props or {}))
end

local function runExamplePicker() 
	-- initialize React for the local player
	local handle = Instance.new("ScreenGui",Players.LocalPlayer.PlayerGui)
	local root = ReactRoblox.createRoot(handle)

	local tutorialPairs = {}

	tutorialPairs["MyTestFrame"] = React.createElement(Tutorial.MyTestFrame, {})
	tutorialPairs["MyCuteTestFrame"] = React.createElement(Tutorial.MyCuteTestFrame, {})
	tutorialPairs["MyMostCuteTestFrame"] = React.createElement(Tutorial.MyMostCuteTestFrame, {})
	tutorialPairs["MyCustomTextLabel"] = React.createElement(Tutorial.MyCustomTextLabel, { Text = "I love Giraffes!" })
	tutorialPairs["MyCustomFrameWithContents"] = React.createElement(Tutorial.MyCustomFrameWithContents, {})
	tutorialPairs["MyBasicButton"] = React.createElement(Tutorial.MyBasicButton, {})
	tutorialPairs["MyColorfulScrollingFrame"] = React.createElement(Tutorial.MyColorfulScrollingFrame, {})
	tutorialPairs["MyColorfulClickableSquare"] = React.createElement(Tutorial.MyColorfulClickableSquare, {})
	tutorialPairs["MyClickableButton"] = React.createElement(Tutorial.MyClickableButton, { OnClick = function(time: string) print("Clickaroo! It is " .. time) end }, {})
	tutorialPairs["MyCounter"] = React.createElement(Tutorial.MyCounter, {})
	tutorialPairs["MyClock"] = React.createElement(Tutorial.MyClock, {})
	tutorialPairs["MyBoringKeyboard"] = React.createElement(Tutorial.MyBoringKeyboard, {})
	tutorialPairs["MyQuackyKeyboard"] = React.createElement(Tutorial.MyQuackyKeyboard, {})
	tutorialPairs["UnderstandingUseEffectExample"] = React.createElement(Tutorial.UnderstandingUseEffectExample, {})
	tutorialPairs["MyEggCounter"] = React.createElement(Tutorial.MyEggCounter, { numberEggsToCount = 9511245 })
	tutorialPairs["BAD_MyInfiniteLoop"] = React.createElement(Tutorial.BAD_MyInfiniteLoop, {})
	tutorialPairs["BAD_MyBoopMachine"] = React.createElement(Tutorial.BAD_MyBoopMachine, {})
	tutorialPairs["MyBoopMachine"] = React.createElement(Tutorial.MyBoopMachine, {})
	tutorialPairs["MySillyClock"] = React.createElement(Tutorial.MySillyClock, {})
	tutorialPairs["(TW flashing colors) ColorJumper"] = React.createElement(Tutorial.ColorJumper, {})
	tutorialPairs["MyToggleWoggle"] = React.createElement(Tutorial.MyToggleWoggle, {})
	tutorialPairs["MyReallyReallyCuteFrame"] = React.createElement(Tutorial.MyReallyReallyCuteFrame, { child = React.createElement(Tutorial.MyCustomTextLabel, { Text = "I love Giraffes!" })})
	tutorialPairs["MyLayoutExample"] = React.createElement(Tutorial.MyLayoutExample, {})

	root:render(React.createElement(ExamplePicker, { tutorialPairs = tutorialPairs}))
end

return {
	runSingelExample = runSingleExample,
	runExamplePicker = runExamplePicker,
}