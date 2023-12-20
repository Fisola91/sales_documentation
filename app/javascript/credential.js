import * as WebAuthnJSON from "@github/webauthn-json";

function getCSFRToken() {
  var CSRFSelector = document.querySelector('meta[name="csrf-token"]')
  if (CSRFSelector) {
    return CSRFSelector.getAttribute("content")
  } else {
    return null
  }
}
const callback = (url, body) => {
  console.log(body)
  fetch(url, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "X-CSRF-Token": getCSFRToken()
    },
    body: JSON.stringify(body),
    credentials: "same-origin"
  }).then(response => {
    if (!response.ok) {
      console.log("HTTP error! Status:");
    }
    console.log("hey")
    return response.json(); // Parse the JSON in the response
  }).then(data => {
    console.log(data); // Handle the parsed JSON data
  }).catch(error => {
    console.error('Error:', error);
  });
}


const create = (callbackUrl, credentialOptions) => {
  console.log(credentialOptions)
  WebAuthnJSON.create({ "publicKey": credentialOptions }).then(function(credential) {
    callback(callbackUrl, credential);
    console.log("hey")
  }).catch(function(error) {
    console.error("Error during WebAuthn process:", error);
    // showMessage(error);
  });

  console.log("Creating new public key credential...");
}

const get = (credentialOptions) => {
  WebAuthnJSON.get({ "publicKey": credentialOptions }).then(function(credential) {
    callback("/session/callback", credential);
  }).catch(function(error) {
    console.error(error);
  });

  console.log("Getting public key credential...");
}

export { create};