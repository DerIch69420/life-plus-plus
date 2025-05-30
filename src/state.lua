local State = {
	current = "menu"
}

function State:init()
	self.current = "menu"
end

function State:update(newState)
	if newState == "menu" or newState == "game" then
		self.current = newState
	else
		error("Invalid state: " .. tostring(newState))
	end
end

function State:is(state)
	return self.current == state
end

return State

