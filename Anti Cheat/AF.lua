--We'll be using RunService to run code every frame
local RunService = game:GetService("RunService")

--Using Players service to get all players in the server
local Players = game:GetService("Players")

--A list of information about a player; where they were last on the ground and
--how long they've been in the air
local PlayerInfos = {}

--How long someone can be in the air without being rubberbanded (teleported back)
local MaxAirborneTime = 2

--Connect to Heartbeat to run code after every physics step (60 times a second)
RunService.Heartbeat:Connect(function(Delta)
	for _, Player in pairs(Players:GetPlayers()) do --Go through each player
		local Character = Player.Character

		if not Character then --Do they have a character? If not, ignore this player
			continue
		end

		local Humanoid:Humanoid = Character:FindFirstChild("Humanoid")

		if not Humanoid then --Do they have a humanoid? If not, ignore this player
			continue
		end

		local Info = PlayerInfos[Player.Name] --Get info

		if not Info then --If the server hasn't started monitoring this player
			PlayerInfos[Player.Name] = { --Set default info
				LastCFrameOnGround = Character:GetPivot(), --Their current location
				TimeAirborne = 0
			}

			continue
		end

		if Humanoid.FloorMaterial == Enum.Material.Air then --Are they in the air?
			--Increase the counter for how long they've been in the air
			PlayerInfos[Player.Name].TimeAirborne += Delta

			--Have they been in the air for too long (longer than MaxAirboneTime)?
			if PlayerInfos[Player.Name].TimeAirborne > MaxAirborneTime then
				PlayerInfos[Player.Name].TimeAirborne = 0
				--Move them back to when they were last on the ground
				Character:PivotTo(Info.LastCFrameOnGround)
			end
		else --Player is on the ground
			PlayerInfos[Player.Name].TimeAirborne = 0
			--Set the last on ground location to be their current one
			PlayerInfos[Player.Name].LastCFrameOnGround = Character:GetPivot()
		end
	end
end)
