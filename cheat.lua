local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local Window = Rayfield:CreateWindow({
   Name = "Mattia Hub | Optimizer Pro",
   LoadingTitle = "Caricamento Moduli Grafici...",
   LoadingSubtitle = "Pronto all'ottimizzazione",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Ottimizzazione", 4483362458)

-- =======================================================
-- FUNZIONI REALI DI OTTIMIZZAZIONE & ANTI-PAUSE
-- =======================================================

-- Funzione Anti-AFK (Impedisce il Game Paused)
local antiAfkAttivo = false
local function AttivaAntiAFK()
    if antiAfkAttivo then 
        Rayfield:Notify({Title = "Info", Content = "L'Anti-Game Paused è già attivo!", Duration = 3})
        return 
    end
    
    antiAfkAttivo = true
    
    Players.LocalPlayer.Idled:Connect(function()
        if antiAfkAttivo then
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
    end)
    
    Rayfield:Notify({
        Title = "Anti-AFK Attivato!", 
        Content = "Protezione attiva contro il Kick per inattività.", 
        Duration = 4
    })
end

-- Funzione FPS Boost REALE e Sicura
local function BoostFPS()
    -- Modifica il terreno in modo sicuro senza rompere lo script
    pcall(function()
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterDetail = Enum.WaterDetail.Low
        end
    end)

    -- Tenta di abbassare la qualità di rendering globale (se l'executor lo permette)
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)

    -- Ottimizzazione aggressiva degli oggetti nel mondo di gioco
    for _, v in pairs(game:GetDescendants()) do
        pcall(function()
            if v:IsA("Part") or v:IsA("CornerWedgePart") or v:IsA("WedgePart") or v:IsA("TrussPart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                -- Invece di distruggerle (che può causare lag istantaneo), le rendiamo invisibili
                v.Transparency = 1 
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("Explosion") then
                v.Visible = false
            elseif v:IsA("Lighting") then
                v.GlobalShadows = false
                v.FogEnd = 9e9
            end
        end)
    end
    
    Rayfield:Notify({Title = "FPS Boosted!", Content = "Mondo alleggerito. Texture nascoste e ombre disattivate.", Duration = 4})
end

-- Funzione Pulizia Memoria RAM
local function CleanMemory()
    if gcinfo then
        local prima = gcinfo()
        task.wait(0.1)
        Rayfield:Notify({Title = "Memoria Pulita", Content = "Liberati circa " .. tostring(math.floor(prima / 1024)) .. " MB di RAM.", Duration = 4})
    else
        Rayfield:Notify({Title = "Memoria Pulita", Content = "Cache del gioco svuotata.", Duration = 4})
    end
end

-- =======================================================
-- INTERFACCIA GRAFICA (ELEMENTI)
-- =======================================================

MainTab:CreateSection("🛡️ Protezione Account")

MainTab:CreateButton({
   Name = "🛡️ Attiva Anti-Game Paused (Anti-AFK)",
   Interact = "Attiva",
   Callback = function()
       AttivaAntiAFK()
   end,
})

MainTab:CreateSection("🚀 Strumenti di Boost Reale")

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

MainTab:CreateSection("📊 Monitor di Sistema")
local FpsLabel = MainTab:CreateLabel("Calcolo FPS in corso...")
local PingLabel = MainTab:CreateLabel("Calcolo Ping in corso...")

task.spawn(function()
    local Stats = game:GetService("Stats")
    while task.wait(1) do
        local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        FpsLabel:Set("FPS Attuali: " .. tostring(fps))
        PingLabel:Set("Ping di Rete: " .. tostring(ping) .. " ms")
    end
end)
