# Small script that triggers TextMate to re-read the files from the HDD
# and update it's buffers accordingly. I've made this script so I can call
# if from javascript using the TextMate object. See scalariform.js

`osascript &>/dev/null \
   -e 'tell app "SystemUIServer" to activate'; \
 osascript &>/dev/null \
   -e 'tell app "TextMate" to activate' &`