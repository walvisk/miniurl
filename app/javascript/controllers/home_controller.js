import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from '@rails/request.js'

export default class extends Controller {
  static targets = [ "urlquery" ]

  shorten(e){
    const urlQueryElement = this.urlqueryTarget
    const urlQuery = urlQueryElement.value
    const requestData = { og_url: urlQuery }

    this.postShorten(requestData)
    .then(response => {
      console.log(response)
    })
    .catch(error => {
      console.log(error)
    })
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
