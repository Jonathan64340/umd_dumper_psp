-- @Author: Domingues Jonathan
-- Variables 

menu = Image.load("BIN/MENU.jpg")
cursor = Image.load("BIN/cursor.png")
x = 240
y = 130

-- Set new font type
pl = Font.load("BIN/NEUROPOL.ttf")
pl:setPixelSizes(9,9)

-- Declare and format variable to get freeSpace of memory stick (Work only on PSP-1xxxx, PSP-2xxx, PSP-3xxxx, PSP-STREET)
-- Not working on PSP-GO, PS VITA

ms = System.getFreeSpace("ms0:/")
ms = ms / 1024/1024
                         
umd = UMD.getSize()
umd = umd / 1024/1024
                         
umdchck = UMD.checkDisk()
     
-- @func verifum -> Check UMD is in optical drive
function verifumd()
  if umdchck == 1 then
    screen:fontPrint(pl,94,90,"Oui",Color.new(0,0,0))
  else
    screen:fontPrint(pl,94,90,"Non",Color.new(0,0,0))
  end
end
      
-- @func RIP -> Create an RIP on image disk into memory stick
function RIP()
  verification = UMD.checkDisk()
    if verification == 1 then
      if ms > umd then
        iso = System.startOSK("ms0:/ISO/jeu.ISO","Renommez le jeu !")
        UMD.ripISO(iso)
        System.Quit()
      else
        System.message("Espace disque insuffisant !",0)
        System.Quit()
      end
  end
end       

-- @Main func
while true do
  -- Draw render into the screen
  screen:clear()
  -- Initialize controls of PSP
  pad = Controls.read()
  -- Display the screen with custom picture
  screen:blit(0,0,menu)
  verifumd()
  
  if ms > umd and umdchck == 1 then
    screen:fontPrint(pl,97,78,"Oui",Color.new(0,0,0))
  else
    screen:fontPrint(pl,97,78,"Non",Color.new(0,0,0))
  end

  -- Display freeSpace of MS
  screen:fontPrint(pl,81,54,""..ms.." Mo",Color.new(0,0,0))

  -- Display size of UMD
  screen:fontPrint(pl,63,66,""..umd.." Mo",Color.new(0,0,0))

  if math.abs(pad:analogX()) > 32 then
    x = x + pad:analogX() / 24
  end

  if math.abs(pad:analogY()) > 32 then
    y = y + pad:analogY() / 24 
  end
           
  if x + cursor:width() > 480 then
    x = 480 - cursor:width()
  elseif x < 0 then
    x = 0
  end
                 
  if y + cursor:height() > 272 then
    y = 272 - cursor:height()
  elseif y < 0 then
    y = 0
  end
                       
  if pad:cross() and x > 173 and x < 226 and y > 122 and y < 149 then
    System.message("Développeur: Domingues Jonathan", 0)
  end
                         
  if pad:cross() and x > 253 and x < 305 and y > 122 and y < 149 then
    RIP()
  end

  if pad:cross() and x > 172 and x < 305 and y > 223 and y < 250 then
    System.message("Merci de votre visite ! A très bientot sur www.pspgen.com.",0)
    System.Quit()
  end

  if pad:cross() and x > 173 and x < 305 and y > 179 and y < 207 then
    -- Reload APP
    dofile("APP.LUA")
  end
                           
  screen:blit(x,y,cursor)
  screen.flip()
  screen.waitVblankStart()
end

