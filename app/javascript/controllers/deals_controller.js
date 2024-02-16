import { Controller } from "@hotwired/stimulus"
import Dom from '../dom/manipulator'
export default class extends Controller {
  static targets = ['spvButton', 'dateSelector', 'dealRefundForm', 'closingForm']

  createSpv(){
    Dom.addClass(this.dateSelectorTarget, 'd-none')
    Dom.addClass(this.dealRefundFormTarget, 'd-none')
    Dom.removeClass(this.spvButtonTarget, 'd-none')
  }

  extendDate(){
    Dom.removeClass(this.dateSelectorTarget, 'd-none')
    Dom.addClass(this.spvButtonTarget, 'd-none')
    Dom.addClass(this.dealRefundFormTarget, 'd-none')
  }

  refundAndClose(){
    Dom.removeClass(this.dealRefundFormTarget, 'd-none')
    Dom.addClass(this.spvButtonTarget, 'd-none')
    Dom.addClass(this.dateSelectorTarget, 'd-none')
  }

  successfullyClose(){
    this.dealclosingFormTarget.requestSubmit()
  }
}
