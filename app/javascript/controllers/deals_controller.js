import { Controller } from "@hotwired/stimulus"
import Dom from '../dom/manipulator'

const spvButton = document.getElementById('spvLink');
const dateSelector = document.getElementById('dateSelector');
const reasonBtn = document.getElementById('reasonBtn');
const dealRefundForm = document.getElementById('dealRefundForm');

export default class extends Controller {
  createSpv(){
    Dom.addClass(dateSelector, 'd-none')
    Dom.addClass(dealRefundForm, 'd-none')
    Dom.removeClass(spvButton, 'disabled')
  }

  extendDate(){
    Dom.removeClass(dateSelector, 'd-none')
    Dom.addClass(spvButton, 'disabled')
    Dom.addClass(dealRefundForm, 'd-none')
  }

  refundAndClose(){
    Dom.removeClass(dealRefundForm, 'd-none')
    Dom.addClass(spvButton, 'disabled')
    Dom.addClass(dateSelector, 'd-none')
  }
}
