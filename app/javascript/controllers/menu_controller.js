import { Controller } from "@hotwired/stimulus"
import Dom from '../dom/manipulator'

export default class extends Controller {
  static targets = ['button', 'dropdown']

  toggleMenu(event) {
    console.log('Toggle')
    event.preventDefault()
    Dom.toggleClass(this.dropdownTarget, 'show')
  }
}