local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local HttpService = game:GetService("HttpService")

local SERVER_URL = "http://192.168.1.233:5000/verifica"

local Window = Rayfield:CreateWindow({
   Name = "Mattia Hub - Bootloader",
   LoadingTitle = "Ottimizzazione Sistema...",
   LoadingSubtitle = "Seleziona il metodo di accesso",
   ConfigurationSaving = { Enabled = false }
})

local LoginTab = Window:CreateTab("Accesso Standard", 4483362458)
local StaffTab = Window:CreateTab("Accesso AOT", 4483362458)

local chiaveInserita = ""

LoginTab:CreateInput({
   Name = "Inserisci la Chiave",
   PlaceholderText = "Incolla qui la chiave...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       chiaveInserita = Text
   end,
})

LoginTab:CreateButton({
   Name = "Check Key",
   Interact = "Verifica",
   Callback = function()
       if chiaveInserita == "" then return end
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
               Rayfield:Destroy()
               loadstring(game:HttpGet("https://raw.githubusercontent.com/Mattia-Lab-Sufo/CheatV1.1/refs/heads/main/cheat.lua"))()
           else
               Rayfield:Notify({Title = "Errore", Content = "Key non valida!", Duration = 3})
           end
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

local usernameInserito = ""
local passwordInserita = ""

StaffTab:CreateInput({
   Name = "Username",
   PlaceholderText = "Scrivi qui...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       usernameInserito = string.gsub(Text, "%s+", "")
   end,
})

StaffTab:CreateInput({
   Name = "Password",
   PlaceholderText = "Scrivi qui...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       passwordInserita = string.gsub(Text, "%s+", "")
   end,
})

StaffTab:CreateButton({
   Name = "Login AOT",
   Interact = "Accedi",
   Callback = function()
       local loginValido = false
       
       if usernameInserito == "Lattejr" and passwordInserita == "Mattia123456" then
           loginValido = true
       elseif usernameInserito == "Silent" and passwordInserita == "Silent123456" then
           loginValido = true
       end

       if loginValido then
           Rayfield:Destroy()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/Mattia-Lab-Sufo/CheatV1.1/refs/heads/main/cheat.lua"))()
       else
           Rayfield:Notify({Title = "Errore", Content = "Credenziali errate!", Duration = 3})
       end
   end,
})
