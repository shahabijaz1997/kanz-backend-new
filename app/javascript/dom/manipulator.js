export default class {
  static remove(element) {
    element.parentNode.removeChild(element)
  }

  static removeImmidiate(element) {
    element.parentNode.removeChild(element)
  }

  static prepend(html, container) {
    $(container).prepend(html)
  }

  static move(element, to) {
    to.appendChild(element)
  }

  static insertBefore(html, referenceNode) {
    let temp = document.createElement('div')
    temp.innerHTML = html
    return referenceNode.parentNode.insertBefore(temp.firstChild, referenceNode)
  }

  static show(element) {
    element.removeAttribute('hidden')
  }

  static hide(element) {
    element.setAttribute('hidden', true)
  }

  static html(element, html) {
    element.innerHTML = html
  }

  static addClass(element, className) {
    element.classList.add(className)
  }
  static toggleClass(element, className) {
    element.classList.toggle(className)
  }

  static removeClass(element, className) {
    element.classList.remove(className)
  }

  static hasClass(element, className) {
    return element.classList.contains(className)
  }

  static enable(element) {
    this.removeClass(element, 'uk-disabled')
  }

  static disable(element) {
    this.addClass(element, 'uk-disabled')
  }

  static replace(element, html) {
    let temp = document.createElement('div')
    temp.innerHTML = html

    if (element.parentNode) {
      element.parentNode.replaceChild(temp.firstChild, element)
    }
  }

  static reloadWithTurbolinks() {
    Turbolinks.visit(window.location.toString())
  }
}