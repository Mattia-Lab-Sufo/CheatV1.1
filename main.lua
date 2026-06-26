local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local HttpService = game:GetService("HttpService")

-- Assicurati che l'IP sia esattamente quello del tuo PC
local SERVER_URL = "http://127.0.0.1:5000/verifica"

-- Funzione universale per gli executor per fare richieste HTTP POST
local function inviaRichiestaServer(chiave)
    local requestFunc = syn and syn.request or http and http.request or http_request or request
    
    if not requestFunc then
        return false, "Executor non supporta le richieste HTTP esterni."
    end

    local data = { ["key"] = chiave }
    local jsonData = HttpService:JSONEncode(data)

    local response = requestFunc({
        Url = SERVER_URL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = jsonData
    })

    if response and response.StatusCode == 200 then
        local responseData = HttpService:JSONDecode(response.Body)
        return responseData and responseData.valid == true
    end
    
    return false
end

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
      GrabKeyFromSite = false,
      
      Actions = {
         OnSubmit = function(Window, Key)
            local sistemaSbloccato = inviaRichiestaServer(Key)
            if sistemaSbloccato then
                return true
            else
                Rayfield:Notify({Title = "Errore", Content = "Chiave errata o scaduta!", Duration = 3})
                return false
            end
         end
      }
   }
})

-- Questo apparirà solo se la chiave è corretta
local Tab = Window:CreateTab("Principale", 4483362458)

Tab:CreateButton({
   Name = "Pulsante Estetico",
   Interact = "Clicca",
   Callback = function()
       print("Funziona!")
   end,
})
