global class DataTableWrapper {

  public Integer counter { get; set; }
  public Appointment__c item { get; set;}

  global DataTableWrapper(Appointment__c item, Integer counter) {
    this.item = item;
    this.counter = counter;
  }

}