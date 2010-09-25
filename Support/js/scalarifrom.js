/**
    BUNDLE_PATH and CURRENT_PATH are exposed by Scalariform.rb
*/

function update(){
    
    var rescanRubyScript = BUNDLE_PATH + "/lib/rescan_project.rb",
        cmd = 'cat ~/.difffile.scala > ' + CURRENT_PATH + " && ruby " + rescanRubyScript,
        myCommand = TextMate.system(cmd);
    
    myCommand.onreadoutput = function(str) { console.log("read: " + str); };
    myCommand.onreaderror = function(str) { console.log("error: " + str); };
    
    $('.header').html("<h1>Awesome, <br />Close this window and you should find your file nicely formatted</h1>");
    $('.content').html("");
}

function cancel(){
    window.close();
}

$(document).ready(function(){
    
    $('#accept').bind('click',function(){
        update();
    });
    
    $('#cancel').bind('click',function(){
        cancel();
    });
    
    $(document).bind('keydown',function(e){

        var key = e.which || e.charCode || e.keyCode || 0,
            ENTER = 13,
            ESC = 27;
        
        switch(key){
            case ENTER:
                update();
                return false;
                break;
            case ESC:
                cancel();
                return false;
            default:
                /* do nothing */
        }    
    });
});