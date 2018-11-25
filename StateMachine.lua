StateMachine = Class{}

function StateMachine:init(states)
    self.empty = {
        render = function() end,
		update = function() end,
		enter = function() end,
		exit = function() end
    }
    self.current = self.empty
    self.states = states
end

function StateMachine:change(state_name, params)
    self.current:exit()
    self.current = self.states[state_name]()
    self.current:enter(params)
end

function StateMachine:update(dt)
    self.current:update(dt)
end

function StateMachine:render()
    self.current:render()
end