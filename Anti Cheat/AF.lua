local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local PlayerInfos = {}
local MaxAirborneTime = 2
RunService.Heartbeat:Connect(function(Delta)
	for _, Player in pairs(Players:GetPlayers()) do 
		local Character = Player.Character
		if not Character then 
			continue
		end
		local Humanoid:Humanoid = Character:FindFirstChild("Humanoid")
		if not Humanoid then
			continue
		end
		local Info = PlayerInfos[Player.Name] 
		if not Info then
			PlayerInfos[Player.Name] = {
				LastCFrameOnGround = Character:GetPivot(), 
				TimeAirborne = 0
			}
			continue
		end
		if Humanoid.FloorMaterial == Enum.Material.Air then 
			PlayerInfos[Player.Name].TimeAirborne += Delta
			if PlayerInfos[Player.Name].TimeAirborne > MaxAirborneTime then
				PlayerInfos[Player.Name].TimeAirborne = 0
				Character:PivotTo(Info.LastCFrameOnGround)
			end
		else
			PlayerInfos[Player.Name].TimeAirborne = 0
			PlayerInfos[Player.Name].LastCFrameOnGround = Character:GetPivot()
		end
	end
end)
