import { Controller } from "@hotwired/stimulus"
import Dom from '../dom/manipulator'
export default class extends Controller {
  static targets = ['editPrice', 'savedPrice', 'savedValuation', 'editValuation', 'savedValuationTypes', 'editValuationTypes',
                    'PriceForm']

  editPrice(){
    Dom.addClass(this.savedPriceTarget, 'd-none')
    Dom.removeClass(this.editPriceTarget, 'd-none')
  }

  editValuation(){
    Dom.addClass(this.savedValuationTarget, 'd-none')
    Dom.removeClass(this.editValuationTarget, 'd-none')
  }

  editValuationTypes(){
    Dom.addClass(this.savedValuationTypesTarget, 'd-none')
    Dom.removeClass(this.editValuationTypesTarget, 'd-none')
  }

  savePrice(){
    this.PriceFormTarget.submit()
  }
}
