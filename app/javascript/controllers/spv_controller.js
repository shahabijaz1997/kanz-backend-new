import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  submit() {
    var form = document.getElementById('new_spv')
    if(form == undefined) {
      var form = document.querySelectorAll('[id^="edit_spv_"]')[0];
    }
    form.requestSubmit()
  }

  previousStep() {
    console.log("Previous Step");
  }
}
