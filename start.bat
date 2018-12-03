::batch file to start the project on windows
::requires node ~8 installed
::requires the npm package tmi.js (available by calling npm install tmi.js)
node chatfetch.js | java -jar mars.jar main.asm

::starts a node script watching for messages to the twitch channel
::botnamedassembly, then passes the messages to main.asm running in cli mode
