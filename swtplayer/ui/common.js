 function showarea(areaname)
{
	window.location.href="mapurl://www.tvswt.com/"+areaname;
}

function gohome()
{
   
   window.location.href="mapurl://www.tvswt.com/gohome";	
}



/*

(function(global){
    var notifyInvoke = function(method, args){
        if (global.callbacks[method] && typeof global.callbacks[method] == 'function') {
            global.callbacks[method].apply(global, args);
        } else {
            throw new Error('未实现');
        }
    };
    
    global.iosNotify = notifyInvoke;
    global.callbacks = {};
    
   //注册一个方法
    global.callbacks["methodIdentifier"] = function(){
       //实现异步方法
    };
})(window);

*/