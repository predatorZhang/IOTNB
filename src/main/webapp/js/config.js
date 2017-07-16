var config = function() {

    var baseServiceUrl = "http://192.168.0.102:8099/baseService";

    return {
        getBaseServiceUrl : function() {
            return baseServiceUrl;
        }
    }
} ();