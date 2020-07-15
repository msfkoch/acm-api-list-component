({
    doInit: function(component, event, helper) {
        const api = component.get("v.api");
        if (api) {
            component.set("v.apiJson", JSON.stringify(api, null, 2));
            component.set("v.iconUrl", helper.getIcon(api));

            api.navigateToRecord = $A.getCallback(function(filterParams) {
                const sObjectEvent = $A.get("e.force:navigateToSObject");
                sObjectEvent.setParams({
                    recordId: api.id,
                    slideDevName: "detail"
                });
                sObjectEvent.fire();
            });
        }
    },
    openRecord: function(component, event, helper) {
        const api = component.get("v.api");
        console.log('api', api.navigateToRecord)
        if (api.navigateToRecord) {
            api.navigateToRecord();
        }
    }
});