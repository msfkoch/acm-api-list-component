({
    helperMethod: function() {},
    getIcon: function(api) {
        const index = window.location.pathname.indexOf("/s/");
        
        const path =
            index > 0 && window.location.hostname.indexOf(".livepreview.") <= 0
                ? window.location.pathname.substring(0, index)
                : "";

        const url =
            api && api.icon
                ? path + "/s/sfsites/c/sfc/servlet.shepherd/document/download/" + api.icon
                : "https://cdn.anypoint.mulesoft.com/artifacts/exchange-ui/images/API-icon.png";

        return url;
    },
    hasLearnMore: function(api) {
        const result = api.navigateUrl && api.navigateUrl !== "";
        return result;
    }
});