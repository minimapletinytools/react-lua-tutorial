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
		[React.Event.Activated] = function()
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
		[React.Event.Activated] = function()
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

local function MyClock()
	local text, setText = React.useState("")
	React.useEffect(function()
		print("connecting to clock signal")
		local timer = game:GetService("RunService").Heartbeat:Connect(function()
			setText(os.date("%x %X"))
		end)
		return function()
			print("disconnecting from clock signal")
			timer:Disconnect()
		end
	end, {})
	return React.createElement("TextLabel", {
		Size = UDim2.new(0,200,0,200),
		Text = text,
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

local function BAD_MyInfiniteLoop()
	local myState, setMyState = React.useState({ content = "every new react developer be like" })
	React.useEffect(function()
		print("I'm stuck in an infinite loop!")
		setMyState({ content = "This is fine" })
	end) -- no explicit {} causes the effect to run every time the component code is executed!
	return React.createElement("TextLabel", {
		Size = UDim2.new(0,100,0,100),
		BackgroundColor3 = Color3.fromRGB(0,255,0),
		Text = myState.content
	})
end

local function BAD_MyBoopMachine()
	local boops, setBoops = React.useState({
		nose = false,
		ears = false,
		tail = false,
	})

	local whatToBoop = React.useMemo(function()
		if not boops.nose then
			return "nose"
		elseif not boops.ears then
			return "ears"
		elseif not boops.tail then
			return "tail"
		else
			return "all booped!"
		end
	end, {boops})

	return React.createElement("TextButton", {
        Size = UDim2.new(0,200,0,200),
        BackgroundColor3 = Color3.fromRGB(255,255,0),
		Text = "boop " .. whatToBoop,
		[React.Event.Activated] = function() 
			boops[whatToBoop] = true -- this will not update the `boops` reference, so `whatToBoop` will not be updated
			setBoops(boops)	
		end
    })
end


local function MyBoopMachine()
	local boops, setBoops = React.useState({
		nose = false,
		ears = false,
		tail = false,
	})

	local whatToBoop = React.useMemo(function()
		if not boops.nose then
			return "nose"
		elseif not boops.ears then
			return "ears"
		elseif not boops.tail then
			return "tail"
		else
			return "all booped!"
		end
	end, {boops})

	return React.createElement("TextButton", {
        Size = UDim2.new(0,200,0,200),
        BackgroundColor3 = Color3.fromRGB(255,255,0),
		Text = "boop " .. whatToBoop,
		[React.Event.Activated] = function() 
			local boopCopy = {
				nose = boops.nose,
				ears = boops.ears,
				tail = boops.tail,
			}
			boopCopy[whatToBoop] = true
			setBoops(boopCopy)
		end
    })
end


export type TextBoxWithSetterProps = {
	setTextRef: React.Ref<any>,
}

local TextBoxWithSetter = function(props : TextBoxWithSetterProps)
	local text, setText = React.useState("")
	-- binds `setText` to a function to the ref that can be called from the parent component
	React.useImperativeHandle(props.setTextRef, function()
		return {
			setText = setText
		}
	end, {})
	return React.createElement("TextBox", {
		Size = UDim2.new(0,200,0,200),
		Text = text,
	})
end

-- older version using `forwardRef`, not recommended, left as an example
-- to pass in the ref to `forwardRef`, you set the reserved prop `ref = ref` where `ref = React.createRef()` in the props
local TextBoxWithSetterForwardRefVersion = React.forwardRef(function(props, ref)
	local text, setText = React.useState("")
	-- binds `setText` to a function to the ref that can be called from the parent component
	React.useImperativeHandle(ref, function()
		return {
			setText = setText
		}
	end, {})
	return React.createElement("TextBox", {
		Size = UDim2.new(0,200,0,200),
		Text = text,
	})
end)

-- same as MyClock except uses TextBoxWithSetter
-- this is totally silly and you can see how it might be useful for more complex components
local function MySillyClock()
	local ref = React.createRef()
	React.useEffect(function()
		local timer = game:GetService("RunService").Heartbeat:Connect(function()
			ref.current.setText(os.date("%x %X"))
		end)
		return function()
			timer:Disconnect()
		end
	end, {})
	return React.createElement(TextBoxWithSetter, {
		setTextRef = ref
	})
end

local function ColorJumper()

	local ref = React.createRef()

	React.useEffect(function()
		local timer = game:GetService("RunService").Heartbeat:Connect(function()
			-- ref.current is the ScrollingFrame, it will be nil on the first render because the ref hasn't been set yet
			if ref.current then
				ref.current.CanvasPosition = Vector2.new(0, math.random(0, 800))
			end
			
		end)
		return function()
			timer:Disconnect()
		end
	end, {})

	return React.createElement("ScrollingFrame", {
		Size = UDim2.new(0,200,0,400),
		-- assign the ScrollingFrame instance to ref
		ref = ref
	}, {
		React.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
		}),
		React.createElement("Frame", {
			Size = UDim2.new(1,0,0,200),
			BackgroundColor3 = Color3.fromRGB(255,194,132),
			LayoutOrder = 1,
		}),
		React.createElement("Frame", {
			Size = UDim2.new(1,0,0,200),
			BackgroundColor3 = Color3.fromRGB(255,251,149),
			LayoutOrder = 2,
		}),
		React.createElement("Frame", {
			Size = UDim2.new(1,0,0,200),
			BackgroundColor3 = Color3.fromRGB(255,212,80),
			LayoutOrder = 3,
		}),
		React.createElement("Frame", {
			Size = UDim2.new(1,0,0,200),
			BackgroundColor3 = Color3.fromRGB(255,174,106),
			LayoutOrder = 4,
		}),
		React.createElement("Frame", {
			Size = UDim2.new(1,0,0,200),
			BackgroundColor3 = Color3.fromRGB(255,106,106),
			LayoutOrder = 5,
		}),
	})
