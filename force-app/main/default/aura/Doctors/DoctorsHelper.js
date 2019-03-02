({
    loadDoc : function(component) {
        var getDoc =  component.get("c.getDoc");

        getDoc.setParams({
            docId : component.get("v.docId")
        })

        getDoc.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                //Set Doctor attribute in the View
                component.set("v.doc",response.getReturnValue());

                //Set Languages attribute in the View with semicolons replaced with commas and spaces
                var lang = component.get("v.doc.Languages__c");
                component.set("v.languages",lang.replace(/;/g,', '));

                //Set Specializations attribute in the View with semicolons replaced with commas and spaces
                var spec = component.get("v.doc.Specialization__c");
                component.set("v.specs",spec.replace(/;/g,', '));
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
