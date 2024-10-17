-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ContextActionService = game:GetService("ContextActionService")

-- Modules
local Signal = require(script.Packages.GoodSignal)
local Janitor = require(script.Packages.Janitor)
local Utility = require(script.Utility)
local Hotbar = {}
Hotbar.__index = Hotbar

-- Local
local localPlayer = Players.LocalPlayer
local hotbarDict = {}
local anyItemSelected = Signal.new()
local state = "allDeselected"

-- Public Variables
Hotbar.hotbarDict = hotbarDict
Hotbar.hotbarEnabled = true
Hotbar.baseDisplayOrderChanged = Signal.new()
Hotbar.baseDisplayOrder = 10
Hotbar.itemAdded = Signal.new()
Hotbar.itemRemoved = Signal.new()
Hotbar.itemChanged = Signal.new()
Hotbar.anyItemSelected = anyItemSelected
Hotbar.firstItemSelected = Signal.new()
Hotbar.allDeselected = Signal.new()
Hotbar.container = require(script.Elements.Container)(Hotbar)
Hotbar.bar = Hotbar.container.Parent

-- Public Functions
function Hotbar.getItems()
	return hotbarDict
end

function Hotbar.getItem(UID)
	return hotbarDict[UID]
end

function Hotbar.getState()
	return state
end

function Hotbar.setHotbarEnabled(bool)
	bool = bool == nil and true or bool
	Hotbar.hotbarEnabled = bool
	Hotbar.bar.Enabled = bool
end

function Hotbar.setDisplayOrder(int)
	Hotbar.baseDisplayOrder = int
	Hotbar.baseDisplayOrderChanged:Fire()
end

function Hotbar.bindConditionAll(name, action, callback)
	for _,item in pairs(hotbarDict) do
		item:bindCondition(name, action, callback)
	end
end

function Hotbar.unbindConditionAll(name)
	for _,item in pairs(hotbarDict) do
		item:unbindCondition(name)
	end
end


-- Constructor
function Hotbar.new()
	local self = {}
	setmetatable(self, Hotbar)
	
	--Janitors
	local janitor = Janitor.new()
	self.janitor = janitor
	self.captionJanitor = janitor:Add(Janitor.new())
	self.oneClickJanitor = janitor:Add(Janitor.new())
	
	-- Register
	local UID
	local function UIDgen()
		UID = Utility.generateUID()
		if hotbarDict[UID] ~= nil then
			UIDgen()
		else
			hotbarDict[UID] = self
		end
	end
	UIDgen()
	janitor:Add(function()
		hotbarDict[UID] = nil
	end)
	
	-- Signals
	self.selected = janitor:Add(Signal.new())
	self.deselected = janitor:Add(Signal.new())
	self.toggled = janitor:Add(Signal.new())
	self.used = janitor:Add(Signal.new())
	self.endUsed = janitor:Add(Signal.new())
	self.stateChanged = janitor:Add(Signal.new())
	self.viewingStarted = janitor:Add(Signal.new())
	self.viewingEnded = janitor:Add(Signal.new())
	self.toggleKeyAdded = janitor:Add(Signal.new())
	
	-- Properties
	self.isSelected = false
	self.isViewing = false
	self.oneClickEnabled = false
	self.autoDeselect = true
	self.isLocked = false
	self.outlineEnabled = true
	self.activeState = "deselected"
	self.UID = UID
	self.boundEvents = {}
	self.boundConditions = {}
	self.boundToggleKeys = {}
	self.boundToggleItems = {}
	
	--Widget is the name for the gui (item is the item/slot itself)
	local widget = require(script.Elements.Widget)(self, Hotbar)
	self.widget = widget
	self.widgetOutline = self.widget.UIStroke
	self.widgetFill = self.widget.Fill
	
	-- Internal Functions/Listeners
	local function handleToggle()
		if self.isLocked then
			return
		end

		if self.isSelected then
			self:attemptTo("deselect", "User", self)

		elseif not self.isSelected then
			self:attemptTo("select", "User", self)
		end
		return self
	end
	
	local function viewingStarted(dontSetState)
		if self.isLocked then
			return
		end
		
		self.isViewing = true
		self.viewingStarted:Fire()
		if not dontSetState then
			self:setState("Viewing", "User", self)
		end
	end
	
	local function viewingEnded()
		if self.isLocked then 
			return
		end
		
		self.isViewing = true
		self.viewingEnded:Fire()
		self:setState(nil, "User", self)
	end
	
	widget.TextButton.Activated:Connect(function()
		handleToggle()
	end)
	
	widget.TextButton.MouseEnter:Connect(function()
		local dontSetState = not UserInputService.KeyboardEnabled
		viewingStarted(dontSetState)
	end)
	
	widget.TextButton.MouseLeave:Connect(function()
		viewingEnded()
	end)
	
	local function mouseInput(input)
		if self.isLocked then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseButton1 and self.isSelected then
			if input.UserInputState == Enum.UserInputState.Begin then
				self:attemptTo("use")
			else
				self:attemptTo("endUse")
			end
		end
	end
	
	janitor:Add(UserInputService.InputBegan:Connect(function(input, GPE)
		if GPE then
			return
		end
		
		if self.boundToggleKeys[input.KeyCode] then
			handleToggle()
		end
		mouseInput(input)
	end))
	
	janitor:Add(UserInputService.InputEnded:Connect(function(input, GPE)
		if GPE then
			return
		end
		
		mouseInput(input)
	end))

	
	self.selected:Connect(function()
		if self.outlineEnabled then
			self.widgetOutline.Enabled = true
		end
	end)
	
	self.deselected:Connect(function()
		if self.outlineEnabled then
			self.widgetOutline.Enabled = false
		end
	end)
	
	janitor:Add(anyItemSelected:Connect(function(incomingItem)
		if incomingItem ~= self and self.autoDeselect and incomingItem.autoDeselect then
			self:deselect("AutoDeselect", incomingItem)
		end
	end))
	
	return self
