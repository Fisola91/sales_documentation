import { Controller } from "@hotwired/stimulus"
import * as Credential from "../credential";


// import { MDCTextField } from '@material/textfield';

export default class extends Controller {
  static targets = ["usernameField"]
  create(event) {
    event.preventDefault();

    console.log(event.detail)

    var [data, status, xhr] = event.detail;
    console.log(data);

    let credentialOptions = data


    // Registration
    if (credentialOptions["user"]) {
      // const input = document.querySelector
      var credential_nickname = event.target.querySelector("input[name='registration[nickname]']").value;
      var callback_url = `/registration/callback?credential_nickname =${credential_nickname }`

      Credential.create(encodeURI(callback_url), credentialOptions);
    }
  }
}