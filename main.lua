require "lfs"
local curDir = lfs.currentdir()
local b = [[\]]
local function checkValidDir(dir) return dir ~= "." and dir ~= ".." and dir ~= "main.lua" end
local function scanDir(dir)
	for fl in lfs.dir(dir) do
		if checkValidDir(fl) then
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
