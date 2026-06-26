-- 1. Caricamento della libreria Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 2. Creazione della finestra principale
local Window = Rayfield:CreateWindow({
   Name = "Mattia Hub",
   LoadingTitle = "Caricamento Interfaccia...",
   LoadingSubtitle = "by Mattia",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = "MattiaHubConfig"
   }
})

-- 3. Creazione di una Tab (Scheda) nel menu
local Tab = Window:CreateTab("Principale", 4483362458) -- Il numero è l'ID di un'icona

Tab:CreateSlider({
   Name = "Modifica Velocità",
   Min = 16,         -- Il valore minimo (16 è la velocità normale)
   Max = 300,        -- Il valore massimo
   CurrentValue = 16, -- Il valore di partenza (DEVE essere compreso tra Min e Max)
   Flag = "Slider1", -- Un nome unico per questo slider
   Callback = function(Value)
       -- Qui va il codice che si attiva quando lo muovi
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
           game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
       end
   end,
})

-- 5. Elemento: Toggle per il NoClip
local NoclipLoop
Tab:CreateToggle({
   Name = "NoClip (Muri)",
   CurrentValue = false,
   Flag = "ToggleNoclip",
   Callback = function(Value)
      if Value then
          -- Attiva il ciclo continuo per disabilitare le collisioni
          NoclipLoop = game:GetService("RunService").Stepped:Connect(function()
              if game.Players.LocalPlayer.Character then
                  for _, parte in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                      if parte:IsA("BasePart") then
                          parte.CanCollide = false
                      end
                  end
              end
          end)
      else
          -- Disattiva il ciclo e ripristina la fisica normale
          if NoclipLoop then NoclipLoop:Disconnect() end
          if game.Players.LocalPlayer.Character then
              for _, parte in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                  if parte:IsA("BasePart") then
                      parte.CanCollide = true
                  end
              end
          end
      end
   end,
})

-- Notifica visiva che lo script è pronto
Rayfield:Notify({
   Title = "Hub Caricato!",
   Content = "Benvenuto nel tuo menu grafico.",
   Duration = 5,
   Image = 4483362458,
})
