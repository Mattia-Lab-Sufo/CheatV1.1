local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local HttpService = game:GetService("HttpService")

local SERVER_URL = "http://192.168.1.233:5000/verifica"

-- Creiamo la finestra PRINCIPALE (senza il KeySystem bloccante di Rayfield)
local Window = Rayfield:CreateWindow({
   Name = "Mattia Hub - Login System",
   LoadingTitle = "Inizializzazione...",
   LoadingSubtitle = "Benvenuto",
   ConfigurationSaving = { Enabled = false }
})

-- ==========================================
-- SCHERMATA DI LOGIN / ACCESSO
-- ==========================================
local LoginTab = Window:CreateTab("Accesso", 4483362458)

-- Variabile di stato per memorizzare la chiave inserita dall'utente
local chiaveInserita = ""

-- 1. TASTO AOT: Mostra una notifica o inserisce automaticamente le credenziali richieste
LoginTab:CreateButton({
   Name = "AOT (Accedi con Credenziali)",
   Interact = "Premi",
   Callback = function()
       -- Qui simuliamo il controllo o mostriamo le credenziali richieste
       Rayfield:Notify({
          Title = "Credenziali AOT Required",
          Content = "Email: mattianglano30@gmail.com\nPassword: mattia192837",
          Duration = 10
       })
   end,
})

-- 2. CAMPO DI TESTO PER INSERIRE LA CHIAVE
LoginTab:CreateInput({
   Name = "Inserisci la Chiave",
   PlaceholderText = "Incolla la chiave qui...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       chiaveInserita = Text
   end,
})

-- 3. TASTO: CHECK KEY (Verifica se la chiave è giusta tramite il server Python)
LoginTab:CreateButton({
   Name = "Check Key",
   Interact = "Verifica",
   Callback = function()
       if chiaveInserita == "" then
           Rayfield:Notify({Title = "Attenzione", Content = "Inserisci prima una chiave nel campo di testo!", Duration = 3})
           return
       end

       -- Richiesta HTTP al tuo server Flask
       local requestFunc = syn and syn.request or http and http.request or http_request or request
       if not requestFunc then
           Rayfield:Notify({Title = "Errore", Content = "Executor non supportato.", Duration = 3})
           return
       end

       local data = { ["key"] = chiaveInserita }
       local jsonData = HttpService:JSONEncode(data)

       local success, response = pcall(function()
           return requestFunc({
               Url = SERVER_URL,
               Method = "POST",
               Headers = { ["Content-Type"] = "application/json" },
               Body = jsonData
           })
       end)

       if success and response.StatusCode == 200 then
           local responseData = HttpService:JSONDecode(response.Body)
           if responseData and responseData.valid == true then
               Rayfield:Notify({Title = "Successo", Content = "Chiave Valida! Sblocco dei cheat...", Duration = 3})
               
               -- 🌟 CAMBIO SCHERMATA: Creiamo la Tab dei Cheat dinamicamente solo ora!
               local CheatTab = Window:CreateTab("Cheat Attivi", 4483362458)
               CheatTab:CreateButton({
                  Name = "Pulsante Cheat 1 (Sbloccato)",
                  Interact = "Attiva",
                  Callback = function() print("Cheat eseguito!") end,
               })
           else
               Rayfield:Notify({Title = "Errore", Content = "Key non valida!", Duration = 3})
           end
       else
           Rayfield:Notify({Title = "Errore Server", Content = "Impossibile contattare il server Python.", Duration = 3})
       end
   end,
})

-- 4. TASTO: GET KEY
LoginTab:CreateButton({
   Name = "Get Key (Ottieni Chiave)",
   Interact = "Apri Link",
   Callback = function()
       -- Copia il link negli appunti dell'utente o mostra dove prenderla
       setclipboard("http://127.0.0.1:5000/genera")
       Rayfield:Notify({Title = "Link Copiato", Content = "Il link per generare la chiave è stato copiato negli appunti!", Duration = 3})
   end,
})

-- 5. TASTO: ASSISTENZA
LoginTab:CreateButton({
   Name = "Assistenza",
   Interact = "Aiuto",
   Callback = function()
       Rayfield:Notify({Title = "Supporto", Content = "Contatta l'amministratore per problemi con le chiavi.", Duration = 5})
   end,
})
