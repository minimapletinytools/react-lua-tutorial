# react-lua-tutorial-and-storybook

This repo contains tutorial examples for using `react-lua` to write UI for your Roblox experiences. It should be an invaluable tool for anyone getting started with `react-lua` + Roblox.

It is the companion code for [this article](TODO WIP). Please read the article first!!

# Running Examples (simple)

This repo is setup using Rojo + Wally, however, you can still just open the place.rbxl in Roblox Studio to view the examples. Modify `StarterPlayer > StarterPlayerScripts > Client` (mapped from `src/client/init.client.lua`) to choose which example you want to run. 

# Setting up Rojo + Wally

Changes made within Roblox Studio ARE NOT reflected into this folder. If you'd like to make changes to the files in this directory and see them reflected in Roblox Studio, you will need to setup [Rojo](https://rojo.space/). 

<details>
  <summary>Click for Rojo Usage Instructions</summary>
  Follow the installation instructions [here](https://rojo.space/docs/v7/getting-started/installation/). You must use [VSCode](https://code.visualstudio.com/). Once you install the Rojo VSCode extension, be sure to install the Rojo studio plugin as well. You can do this via the Rojo menu in VScode (⌘/ctrl+shift+p > Rojo: Open Menu > Instal Roblox Studio Plugin). Rojo runs a local http server for the Roblox Studio Rojo plugin to fetch your script changes from. To start this server, open the Rojo menu again (⌘/ctrl+shift+p > Rojo: Open Menu) and choose the last option to start the server for default.project.json (the project map file in this directory). Then, in the Roblox Studio Rojo plugin, connect to the server and all your changes here should automatically synchronize!
</details>

Hit "Play" to enter play test mode and run the examples.

## Installing react-lua with Wally

We use Wally to manage the `react-lua` library. It's already installed in this project, however, if you'd like to use it in your own project the follow [wally installation instrucitons](https://wally.run/install). Then, add the following to your wally.toml file:

```
[dependencies]
react = "jsdotlua/react@17.1.0"
react-roblox = "jsdotlua/react-roblox@17.1.0"
```

Finally run `wally install`.

Note [https://github.com/jsdotlua](https://github.com/jsdotlua)] hosts publics mirrors of repos from [https://github.com/Roblox](https://github.com/Roblox), and in particular [https://github.com/Roblox/react-lua](https://github.com/Roblox/react-lua). Currently the Roblox hosted/maintained upstream repositories are not set up to allow collaboration. Hope for this to change in the future!


# Contributing

Feel free to open issues and submit PRs. I hope to build this repo out into a fully storybook of examples, not just tutorials!

## Wishlist

- A simple end to end example of a cute game with a React UI
- Make the current Tutorial examples a little more cute (but not too complicated!)
- A fully working example application. Make it cute!
- A storybook (maybe a separate repo)
  - Examples of each GUIObject and how each property affects their look
  - Examples of showing how sizing and position works
    - UDim2 Size/Position examples
    - Anchor examples
    - AutomaticSizing examples
  - A custom plugin showcasing examples as a storybook 
- Stylesheet examples (when they get released)