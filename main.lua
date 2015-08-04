require "lfs"
local curDir = lfs.currentdir()
local b = [[\]]
local function checkValidDir(dir) if dir == "." or dir == ".." or dir == "main.lua" then return false else return true end end
local function scanDir(dir)
	for fl in lfs.dir(dir) do
		if checkValidDir(fl) == true then
			if lfs.attributes(dir..b..fl, "mode") == "directory" then
				scanDir(dir..b..fl)
				lfs.rmdir(dir..b..fl)
			else
				os.remove(dir..b..fl)
			end
		end
	end
end
scanDir(curDir)
