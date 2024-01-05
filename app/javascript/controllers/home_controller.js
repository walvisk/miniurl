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
      console.log(response)
      const rootUrl = response.root_url
      const keyUrl = response.key
      const shortenedUrl = rootUrl + keyUrl
      window.location.href = shortenedUrl
    })
    .catch((error) => {
      alert(`Error Happening from Server,\nmessage: ${error}`)
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
      if (response.ok) {
        const body = await response.json
        return body
      }

      throw new Error(`HTTP error! Status: ${response.statusCode}`);
    } catch (error) {
      throw error
    }
  }
}
