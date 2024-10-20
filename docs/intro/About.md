---
sidebar_position: 1
---

# About
HotbarPlus is an open-source module made to make hotbars easier.

You can create sufficient hotbars in **less than 10 lines!** 🥳

HotbarPlus fully supports PC and mobile, allowing items to be selected with mouse click, a key, tapping, or an external activator.

## Construction 🧱
Use a standard `.new()` constructor
```lua
local Hotbar = require(game:GetService("ReplicatedStorage").Hotbar)
local item = Hotbar.new()
```

## Methods
```lua
item:setText("Cool text")
item:setLabel("1")
```
Do stuff like
- binding functions to events
- binding conditions for those functions 
- changing the appearance
- changing behavior
- and more!

> **Note:** Pertaining to appearances, themes will be added soon. Currently you can only change the widget that they are cloned from—i.e. all items mantain the same appearence and cannot be changed after creation.

### Method Chaining 🔗
All methods return `self` which means you can chain methods like so
```lua
local item = Hotbar.new()
    :bindEvent("selected", function(icon)
        print("I was selected")
    end)
    :bindToggleKey("Two")
```
or like so 😱
```lua
item:bindCondition("wasUsed", "used", function(icon)
    return false
end)
    :setName("Sword")
```

## States 

## Settings