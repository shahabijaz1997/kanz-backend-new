import { Controller } from "@hotwired/stimulus"
import Dom from '../dom/manipulator'


export default class extends Controller {
  static targets = [ "input", "preview" ]

  preview() {
    var output = this.previewTarget

    if (this.inputTarget.files) {
      [...this.inputTarget.files].forEach(file => {
        output.innerHTML += this.addPreview(file)
      })
    }
  }

  remove(event) {
    let newFiles = [...this.inputTarget.files].filter(item =>
      item.name != event.currentTarget.dataset.name
    )
    
    let dataTransfer = new DataTransfer()
    newFiles.forEach(file => dataTransfer.items.add(file))
    

    this.inputTarget.files = dataTransfer.files
  
    Dom.remove(event.currentTarget.parentNode.parentNode)
  }

  addPreview(file) {
    return (
      `
        <div class='preview'>
          <div class='details'>
            <div class='title'>${file.name}.${file.extension} </div>
            <div class='title'>${this.fileSize(file.size)}</div>
          </div>
          <div class='actions'>
            <a class='preview-button' href=${URL.createObjectURL(file)} type='button' target='_blank'>
              <i class='fa fa-vector-square fa-s'></i>
              <span>Preview</span>
            </a>
            <button class='remove' type='button' data-action='click->image-preview#remove' data-name='${file.name}'>
              <i class='fa fa-trash fa-s'></i>
            </button>
          </div>
        </div>
      `
    )
  }

  fileSize(bytes) {
    let unit = ['Bytes','Kb','Mb','Gb','Tb'][Math.floor(Math.log2(bytes)/10)]
    let length = 0, size = parseInt(bytes, 10) || 0;
    
    while(size >= 1024 && ++length) {
      size = size/1024;
    }
    
    return(size.toFixed(size < 10 && length > 0 ? 1 : 0) + ' ' + unit)
  }
}