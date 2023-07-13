import { Controller } from "@hotwired/stimulus"
import Dom from '../dom/manipulator'

export default class extends Controller {
  static targets = ['tab', 'pane']

  switchTab(event) {
    event.preventDefault()
    this.resetTabs()
    const selectedTab = event.currentTarget
    const selectedPane = this.paneTargets.find(element => element.id === selectedTab.id)
    Dom.addClass(selectedTab, 'active')
    Dom.addClass(selectedPane, 'active')
    Dom.addClass(selectedPane, 'show')
  }

  resetTabs () {
    this.tabTargets.map(x => x.classList.remove('active'))
    this.paneTargets.map(x => {
      Dom.removeClass(x, "show")
      Dom.removeClass(x, "active")
    })
  }
}