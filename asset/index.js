define([], function () {
    var appendParam = function(url,param){
        var arr=[];
        for(var k in param){
            arr.push(k+'='+param[k]);
        }
        return url + (url.indexOf('?')>-1?'&':'?') + arr.join('&')
    }
    return {

        init: function ($mod) {
            $mod.on('click', '.J_op', function (e) {
                var tar = e.target;
                var status = tar.getAttribute('data-status'),
                    param={
                        _id:tar.getAttribute('data-id')
                    }
                switch (status - 0) {
                    case 0://去支付
                        location.href = appendParam($mod.attr('data-payurl'),param)
                        break
                    case 2://确认收货
                        location.href = appendParam($mod.attr('data-confirmurl'),param)
                        break
                }
            })
        }
    }
})
