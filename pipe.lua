Pipe = Class{}

local GAP_HEIGHT = 90

function Pipe:init(y)
    self.x = VIRTUAL_WIDTH + 32
    self.y = y
    self.pipe_sprite = love.graphics.newImage('assets/pipe.png')
    self.to_remove = false
    self.scored = false
end

function Pipe:update(dt)
    self.x = self.x - PIPE_SPEED * dt
    if self.x + PIPE_WIDTH <= 0 then
        self.to_remove = true
    end
end

function Pipe:render()
    love.graphics.draw(self.pipe_sprite, self.x, self.y, 0, 1, 1)
    love.graphics.draw(self.pipe_sprite, self.x, self.y - GAP_HEIGHT, 0, 1, -1)
end