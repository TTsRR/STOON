serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_STOON = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_STOON = function() 
local Create_Info = function(Token,Sudo,UserName)  
local STOON_Info_Sudo = io.open("sudo.lua", 'w')
STOON_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

]])
STOON_Info_Sudo:close()
end  
if not database:get(Server_STOON.."Token_STOON") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_STOON.."Token_STOON",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua run.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_STOON.."Id_STOON") then
print("\27[1;34m\n»» Send Your id Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
io.write('\n\27[1;31m»» The id Is Saved\n\27[0;39;49m')
database:set(Server_STOON.."Id_STOON",UserName)
else
io.write('\n\27[1;31mThe id was not Saved\n\27[0;39;49m')
end 
os.execute('lua run.lua')
end
local function Files_STOON_Info()
Create_Info(database:get(Server_STOON.."Token_STOON"),database:get(Server_STOON.."Id_STOON"),database:get(Server_STOON.."UserName_STOON"))   
local RunSTOON = io.open("STOON", 'w')
RunSTOON:write([[
#!/usr/bin/env bash
cd $HOME/STOON
token="]]..database:get(Server_STOON.."Token_STOON")..[["
rm -fr STOON.lua
wget "https://raw.githubusercontent.com/TTsRR/STOON/master/STOON.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./STOON.lua -p PROFILE --bot=$token
done
]])
RunSTOON:close()
local RunTs = io.open("tk", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/STOON
while(true) do
rm -fr ../.telegram-cli
screen -S STOON -X kill
screen -S STOON ./STOON
done
]])
RunTs:close()
end
Files_STOON_Info()
database:del(Server_STOON.."Token_STOON");database:del(Server_STOON.."Id_STOON");database:del(Server_STOON.."UserName_STOON")
sudos = dofile('sudo.lua')
os.execute('./ins.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_STOON()  
var = true
else   
f:close()  
database:del(Server_STOON.."Token_STOON");database:del(Server_STOON.."Id_STOON");database:del(Server_STOON.."UserName_STOON")
sudos = dofile('sudo.lua')
os.execute('./ins.sh ins')
var = false
end  
return var
end
Load_File()
