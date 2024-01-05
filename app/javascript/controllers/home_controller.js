import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from '@rails/request.js'

export default class extends Controller {
  static targets = [ "urlquery", "ogurl" ]

  shorten(e){
    const urlQueryElement = this.urlqueryTarget
    const urlQuery = urlQueryElement.value
    const requestData = { og_url: urlQuery }

    this.postShorten(requestData)
    .then(response => {
      const rootUrl = response.root_url
      const keyUrl = response.key
      const shortenedUrl = rootUrl + keyUrl
      window.location.href = shortenedUrl
    })
    .catch(() => {
      alert("Error Happening from Server")
    })
  }

  gotoDestination() {
    const urlElement = this.ogurlTarget
    const urlDestination = urlElement.value
    window.location.href = urlDestination
  }

  async postShorten (bodyRequest) {
    try {
      const request = new FetchRequest(
        'post', '/mappings',
        { body: JSON.stringify(bodyRequest) }
      )
      const response = await request.perform()
      const data = await response.json

      return data
    } catch (error) {
      return error
    }
  }
}
