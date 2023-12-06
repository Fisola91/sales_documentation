import * as WebAuthnJSON from "@github/webauthn-json";

function create(callbackUrl, credentialOptions) {
  WebAuthnJSON.create({ "publicKey": credentialOptions }).then(function(credential) {
    callback(callbackUrl, credential);
  }).catch(function(error) {
    showMessage(error);
  });

  console.log("Creating new public key credential...");
}