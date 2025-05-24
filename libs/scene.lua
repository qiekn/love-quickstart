-- a state is just a table with enter, exit, update, and draw functions
---@diagnostic disable: redundant-parameter

local noop = function() end
local empty_scene = {
  enter = noop,
  exit = noop,
  update = noop,
  draw = noop,
}

scene = {
  current = empty_scene,
  scenes = {
    ["empty"] = empty_scene,
  },
}

function scene:add(name, scene)
  self.scenes[name] = scene
end

function scene:switch(new_scene, ...)
  if self.scenes[new_scene] then
    if self.current.exit then
      self.current:exit()
    end

    self.current = self.scenes[new_scene]

    if self.current.enter then
      self.current:enter(...)
    end
  else
    error("Scene " .. new_scene .. " does not exist.")
  end
end

function scene:update(dt)
  if self.current.update then
    self.current:update(dt)
  end
end

function scene:draw()
  if self.current.draw then
    self.current:draw()
  end
end

return scene
