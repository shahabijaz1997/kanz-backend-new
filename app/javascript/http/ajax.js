import Rails from '@rails/ujs'
import _ from 'underscore'

export default class Ajax {
  static get(url, success, error = () => {}, context = {}) {
    Rails.ajax({
      url: url,
      type: 'get',
      success: _.bind(success, context),
      error: _.bind(error, context)
    })
  }

  static post(
    url,
    payload,
    success = () => {},
    error = () => {},
    context = {}
  ) {
    Rails.ajax({
      url: url,
      data: payload,
      type: 'post',
      dataType: 'json',
      success: _.bind(success, context),
      error: _.bind(error, context)
    })
  }
}
