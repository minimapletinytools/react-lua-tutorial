--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Shared.Packages.react)
local ReactRoblox = require(ReplicatedStorage.Shared.Packages:FindFirstChild("react-roblox"))
local Dash = require(ReplicatedStorage.Shared.Packages.dash)
local Tutorial = ReplicatedStorage.Shared.Tutorial
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
		for key, value in pairs(props.tutorialPairs) do
			table.insert(tutorialChildren, React.createElement("TextButton", {
				Size = UDim2.new(1,0,0,50),
				BackgroundColor3 = Color3.fromRGB(255,255,255),
				Text = key,
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
		React.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal
		}),
		
		Picker = React.createElement("ScrollingFrame", {
			Size = UDim2.new(0,200,1,0),
			LayoutOrder = nextLayoutOrder(),
			BackgroundColor3 = Color3.fromRGB(141,182,199),
		}, Dash.join({React.createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical
			}),
			React.createElement("UIStroke", {
				Thickness = 8,
				Color = Color3.fromRGB(90, 81, 138)
			})}, tutorialChildren)
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
	tutorialPairs["MyCuteTestFrame"] = React.createElement(require(Tutorial.one_MyCuteTestFrame), {})

	root:render(React.createElement(ExamplePicker, { tutorialPairs = tutorialPairs}))
end

return {
	runSingelExample = runSingleExample,
	runExamplePicker = runExamplePicker,
}