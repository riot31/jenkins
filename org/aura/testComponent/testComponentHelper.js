({
	test : function(component) {
		console.log("helper");
        var action = component.get("c.getTest");
        action.setCallback(this, function(response) {
            component.set("v.test", response.getReturnValue());
        })
        console.log("helper2");
	}
})