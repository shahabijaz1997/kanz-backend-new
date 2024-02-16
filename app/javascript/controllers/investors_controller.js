import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['activationLink', 'deactivationLink']

  deactivate(){
    this.deactivationLinkTarget.click()
  }

  reactivate(){
    this.activationLinkTarget.click()
  }
}
