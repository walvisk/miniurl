import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home"
export default class extends Controller {
  static targets = [ "urlquery" ]

  shorten(e){
    e.preventDefault()
    const urlQueryElement = this.urlqueryTarget
    const urlQuery = urlQueryElement.value
    const requestData = { url: urlQuery }
    fetch("/mappings/create", {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify(requestData)
    }).then(response => {
      console.log(response)
    }).catch(error => {
      console.log(error)
    })
  }
}
