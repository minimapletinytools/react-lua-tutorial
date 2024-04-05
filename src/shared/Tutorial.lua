local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Shared.Packages.react)

local function MyTestFrame() 
	return React.createElement("Frame", {
		Size = UDim2.new(0,100,0,100),
	})
end

local function MyCuteTestFrame() 
	return React.createElement("Frame", {
		Position = UDim2.new(0.5,0,0.5,0),
		AnchorPoint = Vector2.new(0.5,0.5),
		Size = UDim2.new(0,100,0,100),
		BackgroundColor3 = Color3.fromRGB(193,179,142)
	})
end

local function MyMostCuteTestFrame() 
	return React.createElement("Frame", {
		Position = UDim2.new(0.5,0,0.5,0),
		AnchorPoint = Vector2.new(0.5,0.5),
		Size = UDim2.new(0,100,0,100),
		BackgroundColor3 = Color3.fromRGB(193,179,142)
	}, {
		React.createElement("UICorner", {
			CornerRadius = UDim.new(0,30)
		}),
	})
end

export type MyCustomTextLabelProps = {
	-- NOTE, these properties can be named whatever you want
	Text: string,
	TextColor3: Color3?,
}

local function MyCustomTextLabel(props: MyCustomTextLabelProps)
	return React.createElement("TextLabel", {
		Size = UDim2.new(0,100,0,100),
		BackgroundColor3 = Color3.fromRGB(193,179,142),
		TextColor3 = props.TextColor3 or Color3.fromRGB(127,127,255),
		Text = props.Text,
	})
end

export type MyCustomFrameProps = {
	child: React.React_Element, -- is this type correct?
}

local function MyCustomFrame(props: MyCustomFrameProps)
	return React.createElement("Frame", {
		Size = UDim2.new(0,100,0,100),
		BackgroundColor3 = Color3.fromRGB(193,179,142),
	}, { Child = props.child })
end

local function MyCustomFrameWithContents()
	return React.createElement(MyCustomFrame, {
		child = React.createElement("TextLabel", {
			Text = "Hello from inside the frame!",
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.XY,
		})
	})
end

local function MyBasicButton()
	return React.createElement("TextButton", {
		Size = UDim2.new(0,100,0,100),
		BackgroundColor3 = Color3.fromRGB(0,255,0),
		Text = "Click me!",
		[React.Event.MouseButton1Click] = function()
			print("You clicked me!")
		end
	})
end


local function MyColorfulScrollingFrame()
	return React.createElement("ScrollingFrame", {
		Size = UDim2.new(0,200,0,200),
		BackgroundColor3 = Color3.fromRGB(255,255,255),
		[React.Change.CanvasPosition] = function(instance: ScrollingFrame)
			print("you scrolled me to " .. tostring(instance.CanvasPosition))
		end
	}, {
		React.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
		}),
		React.createElement("Frame", {
			Size = UDim2.new(0,200,0,150),
			BackgroundColor3 = Color3.fromRGB(255,0,0),
		}),
		React.createElement("Frame", {
			Size = UDim2.new(0,200,0,150),
			BackgroundColor3 = Color3.fromRGB(0,255,0),
		}),
		React.createElement("Frame", {
			Size = UDim2.new(0,200,0,150),
			BackgroundColor3 = Color3.fromRGB(0,0,255),
		}),
	})
end

local function MyColorfulClickableSquare()
    local color, setColor = React.useState(Color3.new(255,255,255))
    return React.createElement("TextButton", {
        Size = UDim2.new(0,200,0,200),
        BackgroundColor3 = color,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		Text = "Click me to change color!",
		[React.Event.Activated] = function() 
			local newColor = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
			print("changing color to " .. tostring(newColor) .. "!")
			setColor(newColor)
		end
    })
end

export type MyClickableButtonProps = {
	Text: string,
	OnClick: (time: string) -> (),
}

local function MyClickableButton(props: MyClickableButtonProps)
	return React.createElement("TextButton", {
		Size = UDim2.new(0,100,0,100),
		BackgroundColor3 = Color3.fromRGB(0,0,255),
		Text = props.Text,
		[React.Event.MouseButton1Click] = function()
			props.OnClick(tostring(os.date("%x %X")))
		end
	})
end

