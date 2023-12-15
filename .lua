local args = {
    [1] = {
        ["CF"] = CFrame.new(-141.36489868164062, 19.054075241088867, -426.1766662597656, 0.9075486063957214, -0.023218125104904175, -0.4193046987056732, -0, 0.9984703660011292, -0.05528821796178818, 0.4199470579624176, 0.05017674341797829, 0.9061604142189026),
        ["Part"] = workspace["Stage_Monster"]["Zombie"]["Head"],
        ["Owner"] = game:GetService("Players").LocalPlayer,
        ["TargetHead"] = true,
        ["Character"] = workspace["Rivanda_Cheater"],
        ["Hit"] = workspace["Stage_Monster"]["Zombie"]["Head"],
        ["Target"] = workspace["Stage_Monster"]["Zombie"],
        ["position"] = Vector3.new(-94.84754180908203, 25.18770980834961, -526.7054443359375),
        ["normal"] = Vector3.new(-0.8935296535491943, -0.4379199743270874, 0.09915187209844589),
        ["Damage"] = 15
    }
}

--game:GetService("ReplicatedStorage")["Remote"]["CastRemote"]:FireServer(unpack(args))
local workspace = game:GetService("Workspace")

local function Children(str,func)
  for i,v in pairs(str:GetChildren()) do
    func(i,v)
  end
end

local function getAllChildren(str,func)
  for i,v in pairs(str:GetDescendants()) do
    func(i,v)
  end
end

local function TriggerProximityPrompt()
  getAllChildren(workspace,function(i,v)
      if v:IsA("ProximityPrompt") then
        fireproximityprompt(v)
      end
    end)
  end

local Trigger = {
  Head = false
}

local client = {
  myself = game.Players.LocalPlayer,
  char = game.Players.LocalPlayer.Character,
  humanoid = game.Players.LocalPlayer.Character.Humanoid,
  root = game.Players.LocalPlayer.Character.HumanoidRootPart,
  damage = 15,
  enabled = false
}

local clientPosition = {
  root = client["root"].Position
}

local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall
gmt.__namecall = newcclosure(function(self, ...)
        local Args = {...}
        local method = getnamecallmethod()
	if tostring(self) == "CastRemote" and tostring(method) == "FireServer" and client.enabled == true then
           Children(workspace["Stage_Monster"],function(i,v)
		Args[1]["CF"] = v.Head.Position
		Args[1]["Part"] = v.Head
                Args[1]["TargetHead"] = true
                Args[1]["Hit"] = v.Head
                Args[1]["Target"] = v.Head
                Args[1]["position"] = v.Head.Position
           end)
		    return self.FireServer(self,unpack(Args))
        end
        return oldNamecall(self, ...)
end)

local OrionLib = loadstring(game:HttpGet("https://pastebin.com/raw/NMEHkVTb"))()
local Window = OrionLib:MakeWindow({Name = "VIP Turtle Hub V3", HidePremium = false, SaveConfig = false, ConfigFolder = "TurtleFi"})

local T1 = Window:MakeTab({
   Name = "Main",
   Icon = "rbxassetid://",
   PremiumOnly = false
})

local T2 = Window:MakeTab({
   Name = "Auto Pick up",
   Icon = "rbxassetid://",
   PremiumOnly = false
})

T1:AddToggle({
   Name = "Head Tracker",
   Default = false,
   Callback = function(Value)
      Trigger.Head = Value
   end    
})

T1:AddToggle({
   Name = "Auto Enable Tracker",
   Default = false,
   Callback = function(Value)
      client.enabled = Value
   end    
})

T2:AddToggle({
   Name = "Auto pick up nearest",
   Default = false,
   Callback = function(Value)
      _G.pun = Value
      while wait() do
        if _G.pun == false then break end
        TriggerProximityPrompt()
      end
   end    
})
