import { Controller } from "@hotwired/stimulus"
import Dom from '../dom/manipulator'

export default class extends Controller {
  connect() {
    this.openModal()
  }

  openModal() {    
    Dom.openModal(this.element, 'show')
  }

  hideModal() {
    Dom.hideModal(this.element, 'hide')
  }
}