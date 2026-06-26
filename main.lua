local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local HttpService = game:GetService("HttpService")

-- Assicurati che l'IP sia sempre quello corretto del tuo PC
local SERVER_URL = "http://127.0.0.1:5000/verifica"

local Window = Rayfield:CreateWindow({
   Name = "Mattia Hub - Bootloader",
   LoadingTitle = "Ottimizzazione Sistema...",
   LoadingSubtitle = "In attesa delle credenziali",
   ConfigurationSaving = { Enabled = false }
})

local LoginTab = Window:CreateTab("Accesso", 4483362458)
local chiaveInserita = ""

-- Tasto AOT Credenziali
LoginTab:CreateButton({
   Name = "AOT (Mostra Credenziali)",
   Interact = "Vedi",
   Callback = function()
       Rayfield:Notify({
          Title = "Credenziali",
          Content = "Email: mattianglano30@gmail.com\nPassword: mattia192837",
          Duration = 5
       })
   end,
})

-- Input Chiave
LoginTab:CreateInput({
   Name = "Inserisci la Chiave",
   PlaceholderText = "Incolla qui...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       chiaveInserita = Text
   end,
})

-- Tasto Check Key (Verifica e chiama cheat.lua)
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
               
               Rayfield:Notify({Title = "Sbloccato", Content = "Caricamento ottimizzatore...", Duration = 2})
               task.wait(1)
               
               -- 🧠 1. Chiude e pulisce il Login dalla memoria
               Rayfield:Destroy()
               Rayfield = nil
               Window = nil
               
               -- 🧠 2. Carica il file cheat.lua dal tuo repository
               loadstring(game:HttpGet("https://raw.githubusercontent.com/Mattia-Lab-Sufo/CheatV1.1/refs/heads/main/cheat.lua"))()
               
           else
               Rayfield:Notify({Title = "Errore", Content = "Key non valida!", Duration = 3})
           end
       else
           Rayfield:Notify({Title = "Errore Server", Content = "Server Python non raggiungibile.", Duration = 3})
       end
   end,
})

-- Tasti Get Key e Assistenza
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
