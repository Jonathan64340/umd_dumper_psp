-- @Author: Domingues Jonathan
-- Variables 

boot = Image.load("BIN/boot.jpg")
cursor = Image.load("BIN/cursor.png")
x = 240
y = 130
      
-- Declare and format variable to get freeSpace of memory stick (Work only on PSP-1xxxx, PSP-2xxx, PSP-3xxxx, PSP-STREET)
-- Not working on PSP-GO, PS VITA

ms = System.getFreeSpace("ms0:/")
ms = ms / 1024/1024
                         
umd = UMD.getSize()
umd = umd / 1024/1024
                         
umdchck = UMD.checkDisk()
         
-- @func start -> Load APP
function start()
  dofile("APP.LUA")
end
                     
                    
                     
-- @Main func
while true do
  screen:clear()
  pad = Controls.read()
  screen:blit(0,0,boot)

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
              
  if y + cucursorrseur:height() > 272 then
    y = 272 - cursor:height()
  elseif y < 0 then
    y = 0
  end
                       
  if pad:cross() and x > 173 and x < 226 and y > 122 and y < 149 then
    System.sleep(200)
    start()
  end
                       
  if pad:cross() and x > 253 and x < 305 and y > 122 and y < 149 then
    System.Quit()
  end
                          
  screen:blit(x,y,cursor)
  screen.flip()
  screen.waitVblankStart()
end
