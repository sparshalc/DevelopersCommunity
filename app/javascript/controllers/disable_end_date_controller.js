import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Connected!")
  }
  initialize() {
    this.element.setAttribute('data-action', 'click->disable-end-date#disableEndDate')
  }
  disableEndDate(){
    const EndDate = document.getElementById('work_experience_end_date')
    if(this.element.checked){
      EndDate.setAttribute("disabled", true)
      EndDate.value = null;
    }else
    EndDate.removeAttribute("disabled")
    end
  }
}
