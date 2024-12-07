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
- binding [functions](#binding-events) to events 🔩
- binding [conditions](#conditions) for those functions🔓
- changing the [appearance](#parts-of-an-item-🧩) 💎
- changing [behavior](#behavior) 🕹️
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

## Binding Events
You can bind functions to specific events such as an item being selected, deselected, toggled, used, end of used, viewed, and end of viewed.  
  
Do so with the following method:
```lua
item:bindEvent("used", function()
    -- use a skill here
end)

local function selected()
    --equip sword
end

item:bindEvent("selected", selected)
```
### Conditions
You can similarly bind conditions for thise events. If the function returns false, then the condition returns false, otherwise it passes. If the condition doesn't pass then the function bound to event (like above) does not run.  
  
Essentially, condition functions just house you own condition checks that are called upon that event.  
  
The first argument must be the name of the condition. This is what you use when you want to unbind a condition.
```lua
item:bindCondition("ragdolled", "used", function()
    if playerIsRagdolled then 
        return false 
    else 
        return true 
    end
)
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
Hotbar (Screen GUI)
└───Container
│   │   UIListLayout
│   └───Holder
│       │   UIListLayout
│       │   Padding
│       │   Widget
│       │   │   UIStroke
│       │   │   Fill
│       │   │   TextButton
│       │   │   BottomText
│       │   │   Label
│       │       
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
  
Create animations with `Hotbar.createAnimation()` and play them with either `Hotbar.playAnimation()` to play once for the whole hotbar or `item:playAnimationSelf()` to pass `self` and play on each item.
```lua
Hotbar.createAnimation("MyAnimation", function(foo, bar)
    -- edit the properties of the widget or hotbar
end)

Hotbar.playAnimation("MyAnimayition", false, 5)
```
There are premade animations such as TweenIn that tweens the entire Hotbar from off screen.

## Behavior
Set the behavior of an item with the following methods:

### oneClick 
OneClick essentially calls `self.use()` and `self.deselect()` upon selection giving the illusion of a one click button.
  
### pressAgain
PresAgain allows you to bind functions to cycle through when the player uses the item again. This is intended for moves/skills that change when the player clicks again while using, like perfect casting a spell.
```lua
item:bindPressAgain(1, function()
    skillDamage = skillDamage * 2
end)
```
