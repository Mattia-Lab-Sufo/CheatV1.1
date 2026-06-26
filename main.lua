local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Mattia Hub",
   LoadingTitle = "Controllo Licenza...",
   LoadingSubtitle = "by Mattia",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = "MattiaHubConfig"
   },
   
   -- 🔴 QUI ATTIVI IL SISTEMA DI LOGIN CON CHIAVE
   KeySystem = true, 
   KeySettings = {
      Title = "Sistema di Accesso",
      Subtitle = "Inserisci la chiave generata",
      Note = "Usa il programma Python per generare la chiave valida.",
      FileName = "ChiaveSegreta", 
      SaveKey = false, -- Se metti true, memorizza la chiave sul dispositivo dell'utente per i login successivi
      
      -- Se imposti questo su TRUE, Rayfield prenderà le chiavi direttamente dal link RAW inserito sotto
      GrabKeyFromSite = true, 
      
      -- Inserisci qui il link RAW del file (es. su GitHub) dove Python caricherà le chiavi valide
      Key = {"https://raw.githubusercontent.com/TuoAccount/TuoRepo/main/chiavi_valide.txt"} 
   }
})

-- Il resto della tua Tab e dei pulsanti apparirà SOLO se la chiave inserita è corretta
local Tab = Window:CreateTab("Principale", 4483362458)

Tab:CreateButton({
   Name = "Pulsante Estetico",
   Interact = "Clicca",
   Callback = function()
       print("Il menu funziona perché la chiave è corretta!")
   end,
})
