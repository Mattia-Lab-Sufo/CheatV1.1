local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Mattia Hub - Menu Ottimizzatore",
   LoadingTitle = "Ottimizzazione Grafica...",
   LoadingSubtitle = "Sistema Sbloccato con Successo",
   ConfigurationSaving = { Enabled = true, FolderName = "MattiaOptimizer" }
})

-- TAB 1: OTTIMIZZAZIONE E RIMOZIONE LAG
local OptiTab = Window:CreateTab("Ottimizzazione FPS", 4483362458)

OptiTab:CreateButton({
   Name = "Attiva Boost FPS (Rimuovi Lag)",
   Interact = "Migliora",
   Callback = function()
       -- Codice di pulizia grafica per aumentare gli FPS
       local terrain = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
       if terrain then
           terrain.WaterWaveSize = 0
           terrain.WaterWaveSpeed = 0
           terrain.WaterReflectance = 0
           terrain.WaterDetailSize = 0
       end
       
       game:GetService("Lighting").GlobalShadows = false
       
       for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
           if v:IsA("Part") or v:IsA("CornerWedgePart") or v:IsA("WedgePart") or v:IsA("TrussPart") then
               v.Material = Enum.Material.SmoothPlastic
               v.Reflectance = 0
           end
       end
       
       Rayfield:Notify({Title = "Sistema Ottimizzato", Content = "Dettagli pesanti rimossi!", Duration = 4})
   end,
})

-- TAB 2: SEZIONE TRUCCHI ESTETICI
local CheatTab = Window:CreateTab("Trucchi", 4483362458)

CheatTab:CreateButton({
   Name = "Pulsante Estetico 1",
   Interact = "Esegui",
   Callback = function()
       print("Azione cheat eseguita")
   end,
})