end


-- Methods
function Hotbar:setLabel(text, itemState)
	self.widget.Label.Text = text
	return self
end

function Hotbar:setText(text, itemState)
	self.widget.TextButton.Text = text
	return self
end

function Hotbar:setName(name)
	self.widget.Name = name
	self.Name = name
	return self
end

function Hotbar:showOutline(bool)
	bool = nil and true or bool
	self.outlineEnabled = bool
	return self
end

function Hotbar:animation()
	
end

function Hotbar:bindEvent(itemEventType, callback)
	local event = self[itemEventType]
	self.boundEvents[itemEventType] = event:Connect(function(...)
		callback(self, ...)
	end)
	return self
end

function Hotbar:unbindEvent(itemEventType)
	local eventConnection = self.boundEvents[itemEventType]
	if eventConnection then
		eventConnection:Disconnect()
		self.boundEvents[itemEventType] = nil
	end
	return self
end

function Hotbar:bindCondition(name, action, callback)
	if self[action] == nil then
		warn("Attempt to assign condition to nonexistant event")
		return self
	end
	if self.boundConditions[action] == nil then
		self.boundConditions[action] = {}
	end
	self.boundConditions[action][name] = callback
	return self
end

function Hotbar:unbindCondition(name)
	if name == nil then
		self.boundConditions = {}
	elseif self.boundConditions[name] then
		self.boundConditions[name] = nil
	else
		for i,v in pairs(self.boundConditions) do
			if self.boundConditions[i][name] then
				self.boundConditions[i][name] = nil
			end
		end
	end
	return self
end

function Hotbar:checkConditions(event)
	local check = true
	if self.boundConditions[event] == nil then
		return check
	end
	for _,callback in pairs(self.boundConditions[event]) do
		if callback() == false then
			check = false
		end
	end
	return check
end

function Hotbar:attemptTo(event, ...)
	if not self:checkConditions(Utility.convertToPastTense(event)) then
		return self
	end
	self[event](self, ...)
	return self
end

function Hotbar:bindToggle(callback)
	Hotbar:bindEvent("selected", callback)
	Hotbar:bindEvent("deselected", callback)
	return self
end

function Hotbar:bindToggleItem(item)
	if not item:IsA("GuiObject") and not item:IsA("LayerCollector") then
		warn("Toggle item '"..item.Name.."' must be a GuiObject or LayerCollector!")
	end
	self.boundToggleItems[item] = true
	return self
end

function Hotbar:unbindToggleItem(item)
	self.boundToggleItems[item] = nil
	return self
