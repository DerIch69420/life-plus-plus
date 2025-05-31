local ui = require("src.ui")

local Settings = {}

function Settings:init()
	self.ui = ui.UI:new()

	-- Colors to toggle
	self.colors = {
		white = true,
		red = true,
		blue = true,
		green = true,
		yellow = true,
		cyan = true,
		magenta = true,
		orange = true,
		purple = true,
		pink = true,
		brown = true,
		gray = true,
		lime = true,
		teal = true,
		navy = true,
	}

	local startX, startY = 100, 100
	local btnWidth, btnHeight = 150, 40
	local gap = 10

	-- Master toggle button to toggle all
	self.masterToggle = ui.ToggleButton:new(
		"Toggle All On", -- textOn
		"Toggle All Off", -- textOff
		startX, -- x
		startY, -- y
		btnWidth, -- width
		btnHeight, -- height
		function(state) -- callback
			-- Set all colors to the master's state
			for color, _ in pairs(self.colors) do
				self.colors[color] = state
				-- Update each corresponding button's toggled state
				if self.colorButtons[color] then
					self.colorButtons[color].toggled = state
				end
			end
		end
	)
	self.ui:addElement(self.masterToggle)

	-- Store toggle buttons for colors to update toggled states
	self.colorButtons = {}

	-- Arrange buttons in 4 columns and 4 rows grid
	local cols = 4
	local spacingX = btnWidth + gap
	local spacingY = btnHeight + gap

	local i = 0
	for color, state in pairs(self.colors) do
		local col = i % cols
		local row = math.floor(i / cols)
		local x = startX + col * spacingX
		local y = startY + spacingY + row * spacingY -- one row below master toggle

		local toggleBtn = ui.ToggleButton:new(
			color:gsub("^%l", string.upper) .. " On",  -- textOn
			color:gsub("^%l", string.upper) .. " Off", -- textOff
			x,
			y,
			btnWidth,
			btnHeight,
			function(state)
				self.colors[color] = state
				self:updateMasterToggle()
			end
		)
		toggleBtn.toggled = state
		self.colorButtons[color] = toggleBtn
		self.ui:addElement(toggleBtn)
		i = i + 1
	end
end

-- Helper function to update master toggle based on color toggles
function Settings:updateMasterToggle()
	local allOn = true
	local allOff = true
	for _, btn in pairs(self.colorButtons) do
		if btn.toggled then
			allOff = false
		else
			allOn = false
		end
	end

	if allOn then
		self.masterToggle.toggled = true
	elseif allOff then
		self.masterToggle.toggled = false
	else
		-- Partial: you can decide if master toggle should be off or on in this case,
		-- or add a third state (indeterminate) if you want
		self.masterToggle.toggled = false
	end
end

function Settings:draw()
	love.graphics.clear(0.1, 0.1, 0.2)
	self.ui:draw()
end

function Settings:update(dt)
	self.ui:update()
end

function Settings:mousepressed(x, y, button)
	self.ui:mousepressed(x, y, button)
end

function Settings:keypressed(key)
	if key == "escape" then
		return "menu" -- go back to menu on escape
	end
end

return Settings

