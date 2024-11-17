---
sidebar_position: 2
---

# About
HotbarPlus is an open-source module made to make hotbars easier.

You can create sufficient hotbars in **less than 10 lines!** 🥳

HotbarPlus fully supports PC and mobile, allowing items to be selected with mouse click, a key, tapping, or an external activator.

## Construction 🧱
Use a standard `.new()` constructor to create a new item. Items are the what the object itself is called. You can think of items as "slots" in the hotbar.
```lua
local Hotbar = require(game:GetService("ReplicatedStorage").Hotbar)
local item = Hotbar.new()
```

> **Note** Items appear in order of creation, but this can be changed with `Item:setLayoutOrder()`. The layout order uses a roblox [UIListLayout](https://create.roblox.com/docs/reference/engine/classes/UIListLayout), so items with the same LayoutOrder property may appear in a different order than expected.

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

## Signals
Signals are like [RBXScriptSignals](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptSignal) and made with GoodSignal.  
  
They act as triggers for when a specific action or occurrance has happened (state is changed, item is selected, item is used, etc).  
  
They can be fired with `signal:Fire()` and functions can be connected 
with `signal:Connect(callback)`
```lua
local item = Hotbar.new()

item.stateChanged:Connect(function()
    print("My state was changed!")
end)
```

> **Note** Doing `signal:Fire()` may cause issues because various events and logic is tied to signals internally. I would suggest *never* using `signal:Fire()`.

## Parts of an Item 🧩
Each item has its own container that wraps the padding and the widget. The widget is the actual GUI for the item.

The GUI tree is as follows:  
```
Hotbar
└───Item-container
│   │   file011.txt
│   │   file012.txt
│   │
│   └───subfolder1
│       │   file111.txt
│       │   file112.txt
│       │   ...
│   
```

## States 
There are two types of states: item specific, `self.activeState`, and hotbar, `Hotbar.getState()`.
### Item specific states
The three states items can be in are the following: selected, deselected, and viewing.  
- Selected: item is selected and can be used
- Deselected: default state; when not selected or viewing
- Viewing: mouse is hovering over the item

Get with `self.activeState`  
Set with `self:setState()`

Signal is `self.stateChanged`

### Hotbar states
Hotbar states have two values: allDeselected, anySelected.  
It acts as a collection of all states. 
- allDeselected: all items are deselected
- anySelected: any item is selected

Get with `Hotbar.getState()`

Signal is `Hotbar.anyItemSelected`

## Animations 🎥
You can make and play animations on the the hotbar or individual items. Animations are simply functions that are stored within the hotbar module, allowing for easy access across scripts. Animations don't necessarily need to be animations, but that's the intended use. You can store any functions pertaining to the hotbar that you want to be acessible across scripts.  
  
You can create animations with `Hotbar.createAnimation()` and play them with `Hotbar.playAnimation()` to play once for the whole hotbar or `item:playAnimationSelf()` to pass `self` and play on each item.
```lua
Hotbar.createAnimation("MyAnimation", function(foo, bar)
    -- edit the properties of the widget or hotbar
end)

Hotbar.playAnimation("MyAnimayition", false, 5)
```
There are premade animations such as TweenIn that tweens the entire Hotbar from off screen.

## Behavior
You can set the behavior of an item with certain methods.

### oneClick 
OneClick essentially calls `self.deselect()` upon selection giving 
the illusion of a one click button.
  
The `self.used` signal is triggered upon selection as normal, but 
