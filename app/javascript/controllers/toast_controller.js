import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { notice: String, alert: String }

  connect() {
    this.flast_toast()
  }

  flast_toast() {
    if (this.noticeValue.length > 0)
      toastr.success(this.noticeValue)
    else if (this.alertValue.length > 0)
      toastr.error(this.alertValue)

  }
}