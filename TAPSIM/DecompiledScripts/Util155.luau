local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Game.PetStats);
local _ = require(l_ReplicatedStorage_0.Modules.Rainbow);
local _ = l_Players_0.LocalPlayer;
local _ = l_ReplicatedStorage_0.Content.Pets;
local _ = {};
local function _(v8, v9) --[[ Line: 19 ]] --[[ Name: Weld ]]
    local l_Weld_0 = Instance.new("Weld");
    l_Weld_0.Part0 = v8;
    l_Weld_0.Part1 = v9;
    l_Weld_0.C0 = v8.CFrame:toObjectSpace(v9.CFrame);
    l_Weld_0.Parent = v9;
    return l_Weld_0;
end;
local function _(v12, v13) --[[ Line: 28 ]] --[[ Name: WeldConstraint ]]
    local l_WeldConstraint_0 = Instance.new("WeldConstraint");
    l_WeldConstraint_0.Part0 = v12;
    l_WeldConstraint_0.Part1 = v13;
    l_WeldConstraint_0.Parent = v13;
    return l_WeldConstraint_0;
end;
local function _(v16) --[[ Line: 36 ]] --[[ Name: getDir ]]
    return v16.Y == 0 and Vector3.new() or v16.Y > 0 and -v16 or v16;
end;
local function v28(v18) --[[ Line: 44 ]] --[[ Name: lowestPoint ]]
    local v19 = nil;
    local v20 = nil;
    if v18:IsA("Model") then
        local l_v18_BoundingBox_0, v22 = v18:GetBoundingBox();
        v19 = l_v18_BoundingBox_0;
        v20 = v22 / 2;
    else
        v19 = v18.CFrame;
        v20 = v18.Size / 2;
    end;
    local l_RightVector_0 = v19.RightVector;
    local v24 = (l_RightVector_0.Y == 0 and Vector3.new() or l_RightVector_0.Y > 0 and -l_RightVector_0 or l_RightVector_0) * v20.X;
    local l_UpVector_0 = v19.UpVector;
    local v26 = (l_UpVector_0.Y == 0 and Vector3.new() or l_UpVector_0.Y > 0 and -l_UpVector_0 or l_UpVector_0) * v20.Y;
    local l_LookVector_0 = v19.LookVector;
    l_RightVector_0 = (l_LookVector_0.Y == 0 and Vector3.new() or l_LookVector_0.Y > 0 and -l_LookVector_0 or l_LookVector_0) * v20.Z;
    return (v19 + v24 + v26 + l_RightVector_0).p;
end;
local function _(v29, v30, v31, v32, v33) --[[ Line: 65 ]] --[[ Name: calcRange ]]
    return v32 + (v33 - v32) * (v29 - v30) / (v31 - v30);
end;
local function _(v35) --[[ Line: 69 ]] --[[ Name: centerPoint ]]
    return v35:GetBoundingBox();
end;
GetPointOnCircle = function(v37, v38) --[[ Line: 73 ]] --[[ Name: GetPointOnCircle ]]
    return (Vector3.new(math.cos((math.rad(v38))) * v37, 1, math.sin((math.rad(v38))) * v37));
end;
local v39 = {};
local _ = function(v40, v41) --[[ Line: 80 ]] --[[ Name: unpackFolder ]]
    for _, v43 in pairs(v40:GetChildren()) do
        v43.Parent = v41;
    end;
    v40:Destroy();
end;
v39.getPosition = function(_, v46, v47, v48) --[[ Line: 87 ]] --[[ Name: getPosition ]]
    v48 = v48 or 6;
    local v49 = 360 / v47;
    return GetPointOnCircle(v48, v49 * v46);
end;
v39.PreparePet = function(_, v51) --[[ Line: 93 ]] --[[ Name: PreparePet ]]
    -- upvalues: v3 (copy), v28 (copy)
    local l_Name_0 = v51.Name;
    local l_Id_0 = v51.Id;
    local l_v3_Model_0 = v3:GetModel(v51.Name, v51.Tier, true);
    local v55 = v28(l_v3_Model_0);
    l_v3_Model_0.Name = l_Id_0 or l_Name_0;
    if not l_v3_Model_0.PrimaryPart then
        l_v3_Model_0.PrimaryPart = l_v3_Model_0:FindFirstChild("Head") or l_v3_Model_0:FindFirstChildOfClass("BasePart");
    end;
    local l_PrimaryPart_0 = l_v3_Model_0.PrimaryPart;
    local l_Part_0 = Instance.new("Part");
    l_Part_0.Anchored = true;
    l_Part_0.CanCollide = false;
    l_Part_0.CanQuery = false;
    l_Part_0.Name = "Root";
    l_Part_0.Size = Vector3.new(1, 0.10000000149011612, 1, 0);
    l_Part_0.Position = Vector3.new(l_PrimaryPart_0.Position.X, v55.Y, l_PrimaryPart_0.Position.Z);
    l_Part_0.Transparency = 1;
    local _ = v3:GetHuge(v51.Name);
    local v59 = nil;
    for _, v61 in ipairs(l_v3_Model_0:GetDescendants()) do
        if v61:IsA("BasePart") then
            v61.CanCollide = false;
            v61.Anchored = true;
            v61.CanQuery = false;
            v61.CanTouch = false;
            if v61 == l_PrimaryPart_0 then
                local l_Weld_1 = Instance.new("Weld");
                l_Weld_1.Part0 = l_Part_0;
                l_Weld_1.Part1 = v61;
                l_Weld_1.C0 = l_Part_0.CFrame:toObjectSpace(v61.CFrame);
                l_Weld_1.Parent = v61;
                v59 = l_Weld_1;
            end;
        end;
        if v61:IsA("Decal") then
            v61.Texture = "rbxthumb://type=Asset&id=" .. string.gsub(v61.Texture, "%D", "") .. "&w=150&h=150";
        end;
    end;
    l_Part_0.Parent = l_v3_Model_0;
    l_v3_Model_0.PrimaryPart = l_Part_0;
    l_v3_Model_0:PivotTo(CFrame.new((Vector3.new(0, -10, 0, 0))));
    return l_v3_Model_0;
end;
return v39;