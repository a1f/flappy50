PlayState = Class{__includes = BaseState}

require 'Bird'
require 'Pipe'

function PlayState:init()
    self.bird = Bird{}
    self.pipes = {}
    self.pipe_timer = 0
    self.score = 0
    self.last_pipe_y = PIPE_HEIGHT - 35 - math.random(80)
end

function PlayState:update(dt)
    self.pipe_timer = self.pipe_timer + dt
    if self.pipe_timer > 2.5 then
        -- local y = math.min(PIPE_HEIGHT - 35, math.max(135, self.last_pipe_y + math.random(-20, 20)))
        local y = math.min(PIPE_HEIGHT - 35, self.last_pipe_y + math.random(-50, 50))
        y = math.max(135, y)
        self.last_pipe_y = y
        table.insert(self.pipes, Pipe(y))
        self.pipe_timer = 0
    end

    for k, p in pairs(self.pipes) do
        p:update(dt)
        if not p.scored then
            if p.x + PIPE_WIDTH < self.bird.x then
                self.score = self.score + 1
                p.scored = true
                sounds['score']:play()
            end
        end
    end
    
    for k, p in pairs(self.pipes) do
        if p.to_remove then
            table.remove(self.pipes, k)
        end
    end

    for k, p in pairs(self.pipes) do
        if self.bird:collide(p) then
            sounds['explosion']:play()
            sounds['hurt']:play()
            gStateMachine:change('score', {
                score = self.score
            })
        end
    end

    self.bird:update(dt)

    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        sounds['explosion']:play()
        sounds['hurt']:play()
        gStateMachine:change('score', {
            score = self.score
        })
    end
end

function PlayState:render()
    self.bird:render()
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
    for k, p in pairs(self.pipes) do
        p:render()
    end
end