({
    loadDoc : function(component) {
        var getDoc =  component.get("c.getDoc");

        getDoc.setParams({
            docId : component.get("v.docId")
        })

        getDoc.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                component.set("v.doc",response.getReturnValue());
            }
        });

        $A.enqueueAction(getDoc);
        
    }
})
