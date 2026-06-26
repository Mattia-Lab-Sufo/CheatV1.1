local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local HttpService = game:GetService("HttpService")

-- Cambia questo URL con l'indirizzo pubblico del tuo server Python (es. il link di Ngrok)
local SERVER_URL = "http://IL_TUO_LINK_SERVER_QUI:5000/verifica"

local Window = Rayfield:CreateWindow({
   Name = "Mattia Hub",
   LoadingTitle = "Verifica Account...",
   LoadingSubtitle = "In connessione con il database...",
   ConfigurationSaving = { Enabled = false },
   
   KeySystem = true,
   KeySettings = {
      Title = "Database Login",
      Subtitle = "Inserisci la chiave d'accesso",
      Note = "Genera la chiave dal pannello di controllo.",
      FileName = "SessionKey",
      SaveKey = false,
      GrabKeyFromSite = false, -- 🔴 DISATTIVATO: Non usiamo più i file di testo statici
      
      -- Funzione personalizzata di Rayfield per verificare la chiave
      Actions = {
         OnSubmit = function(Window, Key)
            -- Prepariamo la richiesta da mandare al server Python
            local data = { ["key"] = Key }
            local jsonData = HttpService:JSONEncode(data)
            
            local success, response = pcall(function()
                return game:HttpPost(SERVER_URL, jsonData, "application/json")
            end)
            
            if success then
                local responseData = HttpService:JSONDecode(response)
                if responseData and responseData.valid == true then
                    -- Se il server risponde che è valida, sblocchiamo il menu
                    return true
                else
                    Rayfield:Notify({Title = "Errore", Content = "Chiave errata o scaduta!", Duration = 3})
                    return false
                end
            else
                Rayfield:Notify({Title = "Errore Server", Content = "Impossibile connettersi al database.", Duration = 3})
                return false
            end
         end
      }
   }
})

-- Questo apparirà solo se la funzione OnSubmit restituisce "true"
local Tab = Window:CreateTab("Principale", 4483362458)
