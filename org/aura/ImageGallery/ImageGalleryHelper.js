({
	getImages : function(component) {
		var action = component.get("c.getImages");
        action.setCallback(this, function(response) {
            component.set("v.images", response.getReturnValue());
        })
        $A.enqueueAction(action);
	},
    searchImages : function(component) {
		var action = component.get("c.getImages");
        var searchValue = component.find("textsearch").get("v.value");
        action.setParams({
            "criteria": $A.util.json.encode(searchValue) 
        });
        action.setCallback(this, function(response) {
            component.set("v.images", response.getReturnValue());
        })
        $A.enqueueAction(action);
	}
})