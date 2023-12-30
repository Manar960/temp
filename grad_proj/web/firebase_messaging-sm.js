// Give the service worker access to Firebase Messaging.
// Note that you can only use Firebase Messaging here. Other Firebase libraries
// are not available in the service worker.
importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing in
// your app's Firebase config object.
// https://firebase.google.com/docs/web/setup#config-object
firebase.initializeApp({
    apiKey: "AIzaSyBKlOlsVnE0lb5HSuYyusVCkNyLRLOtgVw",
    authDomain: "gradproj-a818c.firebaseapp.com",
    projectId: "gradproj-a818c",
    storageBucket: "gradproj-a818c.appspot.com",
    messagingSenderId: "988806572251",
    appId: "1:988806572251:web:e179b7f837efd2f7c8c4fe",
    measurementId: "G-D1CL97P6E5"
});

// Retrieve an instance of Firebase Messaging so that it can handle background
// messages.
const messaging = firebase.messaging();