pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- kaiju-co-ltd

entities={}
submenus={}

function _init()

 e = entity:new()

	m = menu.create{
	 initial = "staff",
		items = {
			["staff"] = submenus["staff"],
			["work"] = submenus["work"],
			["settings"] = submenus["settings"]
		}
	}
	
-- for k, v in pairs(m.items) do
--  print(k .. "|" .. v)
-- end
end

function _update()
 for e in all(entities) do
--  e:update()
 end
 
 if btnp(⬆️) then m:traverse(⬆️) end
 if btnp(⬇️) then m:traverse(⬇️) end
 if btnp(❎) then m:select() end
end

function _draw()
 cls()
 spr(1,0,0)
 
 m:draw()
end

-->8
--entities

uid = {n = 0}
function uid.get()
 uid.n += 1
 return uid.n
end

entity = {}

function entity:new(o)
 o=o or {} --create if null
 setmetatable(o, self)
 self.__index=self
 self.id=uid.get()
 add(entities,o)
 return o
end

function entity:update()
 --do nothing
end

function entity:draw()
 --do nothing
end


-->8
--menu

menu={}
menu.__index = menu

--options
function menu.create(o)
 assert(o.items)
 
 local m = {}
 setmetatable(m, menu)
 
 m.items = {}
 m.refs = {}
 m.i = 1
 
 local i = 0
 for k, v in pairs(o.items) do
  i+=1
  m.items[i] = k
  m.refs[k] = v
  if m.items[i] == o.initial then m.i = i end  
 end
 
 m.n = i

 return m
end

function menu:current()
 return m.items[self.i]
end

function menu:print()
 local i=1
 for n in all(self.items) do
  if n==self:current() then print(">" .. n)
  else print(n) end
 end
end

function menu:traverse(d)
 if d==⬆️ and self.i > 1 then
  self.i -= 1
 end

 if d==⬇️ and self.i < self.n then
  self.i += 1
 end
 
 self:print()
end

function menu:select()
 o=self.refs[self:current()]
 printh(o.name)
end

function menu:draw()
 local x = 8
 local y = 100
 for n in all(self.items) do
  if n==self:current() then print(">", x-4, y) end
  print(n, x, y)
  y+=6
 end
end
-->8
--submenus

submenu = {name="none"}

function submenu:new(o)
 o=o or {} --create if null
 setmetatable(o, self)
 self.__index=self
 add(submenus,o)
 return o
end

function submenu:update()
 --do nothing
end

function submenu:draw()
 --do nothing
end

submenus.staff = submenu:new{name="staff"}
submenus.work = submenu:new{name="work"}
submenus.settings = submenu:new{name="settings"}

__gfx__
000000000a0000a000cccc00880000880e0000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000a000000a0cccccc00888888000eeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700a0aaaa0acccccccc080000800eeeeee00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000a0aa0a0cc0cc0cc08088080ee0ee0ee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000aa00aa00cccccc008000080eee00eee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000aaaa0000cccc00088888800ee00ee00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aa00aa00cccccc008088080e0e00e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000a0a00a0acc0cc0cc00800800e000000e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
