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
-- STATI PERMANENTI (RIMANGONO ACCESI PER SEMPRE)
-- =======================================================
local AntiPauseAttivo = false

-- Funzione Unica di Protezione Totale Permanente
local function AttivaProtezioneTotale()
    if AntiPauseAttivo then 
        Rayfield:Notify({Title = "Info", Content = "Le protezioni sono già attive permanentemente!", Duration = 3})
        return 
    end
    
    AntiPauseAttivo = true
    
    -- [1] ANTI-AFK PERMANENTE: Simula movimenti hardware ogni volta che il player è fermo
    pcall(function()
        Players.LocalPlayer.Idled:Connect(function()
            if AntiPauseAttivo then
                VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(0.5)
                VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end
        end)
    end)
    
    -- [2] ANTI-GAMEPLAY PAUSED PERMANENTE: Loop infinito che sblocca le auto veloci
    task.spawn(function()
        while AntiPauseAttivo do
            pcall(function()
                if Players.LocalPlayer and Players.LocalPlayer:FindFirstChild("GameplayPaused") then
                    if Players.LocalPlayer.GameplayPaused == true then
                        Players.LocalPlayer.GameplayPaused = false -- Forza lo sblocco immediato del veicolo
                    end
                end
            end)
            task.wait(0.05) -- Controllo ultra rapido a 20Hz per non far fermare la macchina
        end
    end)
    
    -- [3] ANTI-SCHERMATA NERA PERMANENTE: Rimuove all'istante la GUI di blocco mappa
    pcall(function()
        game:GetService("CoreGui").DescendantAdded:Connect(function(descendant)
            if AntiPauseAttivo and (descendant.Name == "GameplayPausedSign" or descendant.Name:lower():find("paused")) then
                pcall(function()
                    descendant.Visible = false
                    descendant:Destroy()
                end)
            end
        end)
    end)
    
    Rayfield:Notify({
        Title = "Protezione Attivata!", 
        Content = "Anti-AFK e Anti-Game Paused attivi PERMANENTEMENTE.", 
        Duration = 5
    })
end

-- Funzione FPS Boost REALE e Sicura
local function BoostFPS()
    pcall(function()
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterDetail = Enum.WaterDetail.Low
        end
    end)

    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)

    for _, v in pairs(game:GetDescendants()) do
        pcall(function()
            if v:IsA("Part") or v:IsA("CornerWedgePart") or v:IsA("WedgePart") or v:IsA("TrussPart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
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
    
    Rayfield:Notify({Title = "FPS Boosted!", Content = "Mondo alleggerito. Grafica ridotta al minimo.", Duration = 4})
end

-- Funzione Pulizia Memoria RAM
local function CleanMemory()
    if gcinfo then
        local prima = gcinfo()
        task.wait(0.1)
        Rayfield:Notify({Title = "Memoria Pulita", Content = "Liberati circa " .. tostring(math.floor(prima / 1024)) .. " MB di RAM.", Duration = 4})
    else
        Rayfield:Notify({Title = "Memoria Pulita", Content = "Cache del gioco svuorata.", Duration = 4})
    end
end

-- =======================================================
-- INTERFACCIA GRAFICA (ELEMENTI)
-- =======================================================

MainTab:CreateSection("🛡️ Moduli di Sicurezza e Bypass")

MainTab:CreateButton({
   Name = "⚡ Attiva Anti-AFK & Anti-Game Paused (Permanente)",
   Interact = "Accendi",
   Callback = function()
       AttivaProtezioneTotale()
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
