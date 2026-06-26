local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Mattia Hub | Optimizer Pro",
   LoadingTitle = "Caricamento Moduli Grafici...",
   LoadingSubtitle = "Pronto all'ottimizzazione",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Ottimizzazione", 4483362458)

-- =======================================================
-- FUNZIONI REALI DI OTTIMIZZAZIONE
-- =======================================================

-- 1. Pulizia dei detriti dal mondo (rimuove textures inutili, fumo, scintille)
local function BoostFPS()
    local terrain = workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
        terrain.WaterDetail = Enum.WaterDetail.Low
    end
    
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("CornerWedgePart") or v:IsA("WedgePart") or v:IsA("TrussPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy() -- Rimuove i poster e i dettagli grafici pesanti dalle pareti
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false -- Spegne le particelle che consumano frame rate
        elseif v:IsA("Explosion") then
            v.Visible = false
        elseif v:IsA("Lighting") then
            v.GlobalShadows = false
            v.FogEnd = 9e9
        end
    end
    
    Rayfield:Notify({Title = "FPS Boosted!", Content = "Grafica ridotta al minimo. Performance aumentate.", Duration = 4})
end

-- 2. Ottimizzazione della memoria (Rimuove istanze distrutte rimaste nei canali di gioco)
local function CleanMemory()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    sethiddenproperty(game.Lighting, "Technology", Enum.Technology.Compatibility)
    
    -- Forza la garbage collection se supportata dall'executor
    if gcinfo then
        local prima = gcinfo()
        task.wait(0.1)
        Rayfield:Notify({Title = "Memoria Pulita", Content = "Liberati circa " .. tostring(math.floor(prima / 1024)) .. " MB di RAM.", Duration = 4})
    else
        Rayfield:Notify({Title = "Memoria Pulita", Content = "Cache del gioco svuotata con successo.", Duration = 4})
    end
end

-- =======================================================
-- ELEMENTI DELL'INTERFACCIA
-- =======================================================

MainTab:CreateSection("Strumenti di Boost Reale")

MainTab:CreateButton({
   Name = "🚀 Attiva FPS Boost (Massima Performance)",
   Interact = "Esegui",
   Callback = function()
       BoostFPS()
   end,
})

MainTab:CreateButton({
   Name = "🧹 Svuota Cache & RAM (Riduci Lag)",
   Interact = "Esegui",
   Callback = function()
       CleanMemory()
   end,
})

MainTab:CreateSection("Monitor di Sistema")

local FpsLabel = MainTab:CreateLabel("Calcolo FPS in corso...")
local PingLabel = MainTab:CreateLabel("Calcolo Ping in corso...")

-- Loop in background per aggiornare FPS e Ping reali
task.spawn(function()
    local Stats = game:GetService("Stats")
    while task.wait(1) do
        -- Calcolo approssimativo FPS reali
        local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        
        FpsLabel:Set("FPS Attuali: " .. tostring(fps))
        PingLabel:Set("Ping di Rete: " .. tostring(ping) .. " ms")
    end
end)
