#start script for this project on linux
#requires node ~8
#requires tmi.js, available on npm (npm install in this directory or
#npm install tmi.js)
node chatfetch.js | java -jar mars.jar main.asm

#starts a node server watching for messages to the twitch chat of
#botnamedassembly, passing the messages in that chat to main.asm running in
#the mars cli