end

function Hotbar:showToggleItems(bool)
	for item,_ in pairs(self.boundToggleItems) do
		if item:IsA("GuiObject") then
			item.Active = bool
		elseif item:IsA("LayerCollector") then
			item.Enabled = bool
		end
	end
	return self
end

function Hotbar:bindToggleKey(keyCodeEnum, inputType)
	self.boundToggleKeys[Enum.KeyCode[keyCodeEnum]] = keyCodeEnum
	self.toggleKeyAdded:Fire()
	return self
end

function Hotbar:unbindToggleKey(keyCodeEnum)
	self.boundToggleKeys[keyCodeEnum] = nil
	return self
end

function Hotbar:oneClick(bool)
	self.oneClickJanitor:Clean()
	if bool or bool == nil then
		self.oneClickJanitor:Add(self.toggled:Connect(function(selected)
			self:attemptTo("endUse")
			task.wait() --  Ugh this is here because I think GoodSignal does not queue signals so this can fuck up
			--  the firstSelected signal becuase shit gets out of order fucking fix this please
			self:attemptTo("deselect", "OneClick", self)
		end))
	end
	self.outlineEnabled = false
	self.oneClickEnabled = true
	return self
end

function Hotbar:lock()
	self.isLocked = true
	return self
end

function Hotbar:unlock()
	self.isLocked = false
	return self
end

function Hotbar:debounce(seconds)
	self:lock()
	task.wait(seconds)
	self:unlock()
	return self
end

function Hotbar:setWidgetFill(percentFill, duration)
	if percentFill == nil then
		percentFill = 100
	end
	local maxFillSize = self.widget.TextButton.size.Y.Offset --this is dumb; change to to be based off theme when adding that
	local fill = percentFill * .01 * maxFillSize
	local udimOld = self.widgetFill.Size
	
	self.widgetFill.Size = UDim2.new(1, 0, 0, fill) --also lowkey dumb hardcodes but idc
	if duration then
		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear) 
		local tween = TweenService:Create(self.widgetFill, tweenInfo, { Size = udimOld })
		tween:Play()
		return tween
	end
	return nil
end

function Hotbar:cooldown(duration)
	self:deselect()
	self:lock()
	local tween = self:setWidgetFill(100, duration)
	tween.Completed:Connect(function()
		self:unlock()
	end)
	return self
end

function Hotbar:AutoDeselect(bool)
	bool = nil and true or bool
	self.autoDeselect = bool
	return self
end

function Hotbar:deselectAllBut()
	for UID, item in pairs(hotbarDict) do
		if item ~= self then
			item:deselect()
		end
	end
end

function Hotbar:select(fromSource, sourceItem)
	self:setState("selected", fromSource, sourceItem)
	return self
end

function Hotbar:deselect(fromSource, sourceItem)
	self:setState("deselected", fromSource, sourceItem)
	return self
end

function Hotbar:use()
	self.used:Fire()
end

function Hotbar:endUse()
	self.endUsed:Fire()
end

function Hotbar:setState(incomingState, fromSource, sourceItem)	
	if incomingState == nil then
		incomingState = self.isSelected and "selected" or "deselected"
	end
	
	local currentState = self.activeState
	if incomingState == currentState then
		return
	end
	
	self.activeState = incomingState
	local selected = self.isSelected
	if incomingState == "selected" then
		self.isSelected = true
		if not selected then
			self.selected:Fire(fromSource, sourceItem)
			self.toggled:Fire(true, fromSource, sourceItem)
			anyItemSelected:Fire(self, fromSource, sourceItem)
			if state == "allDeselected" then
				state = "anySelected"
				Hotbar.firstItemSelected:Fire(self, fromSource, sourceItem)
			end
		end
		self:showToggleItems(true)
	elseif incomingState == "deselected" then
		self.isSelected = false
		if selected then
			self.deselected:Fire(fromSource, sourceItem)
			self.toggled:Fire(false, fromSource, sourceItem)
			if fromSource ~= "AutoDeselect" then
				state = "allDeselected"
				Hotbar.allDeselected:Fire(self, fromSource, sourceItem)
			end
		end
		self:showToggleItems(false)
	end
	self.stateChanged:Fire(incomingState, currentState, fromSource, sourceItem)
end

return Hotbar
