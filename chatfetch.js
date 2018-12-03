//very simple twitch bot that prints all messages to the channel
//botnamedassembly
const tmi = require("tmi.js");

// Define configuration options:
let opts = {
  identity: {
    username: "botnamedassembly",
    password: "oauth:" + "qe6ayh4c1bkh8ezxcyqdwdal0gumrr"
  },
  channels: ["#botnamedassembly"]
};

// Create a client with our options:
let client = new tmi.client(opts);

// Register our event handlers (defined below):
client.on("message", onMessageHandler);

// Connect to Twitch:
client.connect();

// Called every time a message comes in:
function onMessageHandler(target, context, msg, self) {
  //if a message doesn't start with an exclamation point, print it to the console
  if (msg.substr(0, 1) !== commandPrefix) {
    console.log(`${msg}`);
    return;
  }
}
