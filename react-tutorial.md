# React in Roblox


## What is React

[React-lua](https://github.com/Roblox/react-lua) is a Roblox compatible lua port of the well known [react](https://react.dev/) UI library used in web and mobile ubiquitously.

React-lua is maintained by Roblox and currently several studio plugins and the Roblox universal app (the desktop console and mobile app where you browse for your favorite Roblox games are all written in react-lua.

In addition, we also maintain many libraries that extend or support react-lua. These libraries are often ports of existing well known react.js libraries.

Who is this guide for

This guide is for experienced off-platform react devs looking to build UIs on Roblox and also for existing Roblox devs looking to up-level their UI/UX code.


Note, all examples here are written in [Luau](https://create.roblox.com/docs/luau) and are fully compatible with untyped Lua code.
Also, since react-lua is a port of react, all react resources apply. This guide will focus on getting started the key differences. For further reading, we suggest diving into the [official react docs](https://react.dev/reference/react))

TODO link react-lua docs (maybe just link the jsdotlua mirror ones...)


## Getting Started

### Installing the react-lua module in your Roblox project

If you are using Rojo and the [Wally](https://wally.run/) package management library <TODO link to other experts article>, install the [react-lua](https://wally.run/package/jsdotlua/react?version=17.1.0) and the [react-roblox](https://wally.run/package/jsdotlua/react-roblox) package. This is the recommended way to install React.

You can download an .rbxm file that can be imported into an existing project [here](https://github.com/jsdotlua/react-lua/releases/tag/v17.1.0) 

Please note the where the react-lua files have been installed so that you can reference them in your project

TODO screenshot

### Setting up React

Typical UI development in Roblox usually entails building a tree of [GUIObjects](https://create.roblox.com/docs/reference/engine/classes/GuiObject) inside the [StarterGui](https://create.roblox.com/docs/reference/engine/classes/StarterGui) service.  React-lua is an entirely code driven UI workflow so instead, we define a single entry point inside [StarterPlayer > StarterPlayerScripts](asses/StarterPlayerScripts)

TODO screenshot


How you installed the react-lua packages earlier will determine where the ModuleScripts are installed. If you installed using the rbxm file, you can require the ModuleScripts as so:

```
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.React.React)
local ReactRoblox = require(ReplicatedStorage.React.ReactRoblox)
```

If you used Wally, the path will depend on where you put your wally.toml file.

First let's define a very basic UI element to test that everything works

```
local function MyCuteTestFrame()
TODO
end

```

To actually render the UI element, we need to "mount" the react "component tree"

```
local handle = Instance.new("ScreenGui",Players.LocalPlayer.PlayerGui)
local root = ReactRoblox.createRoot(handle)
root:render(React.createElement(MyCuteTestFrame, {}, {}))
```

Hit "Play" to see that everything works as expected

TODO screenshot


> **NOTE** What's happening?
> just like react.js, react-lua internally stores a "tree" representing your UI
> `React.createElement("Frame", {...}, {...})` defines a node in the tree
> The first argument in this case is the GUIObject that the node represents. It could also be user-defined react component or function.
> The second argument is a list of *properties* that modify the appearance or behavior of the GUIObject
> The final argument is a list of children nodes 
>
> Once the tree is defined, `MyCuteTestFrame` in the example above, we need to "mount" so that it will ultimately render a Roblox UI for us
> When calling `root:render` with our component, react-lua will do the following things:
>
> construct or update it's internal representation of the UI tree
> derive the state of each component in the tree
> construct or update the matching Roblox GUIObject representation of the UI (rendering)
>
> The flow is identical to the the [component-lifecycle](https://legacy.reactjs.org/docs/react-component.html) of react


### Styling

React properties are matched to GUIObject styling properties by. For example, to create a crownflower blue 108x108 square in the center of the screen, we want to set the [Size](https://create.roblox.com/docs/reference/engine/classes/GuiObject#Size), [Position](https://create.roblox.com/docs/reference/engine/classes/GuiObject#Position), [AnchorPoint](https://create.roblox.com/docs/reference/engine/classes/GuiObject#AnchorPoint) and [BackgroundColor3](https://create.roblox.com/docs/reference/engine/classes/GuiObject#BackgroundColor3) property.

```
React.createElement("Frame", {
    Size = UDim2.new(0,108,0,108),
    Position = UDim2.new(0.5,0,0.5,0),
    AnchorPoint = Vector2.new(0.5,0.5),
    BackgroundColor3 = Color3.new(100,149,237)
})
```

The React property will always match the instance property name you are trying to set. Only styling properties can be set this way, other properties can not.

### Interacting

React can listen to events from the Roblox objects it represents.  For example, to do something when a button is activated, we want to listen to the [Activated](https://create.roblox.com/docs/reference/engine/classes/GuiButton#Activated) event.

```
React.createElement("TextButton", {
    ...
    [React.Event.Activated] = function()
        print("you pressed me!")
    end
})
```

[Property change events](https://create.roblox.com/docs/reference/engine/classes/Instance#GetPropertyChangedSignal) are handled separately with the `React.Change` key, for example to listen to changes in the [CanvasPosition](https://create.roblox.com/docs/reference/engine/classes/ScrollingFrame#CanvasPosition) property of a [ScrollingFrame](https://create.roblox.com/docs/reference/engine/classes/ScrollingFrame):

```
React.createElement("ScrollingFrame", {
    ...
    [React.Change.CanvasPosition] = function(position)
        print("you scrolled me to " .. tostring(position))
    end
})
```

A common pattern is to pass in a _callback_ as a property to the react component so that information can be passed up the hierarchy. Note the example below requires the `useState` hook which is explained later in this guide.

TODO
```
```


### Inspecting and Debugging your React GUI

React ultimately renders a GUIObject tree in the Roblox [DataModel](https://create.roblox.com/docs/reference/engine/classes/DataModel). You can inspect this tree by finding it in the explorer widget. In the example above, we can see react-lua has created a "Frame" instance for us.

TODO screenshot

You can also update this tree in the properties widget, however changes here are only for testing and will likely be overridden the next time react-lua rerenders its component tree.



## 🌶️ Spicing things Up 🌶️
### Component Trees

In the above examples, we only had a single component in our tree!!! To build complex UIs, you will want to add more components.

### State

To build dynamic UIs, you will need components with states that change from user interaction. The recommended way to do this is using the [useState](https://react.dev/reference/react/useState) hook.

```
local function colorfulSquare()
    local color, setColor = React.useState(Color3.new(0,0,0))

    return React.createElement("Frame", {
        Size = UDim2.new(0,200,0,200)
        BackgroundColor3 = color
    }, {
        React.createElement("TextButton", {
            Size = UDim2.new(0,50,0,50),
            [React.Event.Activated] = function() 
                setColor(Color3.new(math.random(255), math.random(255), math.random(255)))
            end
        })
    })

end
```


### Other Common Hooks

react-lua also support all other react hooks including [useEffect](https://react.dev/reference/react/useEffect) [useMemo](https://react.dev/reference/react/useMemo) and [useCallback](https://react.dev/reference/react/useCallback) and so on. These hooks should work very similar to react. Please see the official react docs linked above for more information.

One exception is the `useRef` hook. TODO this one is a little different so needs to be highlighted here

### Advanced Styling

Styling primitives in Roblox are different than the ones used by react. In particular, Roblox makes use of primitives such as

UIListLayout
UICorner
UIPadding
(TODO link to creator docs)


which are added as children to the GUIObject they are intended to style. Thus to style a react-lua component, we need to create the appopriate style modifier as a child component.

```
TODO UI padding example
TODO UI corner example
```

TODO screenshot

For UIListLayout, we additionally need to include the LayoutOrder property in the other children

```
TODO example
```

TODO screenshot


### OOP Components (MAYBE DELETE THIS SECTION OR LINK TO SOME EXISTING ARTICLE)

Just like react, react-lua also supports class components if you choose to use them. It is this author's opinion that functional components are much much better!!

To define a new react class component, we can extend ...

TODO

then you can define a render function

TODO

without state hooks, you need to manually manage your state object 

TODO simple example of setstate

Since lua uses tables, the join operation from the cryo library is very useful for doing incremental updates

TODO example with cryo 

just like react, you can also define .... functions

TODO

Again, we suggest referreing to the [official react documentation](https://react.dev/reference/react/Component) for more details. 



## Contributing to react-lua

We’re currently not accepting direct contributions to react-lua and its supporting libraries yet. This is primarily due to 2 reasons:

React-lua attempts to closely follow the upstream react.js code and therefore we have strict contribution guidelines that we still need to define
Our internal CI/CD tools for lua development are not publicly available at this time and therefore changes can not be automatically verified.

This may change in the future as we hope to support a diverse and collaborative open source ecosystem around Roblox!!

To learn more, see our experts article on Lua & Roblox Open Source Ecosystem

## Future Topics

As we make more of libraries and resources available, you'll have access to an increasingly powerful toolkit. We'll be covering the following topics in the near future:

- react component libraries
- testing with jest
