# API

## Functions

### getItems
```lua
local items = Hotbar.getItems()
```
Returns all items currently in the hotbar.

---

### getItem
```lua
local item = Hotbar.getItem(UID)
```
Retrieves a specific item from the hotbar using its UID.

---

### getState
```lua
local state = Hotbar.getState()
```
Gets the current state of the hotbar ("allDeselected" or "anySelected").

---

### setHotbarEnabled
```lua
Hotbar.setHotbarEnabled(bool)
```
Enables or disables the hotbar's functionality. If no argument is provided, it defaults to true.

---

### setDisplayOrder
```lua
Hotbar.setDisplayOrder(int)
```
Sets the display order of the hotbar, useful for managing GUI layering.

---

### bindConditionAll
```lua
Hotbar.bindConditionAll(name, action, callback)
```
Binds a condition to all items in the hotbar. The callback will execute when the specified action occurs.

---

### unbindConditionAll
```lua
Hotbar.unbindConditionAll(name)
```
Unbinds a condition from all items in the hotbar. If no name is provided, all conditions are unbound.

---

### setVariableAll
```lua
Hotbar.setVariableAll(var, val)
```
Sets a variable to a specified value for all items in the hotbar.

---

### runMethodAll
```lua
Hotbar.runMethodAll(method, ...)
```
Runs a specified method on all items in the hotbar, passing any additional arguments.

---

### newAnimation
```lua
Hotbar.newAnimation(name, callback)
```
Defines a new animation for the hotbar. An animation is simply a function that is stored in a client's HotbarPlus module script. If it's played on a single item with playAnimationSelf, it inherits the scope of that item, i.e. `self`.

---

### playAnimation
```lua
Hotbar.playAnimation(name, ...)
```
Plays a previously defined animation with optional arguments.

---

## Constructor 

### new
```lua
local myItem = Hotbar.new()
```
Constructs empty item in the hotbar.

---

## Methods

