Bird = Class{}

local GRAVITY = 20

function Bird:init()
    self.sprite = love.graphics.newImage('assets/bird.png')
    self.x = VIRTUAL_WIDTH / 2 - 8
    self.y = VIRTUAL_HEIGHT / 2 - 8
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
    self.dy = 0
end

function Bird:collide(pipe)
    if self.x + self.width - 2 >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if self.y + self.height - 2 >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        end

        if self.y + self.height - 2 <= pipe.y - GAP_HEIGHT and self.y + 2 >= pipe.y - GAP_HEIGHT - PIPE_HEIGHT then
            return true
        end
        
    end
    return false
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        self.dy = -5
        sounds['jump']:play()
    end
    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.sprite, self.x, self.y)
end