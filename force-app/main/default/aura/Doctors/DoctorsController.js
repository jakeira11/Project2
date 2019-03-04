({
    // Called from View: Doctors.cmp
    // component: Doctors.cmp
    // event: init
    // helper: DoctorsHelper.js
    doInit : function(component, event, helper) {
        helper.loadDoc(component);
        helper.loadAppList(component);
    }
})