---
sidebar_position: 3
---

# Tutorial
This tutorial will walk you through the basics of creating a hotbar with HotbarPlus.

### Installation
You can get the module on [Roblox](https://create.roblox.com/store/asset/77390116626784/Hotbar) or download it from [GitHub](https://github.com/RafiKastner/HotbarPlus).  
  
Simply put the script into Replicated Storage, and you're done! 🎉

### Creating the Hotbar
Start by requiring the module.
```lua
local hotbar = require(game:GetService("ReplicatedStorage").Hotbar)
```

### Creating Items
Now we can add some items. Let's use the `.new()` constructor and store the return in a variable.
```lua
local item  = hotbar.new()
```
We should also name our item so that the Roblox GUI frame is distinct and our hotbar GUI tree is legible.
```lua
item:setName("MyItem")
```

### Making It Look Good
Let's set the text of the item so we know what it is.
```lua
item:setText("My Item")
```
  
This will be the first item in our hotbar, so let's also set the label to 1.
```lua
item:setLabel("1")
```

### Binding a Key
Sure we can click on the item to select it, but we also want to be able to press a key to do so, like an actual hotbar.  
  
Since it's the first item in our hotbar, let's bind it to the 1 key.
```lua
item:bindToggleKey("1")
```

### Adding Functionality
Let's now bind a function for when the item is used.
```lua
item:bindEvent("used", function(self)
    print("This item was used!")
end)
```

### Changing Behavior
Ok, what about making this a oneClick button? Instead of selecting it and then clicking to use it, we can automatically use it when we press 1.
```lua
item:oneClick()
```

### Animating
Finally, why don't we tween in the hotbar when the player spawns. It'll be a nice little animation for the hotbar to pop up.  
  
There's already a built-in tween function, so we can just use that.
```lua
Hotbar.playAnimation("TweenIn")
```
We can pass an adition two argumens being the time (seconds) and [TweenInfo](https://create.roblox.com/docs/reference/engine/datatypes/TweenInfo), but the default works too.

### Next Steps
That's about all it takes to make a hotbar item. There's much more you can do, like binding conditions, adding pressAgain functions, using custom animations, and more. Go check out the [docs](/docs) for more info!