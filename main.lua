-- =======================================================
-- METODO 2: PANNELLO SEGRETO AOT (Admin o Tester)
-- =======================================================
local usernameInserito = ""
local passwordInserita = ""

StaffTab:CreateInput({
   Name = "Username",
   PlaceholderText = "Scrivi qui...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       -- Rimuove spazi vuoti accidentali
       usernameInserito = string.gsub(Text, "%s+", "")
   end,
})

StaffTab:CreateInput({
   Name = "Password",
   PlaceholderText = "Scrivi qui...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       -- Rimuove spazi vuoti accidentali
       passwordInserita = string.gsub(Text, "%s+", "")
   end,
})

StaffTab:CreateButton({
   Name = "Login AOT",
   Interact = "Accedi",
   Callback = function()
       local loginValido = false
       
       -- Controllo rigoroso dei dati senza spazi nascosti
       if usernameInserito == "Lattejr" and passwordInserita == "Mattia123456" then
           loginValido = true
       elseif usernameInserito == "Silent" and passwordInserita == "Silent123456" then
           loginValido = true
       end

       if loginValido then
           Rayfield:Notify({Title = "Benvenuto Staff", Content = "Credenziali autorizzate. Sblocco...", Duration = 3})
           task.wait(1)
           
           Rayfield:Destroy()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/Mattia-Lab-Sufo/CheatV1.1/refs/heads/main/cheat.lua"))()
       else
           -- Mostra una notifica d'errore ma ti dice anche cosa ha letto lo script in quel momento (utile per il debug)
           Rayfield:Notify({
               Title = "Errore", 
               Content = "Dati errati!\nHai inserito: ["..usernameInserito.."]", 
               Duration = 4
           })
       end
   end,
})