end

-- thanks boyned for this one https://blog.boyned.com/articles/things-i-learned-using-react/
local function useToggleState(default: boolean): {
	enabled: boolean,
	enable: () -> (),
	disable: () -> (),
}
	local enabled, setEnabled = React.useState(default)

	local enable = React.useCallback(function()
		setEnabled(true)
	end, {})

	local disable = React.useCallback(function()
		setEnabled(false)
	end, {})

	return {
		enabled = enabled,
		enable = enable,
		disable = disable,
	}
end

local function MyToggleWoggle()
	local toggle = useToggleState(false)
	return React.createElement("TextButton", {
		Size = UDim2.new(0,200,0,200),
		BackgroundColor3 = toggle.enabled and Color3.fromRGB(255,194,132) or Color3.fromRGB(255,106,106),
		Text = toggle.enabled and "Potato" or "Tomato",
		[React.Event.Activated] = function()
			if toggle.enabled then
				toggle.disable()
			else
				toggle.enable()
			end
		end
	})
end

export type MyReallyReallyCuteFrameProps = {
	child: React.ReactElement,
}

local function MyReallyReallyCuteFrame(props: MyReallyReallyCuteFrameProps)
	return React.createElement("Frame", {
		Size = UDim2.new(0,200,0,200),
		AnchorPoint = Vector2.new(0.5,0.5),
		Position = UDim2.new(0.5,0,0.5,0),
		BackgroundColor3 = Color3.fromRGB(255,194,132),
	}, {
		React.createElement("UIPadding", {
			PaddingTop = UDim.new(0,20),
			PaddingBottom = UDim.new(0,20),
			PaddingLeft = UDim.new(0,20),
			PaddingRight = UDim.new(0,20),
		}),
		React.createElement("UICorner", {
			CornerRadius = UDim.new(0,20)
		}),
		React.createElement("UIStroke", {
			Thickness = 8,
			Color = Color3.fromRGB(255,106,106),
		}),
		Content = props.child,
	})
end

local function MyLayoutExample()
	return React.createElement("Frame", {
		Size = UDim2.new(0,200,0,400),
	}, {
		React.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
		}),
		React.createElement("Frame", {
			Size = UDim2.new(1,0,0.5,0),
		}, {
			React.createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
			}),
			React.createElement("Frame", {
				Size = UDim2.new(0.5,0,1,0),
				BackgroundColor3 = Color3.fromRGB(255,194,132),
			}),
			React.createElement("Frame", {
				Size = UDim2.new(0.5,0,1,0),
				BackgroundColor3 = Color3.fromRGB(194,255,132),
			}),
		}),
		React.createElement("Frame", {
			Size = UDim2.new(1,0,0.5,0),
			BackgroundColor3 = Color3.fromRGB(255,251,149),
		}),
	})
end

return {
	MyTestFrame = MyTestFrame,
	MyCuteTestFrame = MyCuteTestFrame,
	MyMostCuteTestFrame = MyMostCuteTestFrame,
	MyCustomTextLabel = MyCustomTextLabel,
	MyCustomFrame = MyCustomFrame,
	MyCustomFrameWithContents = MyCustomFrameWithContents,
	MyBasicButton = MyBasicButton,
	MyColorfulScrollingFrame = MyColorfulScrollingFrame,
	MyColorfulClickableSquare = MyColorfulClickableSquare,
	MyClickableButton = MyClickableButton,
	MyCounter = MyCounter,
	MyClock = MyClock,
	MyBoringKeyboard = MyBoringKeyboard,
	MyQuackyKeyboard = MyQuackyKeyboard,
	UnderstandingUseEffectExample = UnderstandingUseEffectExample,
	MyEggCounter = MyEggCounter,
	BAD_MyInfiniteLoop = BAD_MyInfiniteLoop,
	BAD_MyBoopMachine = BAD_MyBoopMachine,
	MyBoopMachine = MyBoopMachine,
	MySillyClock = MySillyClock,
	ColorJumper = ColorJumper,
	MyToggleWoggle = MyToggleWoggle,
	MyReallyReallyCuteFrame = MyReallyReallyCuteFrame,
	MyLayoutExample = MyLayoutExample,
}