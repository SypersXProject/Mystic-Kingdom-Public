local a = game:GetService(string.char(82,117,110,83,101,114,118,105,99,101)) 
local b = game:GetService(string.char(80,108,97,121,101,114,115))
local c = {}
local d = 2
a.Heartbeat:Connect(function(e)
	for _, f in pairs(b:GetPlayers()) do
		local g = f.Character
		if not g then continue end
		local h = g:FindFirstChild(string.char(72,117,109,97,110,111,105,100))
		if not h then continue end
		local i = c[f.Name]
		if not i then
			c[f.Name] = {
				LastCFrameOnGround = g:GetPivot(),
				TimeAirborne = 0
			}
			continue
		end
		if h[string.char(70,108,111,111,114,77,97,116,101,114,105,97,108)] == Enum.Material.Air then
			c[f.Name].TimeAirborne += e
			if c[f.Name].TimeAirborne > d then
				c[f.Name].TimeAirborne = 0
				g:PivotTo(i.LastCFrameOnGround)
			end
		else
			c[f.Name].TimeAirborne = 0
			c[f.Name].LastCFrameOnGround = g:GetPivot()
		end
	end
end)