local function MyCounter()
	local count, setCount = React.useState(0)
	return React.createElement("Frame", {
		Size = UDim2.new(0,100,0,200),
	}, {
		Layout = React.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
		}),
		Label = React.createElement("TextLabel", {
			Size = UDim2.new(0,100,0,100),
			BackgroundColor3 = Color3.fromRGB(0,255,0),
			LayoutOrder = 1,
			Text = "I've been clicked " .. tostring(count) .. " times"
		}),
		Button = React.createElement(MyClickableButton, {
			Size = UDim2.new(0,100,0,100),
			Text = "Click me to increment!",
			LayoutOrder = 2,
			OnClick = function()
				setCount(count + 1)
			end
		})
	})
end

local function MyBoringKeyboard()
	local text, setText = React.useState("press a key!")
	React.useEffect(function()
		print("connecting to keyboard signal")
		local UserInputService = game:GetService("UserInputService")
		local signal: RBXScriptConnection = UserInputService.InputEnded:Connect(function(input: InputObject, gameProcessedEvent: boolean)
			if input.UserInputType == Enum.UserInputType.Keyboard then
				setText("last key pressed: " .. UserInputService:GetStringForKeyCode(input.KeyCode))
			end
		end)
		return function()
			print("disconnecting from keyboard signal")
			signal:Disconnect()
		end
	end, {}) -- empty dependency array means this effect only runs once

	return React.createElement("TextLabel", {
		Size = UDim2.new(0,400,0,200),
		BackgroundColor3 = Color3.fromRGB(0,255,0),
		TextWrapped = true,
		Text = text
	})
end

local function MyQuackyKeyboard()
	local translation, setTranslation = React.useState("")
	React.useEffect(function()
		print("quack quack (connecting to keyboard signal)")
		local UserInputService = game:GetService("UserInputService")
		local signal: RBXScriptConnection = UserInputService.InputEnded:Connect(function(input: InputObject, gameProcessedEvent: boolean)
			if input.UserInputType == Enum.UserInputType.Keyboard then
				setTranslation(translation .. UserInputService:GetStringForKeyCode(input.KeyCode))
			end
		end)
		return function()
			print("quack quack (disconnecting from keyboard signal)")
			signal:Disconnect()
		end
	end, {translation}) -- in order to append to `translation`, we need to include `translation` in the dependency array 

	local text = React.useMemo(function()
		-- use gsub to count the number of white space sequences as a reasonable proxy for the number of words
		local _,timesQuacked = translation:gsub("%S+","")
		local quackString = string.rep("quack ", timesQuacked)
		return quackString .. "\n(" .. translation .. ")"
	end, {translation})

	return React.createElement("TextLabel", {
		Size = UDim2.new(0,400,0,200),
		BackgroundColor3 = Color3.fromRGB(255,216,1),
		TextWrapped = true,
		Text = text
	})

end

local function UnderstandingUseEffectExample()
	local flavor, setFlavor = React.useState("vanilla")
	print("I might get run a lot!")
	React.useEffect(function()
		print("I only run once!")
		setFlavor("guava")
	end, {})
	return React.createElement("TextLabel", {
		Size = UDim2.new(0,100,0,100),
		BackgroundColor3 = Color3.fromRGB(255,216,1),
		Text = flavor,
	})
end

export type MyEggCounterProps = {
	numberEggsToCount: number,
}

local function MyEggCounter(props: MyEggCounterProps)
	local numberEggs = React.useMemo(function()
		print("Counting eggs! I'm only going to do this once!")
		local numberEggs = 0
		for i = 1, props.numberEggsToCount do
			numberEggs = numberEggs + 1
		end
		return numberEggs
	end, {props.numberEggsToCount})

	return React.createElement("TextLabel", {
		Size = UDim2.new(0,100,0,100),
		BackgroundColor3 = Color3.fromRGB(0,255,0),
		Text = "I counted " .. numberEggs .. " eggs!"
	})
end


return {
	MyTestFrame = MyTestFrame,
	MyCuteTestFrame = MyCuteTestFrame,
	MyMostCuteTestFrame = MyMostCuteTestFrame,
	MyCustomTextLabel = MyCustomTextLabel,
	--MyCustomFrame = MyCustomFrame,
	MyCustomFrameWithContents = MyCustomFrameWithContents,
	MyBasicButton = MyBasicButton,
	MyColorfulScrollingFrame = MyColorfulScrollingFrame,
	MyColorfulClickableSquare = MyColorfulClickableSquare,
	MyClickableButton = MyClickableButton,
	MyCounter = MyCounter,
	MyBoringKeyboard = MyBoringKeyboard,
	MyQuackyKeyboard = MyQuackyKeyboard,
	UnderstandingUseEffectExample = UnderstandingUseEffectExample,
	MyEggCounter = MyEggCounter,
}