import { Controller } from "@hotwired/stimulus"
import { useClickOutside } from 'stimulus-use'
import Dom from '../dom/manipulator'

export default class extends Controller {
  static targets = ['button', 'dropdown']

  connect() {
    useClickOutside(this)
  }

  toggleMenu(event) {
    event.preventDefault()
    Dom.toggleClass(this.dropdownTarget, 'show')
  }

  clickOutside(event) {
    event.preventDefault()
    Dom.removeClass(this.dropdownTarget, 'show')
  }
}