---
sidebar_position: 1
---

# About
HotbarPlus is an open-source module made to make hotbars easier.

You can create hotbars in **less than 10 lines!

HotbarPlus fully supports PC and mobile, allowing items to be selected with mouse click, a key, tapping, or an external activator.

## Construction
```lua
local Hotbar = require(game:GetService("ReplicatedStorage").Hotbar)
local item = Hotbar.new()
```

## Methods
```lua
item:setText("Cool text")
item:setLabel("1")
```

### Method Chaining
You can chain methods like so
```lua
local item = Hotbar.new()
    :bindEvent("selected", function(icon)
        print("I was selected")
    end)
    :bindToggleKey("Two")
```
or like so
```lua
item:bindCondition("wasUsed", "used", function(icon)
    return false
end)
    :setName("Sword")
```

## States

## Settings