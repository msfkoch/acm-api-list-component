({
    doInit: function(component, event, helper) {
        // probably need to use Promise.all here to get the categories as well, but we can list them using the list of APIs
        // as well, so we can skip it for now        
        helper
            .serverSideCall(component, component.get("c.getApis"))
            .then(data => {
                component.set("v.apis", data);

                // we get the categories in every API so we could put everything in a map, if that makes sense
                var categories = {}
                data.flatMap(api => api.categories)
                    .map(item => ({ 'name': item.name, 'value': item.value }))
                    .forEach(c => {
                        if (categories[c.name]) {
                            categories[c.name].add(c.value)
                        }
                        else
                            categories[c.name] = new Set([c.value])
                    })

                component.set("v.categories", categories);

                // just debug stuff
                console.log('data', data)
                console.log('categories', categories)
            })
            .catch(error => {
                component.set("v.status", error);
                console.log(error);
            });
    }
})