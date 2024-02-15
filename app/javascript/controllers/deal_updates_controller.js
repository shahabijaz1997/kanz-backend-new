import { Controller } from "@hotwired/stimulus"
import Dom from '../dom/manipulator'
export default class extends Controller {
  static targets = ['editPrice', 'formPrice', 'savedPrice', 'editValuation', 'formValuation', 'savedValuation',
                    'editRentalAmount', 'formRentalAmount', 'savedRentalAmount', 'editRentalPeriod', 'formRentalPeriod', 'savedRentalPeriod']

  editPrice(){
    Dom.addClass(this.savedPriceTarget, 'd-none')
    Dom.removeClass(this.editPriceTarget, 'd-none')
  }

  editValuation(){
    Dom.addClass(this.savedValuationTarget, 'd-none')
    Dom.removeClass(this.editValuationTarget, 'd-none')
  }

  savePrice(){
    this.formPriceTarget.submit()
  }

  saveValuation(){
    this.formValuationTarget.submit()
  }

  editRentalAmount(){
    Dom.addClass(this.savedRentalAmountTarget, 'd-none')
    Dom.removeClass(this.editRentalAmountTarget, 'd-none')
  }

  editRentalPeriod(){
    Dom.addClass(this.savedRentalPeriodTarget, 'd-none')
    Dom.removeClass(this.editRentalPeriodTarget, 'd-none')
  }

  saveRentalAmount(){
    this.formRentalAmountTarget.submit()
  }

  saveRentalPeriod(){
    this.formRentalPeriodTarget.submit()
  }

}
