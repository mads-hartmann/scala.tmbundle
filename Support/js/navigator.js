$(document).ready(function() {
    
    var input = $(".top input[type=search]");
    input.focus();
    
    input.bind('input',function() {
        var value = input.val();
        
        var all = $('#content ul li'),
            show = all.filter(function(index) {
                var txt = $(this).find("p").text();
                return (txt.toLowerCase().match(new RegExp("^\s*"+value.toLowerCase())) !== null);
            }),
            hide = all.not(show);

        show.show();
        $('.selected').removeClass('selected');
        show.eq(0).addClass('selected');
        hide.hide();
    });
    
    function openFile(node){
        var path = node.find('.path').text(),
            line = node.find('.line').text(),
            cmd = 'open "txmt://open?url=file://'+path+'&line='+line+'"';
            myCommand = TextMate.system(cmd);

        window.close();    
        myCommand.onreadoutput = function(str) { console.log("read: " + str); };
        myCommand.onreaderror = function(str) { console.log("error: " + str); };
    }
    
    $("li").bind('click',function(){
        var path = openFile($(this));
    });
        
    $(document).bind('keydown', function(e) {
        var key = e.which || e.charCode || e.keyCode || 0;

        // Change selection
        // -------------------------
        var that = ($('.selected').size() > 0) ? $('.selected').eq(0) : $('ul li').eq(0),
            DOWN = 40,
            UP = 38,
            TAB = 9,
            ENTER = 13,
            ESC = 27;

        switch (key) {
            case DOWN: {
                if (that.hasClass('selected')) {
                    if (that.nextAll().filter(':visible').size() > 0) {
                        that.removeClass('selected');
                        that.nextAll().filter(':visible').eq(0).addClass('selected');
                    }
                } else {
                    $('ul li').eq(0).addClass('selected');
                }
                break;
            }
            case UP: {

                if (that.prevAll().filter(':visible').size() > 0) {
                    that.removeClass('selected');
                    that.prevAll().filter(':visible').eq(0).addClass('selected');
                }
                break;
            }
            case ENTER : {
                openFile(that);
            }
            case TAB : {
                // var support = root.replace("file://","").replace(/\s/g,"\\ "),
                //     script = support + "/lib/TypeInspector.rb",
                //     path = that.find('.path').text(),
                //     line = that.find('.line').text(),
                //     name = that.find('p').text(),
                //     cmd = 'ruby '+script+' ' + support + ' '+ name;
                //     myCommand = TextMate.system(cmd);
                // $('#content').html("");
                // var output = "";
                // myCommand.onreadoutput = function(str) { 
                //     output += str;
                //     if (str.length < 4096) {
                //         $('#content').append(output);
                //     }
                // };
                // myCommand.onreaderror = function(str) { console.log("error: " + str); };
                // input.val("");
                // input.trigger('input');
                return false;
            }
            case ESC : {
                input.val("");
                input.trigger('input');
                return false;
            }
            default : {
                console.log(key);
                return true;
            }
        }

        // Now move the list up/down
        // -------------------------
        var maxOffset = $("#content").height() + $("#content").offset().top,
            minOffset = $(".top").height(),
            offsetTop = $('.selected').eq(0).offset().top,
            rowHeight = $('ul li').eq(0).height() + 20, //padding (20)
            oldOffset = (function() {
                var px = $('#content ul').css('top');
                return parseInt(px.slice(0,px.length - 2),"");
            })();

        if (offsetTop > maxOffset) {
            var newOffset = oldOffset - rowHeight;
            console.log("o:" + oldOffset);
            $('#content ul').css({
                "top": newOffset
            });
        } else if (offsetTop < minOffset) {
            var newOffset = oldOffset + rowHeight; 
            $('#content ul').css({
                "top": newOffset
            });
        }

    });
});