local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local HttpService = game:GetService("HttpService")

-- 🔴 Aggiornato con l'indirizzo Localhost (127.0.0.1)
local SERVER_URL = "http://127.0.0.1:5000/verifica"

local Window = Rayfield:CreateWindow({
   Name = "Mattia Hub - Bootloader",
   LoadingTitle = "Ottimizzazione Sistema...",
   LoadingSubtitle = "Seleziona il metodo di accesso",
   ConfigurationSaving = { Enabled = false }
})

-- Le due sezioni: Utenti normali e Staff
local LoginTab = Window:CreateTab("Accesso Standard", 4483362458)
local StaffTab = Window:CreateTab("Accesso AOT", 4483362458)

-- =======================================================
-- METODO 1: ACCESSO STANDARD CON CHIAVE PYTHON
-- =======================================================
local chiaveInserita = ""

LoginTab:CreateInput({
   Name = "Inserisci la Chiave",
   PlaceholderText = "Incolla qui la chiave del server...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       chiaveInserita = Text
   end,
})

LoginTab:CreateButton({
   Name = "Check Key",
   Interact = "Verifica",
   Callback = function()
       if chiaveInserita == "" then
           Rayfield:Notify({Title = "Attenzione", Content = "Inserisci una chiave!", Duration = 3})
           return
       end

       local requestFunc = syn and syn.request or http and http.request or http_request or request
       if not requestFunc then return end

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
               Rayfield:Notify({Title = "Sbloccato", Content = "Accesso Utente Autorizzato. Caricamento...", Duration = 2})
               task.wait(1)
               Rayfield:Destroy()
               loadstring(game:HttpGet("https://raw.githubusercontent.com/Mattia-Lab-Sufo/CheatV1.1/refs/heads/main/cheat.lua"))()
           else
               Rayfield:Notify({Title = "Errore", Content = "Key non valida!", Duration = 3})
           end
       else
           Rayfield:Notify({Title = "Errore Server", Content = "Server Python non raggiungibile su localhost.", Duration = 3})
       end
   end,
})

LoginTab:CreateButton({
   Name = "Get Key",
   Interact = "Copia",
   Callback = function()
       setclipboard("http://127.0.0.1:5000/genera")
       Rayfield:Notify({Title = "Copiato", Content = "Link negli appunti!", Duration = 2})
   end,
})

LoginTab:CreateButton({
   Name = "Assistenza",
   Interact = "Aiuto",
   Callback = function()
       Rayfield:Notify({Title = "Assistenza", Content = "Contatta l'admin se riscontri bug.", Duration = 4})
   end,
})

-- =======================================================
-- METODO 2: PANNELLO SEGRETO AOT (Admin o Tester)
-- =======================================================
local emailInserita = ""
local passwordInserita = ""

StaffTab:CreateInput({
   Name = "Email",
   PlaceholderText = "Inserisci la tua email...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       emailInserita = Text
   end,
})

StaffTab:CreateInput({
   Name = "Password",
   PlaceholderText = "Inserisci la tua password...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       passwordInserita = Text
   end,
})

StaffTab:CreateButton({
   Name = "Login AOT",
   Interact = "Accedi",
   Callback = function()
       if emailInserita == "mattianglano30@gmail.com" and passwordInserita == "mattia192837" then
           Rayfield:Notify({Title = "Benvenuto", Content = "Credenziali corrette. Sblocco in corso...", Duration = 3})
           task.wait(1)
           
           Rayfield:Destroy()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/Mattia-Lab-Sufo/CheatV1.1/refs/heads/main/cheat.lua"))()
       else
           Rayfield:Notify({Title = "Errore", Content = "Credenziali AOT errate o non autorizzate!", Duration = 3})
       end
   end,
})