### bindEvent
```lua
item:bindEvent(itemEventType, callback)
```
Connects to a callback to an [item event](#events) (e.g., used, selected) for an item.

---

### unbindEvent
```lua
item:unbindEvent(itemEventType)
```
Unbinds the connection to the specified item event.

---

### bindCondition
```lua
item:bindCondition(name, action, callback)
```
Binds a condition to a specific item.

---

### unbindCondition
```lua
item:unbindCondition(name)
```
If the given `name` is `nil` then unbinds all conditions for that item. If `name` is an [item event](#events) then it unbinds all conditions for that event. Otherwise, unbinds the condition with he given name.

---

### cooldown
```lua
item:cooldown(duration)
```
Sets an item on cooldown for the specified duration in seconds. When on cooldown, the item cannot be used except for pressAgain (though this can be changed with [setCanPressAgainOnCooldown](#setCanPressAgainOnCooldown) and `item.canSelectOnCooldown` to be able to select when on cooldown).

---

### setLabel
```lua
item:setLabel(text)
```
Sets the label text displayed on the item's GUI widget.

--- 

### setText
```lua
item:setText(text)
```
Sets the main text displayed on the item's GUI widget button.

---

### setBottomText
```lua
item:setBottomText(text)
```
Sets the bottom text of the item's GUI widget.

---

### setName
```lua
item:setName(name)
```
Renames the item and updates its associated GUI elements with the specified name.

---

### showOutline
```lua
item:showOutline(bool)
```
Enables or disables the outline effect on the item's GUI widget.

---

### setLayoutOrder
```lua
item:setLayoutOrder(position)
```
Sets the layout order of the item within the hotbar, affecting its display position. Uses Roblox
[UIListLayout](https://create.roblox.com/docs/reference/engine/classes/UIListLayout), so items with the same `LayoutOrder` property may display in unexpected ways. Check Roblox [docs](https://create.roblox.com/docs/reference/engine/classes/GuiObject/LayoutOrder) for more info on `LayoutOrder`.

---

### endUseOnCooldown
```lua
item:endUseOnCooldown(bool)
```
Determines whether the item should automatically end use when it enters cooldown.

---

### checkConditions
```lua
item:checkConditions(event)
```
Checks whether all conditions associated with the given event are satisfied. Returns true if all conditions pass, otherwise false.

---

### attemptTo
```lua
item:attemptTo(event, ...)
```
Attempts to trigger the specified event if all associated conditions are met.

---

### bindToggle
```lua
item:bindToggle(callback)
```
Binds a callback to both the "selected" and "deselected" events for the item.

---

### bindToggleItem
```lua
item:bindToggleItem(item)
```
Binds a GUI object or LayerCollector to toggle its visibility when the item is selected or deselected.

---

### unbindToggleItem
```lua
item:unbindToggleItem(item)
```
Unbinds a previously toggled item, stopping its visibility from being controlled by the hotbar.

---

### showToggleItems
```lua
item:showToggleItems(bool)
```
Shows or hides all items bound to the toggle functionality based on the specified boolean value.

---

### bindToggleKey
```lua
item:bindToggleKey(keyCodeEnum, inputType)
```
Binds a key to toggle the item's selection state.

---

### unbindToggleKey
```lua
item:unbindToggleKey(keyCodeEnum)
```
Unbinds a key previously set to toggle the item's selection state.

---

### oneClick
```lua
item:oneClick(bool)
```
Enables or disables the "one-click" functionality, where the item automatically uses and deselects itself upon selection.

---

### lock
```lua
item:lock()
```
Locks the item, any interactions.

---

### unlock
```lua
item:unlock()
```
Unlocks the item, enabling interactions.

---

### debounce
```lua
item:debounce(seconds)
```
Temporarily locks the item for the specified duration in seconds, then unlocks it automatically.

---

### setWidgetFill
```lua
item:setWidgetFill(percentFill, duration)
```
Adjusts the item's widget fill to a percentage. Optionally, animates the change over the specified duration.

---

### endCooldown
```lua
item:endCooldown()
```
Ends the item's cooldown state and resets its widget fill.

---

### playAnimationSelf
```lua
item:playAnimationSelf(name, ...)
```
Plays an animation and passes self (along with any additional specified args).

---

### AutoDeselect
```lua
item:AutoDeselect(bool)
```
Enables or disables automatic deselection when other items are selected.

---

### deselectAllBut
```lua
item:deselectAllBut()
```
Deselects all other items in the hotbar.

---

### bindPressAgain
```lua
item:bindPressAgain(number, callback)
```
Binds a callback to execute when the item is used (with mouse button 1 or touch) repeatedly in sequence. When pressAgain reaches the max specified number, it goes back to the original `used` function. 
It will not work if there are gaps in numbers (1, 2, 4). 

---

### unbindPressAgain
```lua
item:unbindPressAgain(number)
```
Unbinds the callback associated with a specific pressAgain number.

---

### setPressAgainMax
```lua
item:setPressAgainMax(number)
```
Sets the maximum allowable number for the pressAgain sequence.

---

### resetPressAgainOnEndCooldown
```lua
item:resetPressAgainOnEndCooldown(bool)
```
Specifies whether the "press again" sequence should reset after the item ends its cooldown.

### setCanPressAgainOnCooldown
```lua
item:setCanPressAgainOnCooldown(bool)
```
Allows or disallows pressAgain functionality while the item is on cooldown (automatically true).

---

### select
```lua
item:select(fromSource, sourceItem)
```
Manually selects the item, optionally specifying the source of the selection.

---

### deselect
```lua
item:deselect(fromSource, sourceItem)
```
Manually deselects the item, optionally specifying the source of the deselection.

---

### use
```lua
item:use()
```
Manually uses the item and fires the used event.

---

### endUse
```lua
item:endUse()
```
Manually end use of the item and fires the endUsed event.

---

### destroy
```lua
item:destroy()
```
Cleans up the item's resources, removes it from the hotbar, and disconnects all associated signals and events.

## Events

### selected
```lua
item.selected:Connect(function(fromSource)
    -- fromSource can be used to check what caused the event
    -- possibilities include "User", "OneClick", and "AutoDeselect"
    local source = fromSource or "Unknown"
    print("The item was selected by the "..sourceName)
end)
```

### deselected
```lua
item.selected:Connect(function(fromSource)
    local source = fromSource or "Unknown"
    print("The item was deselected by the "..sourceName)
end)
```

### toggled
```lua
item.toggled:Connect(function(isSelected, fromSource)
    local state = (isSelected and "selected") or "deselected"
    print("The item was "..state)
end)
```

### viewingStarted
```lua
item.viewingStarted:Connect(function()
    print("A mouse is hovering over the item")
end)
```

### viewingEnded
```lua
item.viewingEnded:Connect(function()
    print("The user is no longer viewing (hovering over) the item")
end)
```

### used
```lua
item.used:Connect(function()
    print("The user began mouse button 1 or touch input with this item selected, thus using it")
end)
```

### endUsed
```lua
item.endUsed:Connect(function()
    print("The user ended mouse button or tap input, ending use of the item")
end)
```

### pressedAgain
```lua
item.pressedAgain:Connect(function(pressNum, inputType, fromSource, item)
    -- pressNum starts at 1 for first pressAgain, 2 for second, etc
    print("The item was pressed again "..pressNum.." time(s)")
end)
```
This fires when the user "uses" the item again (i.e. clicking or touching). Think of pressedAgain as a list of functions that the item cycles through when used. It starts with the bound `used` function, then goes through these, before starting again.
  
This is mostly useful, and intended for, when you want to modify a a `used` function based on timing. Fort example, perfect casting a spell: the `used` function is casting the spell, and the `pressAgain` 1 is modifying the damage or casting the spell immediately.

### stateChanged
```lua
item.stateChanged:Connect(function(incomingState, currentState, fromSource, sourceItem)
    -- incomingState is the new state
    -- Possible values are "selected", "deselected", and "Viewing"
    -- currentState is the previous state that was changed to the incomingState
    -- and has the same possible values
    print("The item's state was changed from "..currentState.." to "..incomingState)
end)
```

## Properties

### Name
```lua
local string = item.Name
```
Name as defined by [`setName`](#setname)

---

### isSelected
```lua
local bool = item.isSelected
```
Whether an item is selected.

---

### isViewing
```lua
local bool = item.isViewing
```

---

### isUsing
```lua
local bool = item.isUsing
```

---

### isLocked
```lua
local bool = item.isLocked
```
Whether an item is locked—i.e. can be interacted with in any way.

---

### isOnCooldown
```lua
local string = item.isOnCooldown
```
Cooldown operates similarly to an item being locked for a period of time, the only difference is that pressAgain, viewing, and selecting an item are possible. It is primarily for prevent the item from being used.

---

### UID
```lua
local string = item.UID
```
The item's universal identifier. 