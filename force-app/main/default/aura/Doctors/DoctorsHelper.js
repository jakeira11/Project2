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
        
    },

    loadAppList : function(component) {
        var getAppList =  component.get("c.getAppList");

        getAppList.setParams({
            docId : component.get("v.docId")
        })

        getAppList.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                component.set("v.appList",response.getReturnValue());
            }
        });

        $A.enqueueAction(getAppList);
        
    }
})
