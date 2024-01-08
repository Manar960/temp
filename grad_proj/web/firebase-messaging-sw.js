importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");


  
  
firebase.initializeApp({
  apiKey: "AIzaSyBKlOlsVnE0lb5HSuYyusVCkNyLRLOtgVw",
  authDomain: "gradproj-a818c.firebaseapp.com",
  databaseURL: "...",
  projectId: "gradproj-a818c",
  storageBucket: "gradproj-a818c.appspot.com",
  messagingSenderId: "988806572251",
  appId: "1:988806572251:web:e179b7f837efd2f7c8c4fe",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});