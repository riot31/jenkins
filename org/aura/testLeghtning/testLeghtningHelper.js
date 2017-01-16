({
	getImages : function(component) {
		var action = component.get("c.getImages");
        action.setCallback(this, function(response) {
            component.set("v.images", response.getReturnValue());
        })
        $A.enqueueAction(action);
	}
})