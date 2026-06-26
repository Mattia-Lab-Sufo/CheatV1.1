local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- =======================================================
-- GENERATORE CHIAVI MATEMATICO (Fascia di 8 ore)
-- =======================================================
local fascia_oraria = math.floor(os.time() / 28800)
local CHIAVE_CORRETTA = "MattiaHub_" .. tostring(fascia_oraria * 3)

-- ⚠️ Sostituisci questo link con il tuo link di Lootlabs o Linkvertise
local LINK_GET_KEY = "https://lootlabs.com/your-link-here" 

local Window = Rayfield:CreateWindow({
   Name = "Mattia Hub | Sistema di Accesso",
   LoadingTitle = "Verifica Licenza...",
   LoadingSubtitle = "Stile Delta System",
   ConfigurationSaving = { Enabled = false }
})

-- =======================================================
-- TAB 1: UTENTI STANDARD (CHIAVE 8 ORE)
-- =======================================================
local LoginTab = Window:CreateTab("Verifica Chiave", 4483362458)

LoginTab:CreateSection("Inserisci la chiave valida per 8 ore")

local InputKey = ""
LoginTab:CreateInput({
   Name = "Chiave di Accesso",
   PlaceholderText = "Incolla la chiave qui...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       InputKey = Text
   end,
})

LoginTab:CreateButton({
   Name = "🔑 Verifica Chiave",
   Interact = "Controlla",
   Callback = function()
       if InputKey == CHIAVE_CORRETTA then
           Rayfield:Notify({Title = "Accesso Approvato!", Content = "Chiave valida. Caricamento ottimizzatore...", Duration = 3})
           task.wait(1)
           Window:Destroy()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/Mattia-Lab-Sufo/CheatV1.1/refs/heads/main/cheat.lua"))()
       else
           Rayfield:Notify({Title = "Errore", Content = "Chiave errata o scaduta! Prendi quella nuova.", Duration = 3})
       end
   end,
})

LoginTab:CreateButton({
   Name = "🌐 Ottieni Chiave (Get Key)",
   Interact = "Copia Link",
   Callback = function()
       setclipboard(LINK_GET_KEY)
       Rayfield:Notify({Title = "Link Copiato!", Content = "Il link per sbloccare la chiave è stato copiato negli appunti.", Duration = 5})
   end,
})

-- =======================================================
-- TAB 2: ACCESSO STAFF (AOT) - CON USERNAME E PASSWORD
-- =======================================================
local StaffTab = Window:CreateTab("Accesso Staff (AOT)", 4483362458)

StaffTab:CreateSection("Autenticazione Amministratori")

local InputUser = ""
StaffTab:CreateInput({
   Name = "Username Staff",
   PlaceholderText = "Inserisci il tuo Username...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       InputUser = Text
   end,
})

local InputPass = ""
StaffTab:CreateInput({
   Name = "Password Staff",
   PlaceholderText = "Inserisci la tua Password...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       InputPass = Text
   end,
})

StaffTab:CreateButton({
   Name = "🛡️ Login Amministratore",
   Interact = "Accedi",
   Callback = function()
       -- Controllo credenziali incrociato (Username + Password)
       if (InputUser == "Lattejr" and InputPass == "Aot") or (InputUser == "Silent" and InputPass == "Aot") then
           Rayfield:Notify({Title = "Accesso Staff Approvato!", Content = "Bentornato Amministratore. Dirottamento in corso...", Duration = 3})
           task.wait(1)
           Window:Destroy()
           -- Carica direttamente il vero cheat.lua bypassando la chiave standard
           loadstring(game:HttpGet("https://raw.githubusercontent.com/Mattia-Lab-Sufo/CheatV1.1/refs/heads/main/cheat.lua"))()
       else
           Rayfield:Notify({Title = "⚠️ Accesso Negato", Content = "Username o Password AOT non validi.", Duration = 3})
       end
   end,
})
