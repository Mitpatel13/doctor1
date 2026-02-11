import { getApps, initializeApp } from 'firebase/app';
import { getFirestore } from 'firebase/firestore';

const defaultFirebaseConfig = {
  apiKey: 'AIzaSyCggN-J-s71QjznNcwbB1PC-sSb-zem7dQ',
  authDomain: 'spark-dating-5c7fc.firebaseapp.com',
  projectId: 'spark-dating-5c7fc',
  storageBucket: 'spark-dating-5c7fc.firebasestorage.app',
  messagingSenderId: '190986838288',
  appId: '1:190986838288:web:4e9d2fded8c7097aad8595',
  measurementId: 'G-5V17WSDQTR',
  databaseURL: 'https://spark-dating-5c7fc-default-rtdb.firebaseio.com',
};

const firebaseConfig = {
  apiKey: import.meta.env.VITE_FIREBASE_API_KEY || defaultFirebaseConfig.apiKey,
  authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN || defaultFirebaseConfig.authDomain,
  projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID || defaultFirebaseConfig.projectId,
  storageBucket:
    import.meta.env.VITE_FIREBASE_STORAGE_BUCKET || defaultFirebaseConfig.storageBucket,
  messagingSenderId:
    import.meta.env.VITE_FIREBASE_MESSAGING_SENDER_ID || defaultFirebaseConfig.messagingSenderId,
  appId: import.meta.env.VITE_FIREBASE_APP_ID || defaultFirebaseConfig.appId,
  measurementId:
    import.meta.env.VITE_FIREBASE_MEASUREMENT_ID || defaultFirebaseConfig.measurementId,
  databaseURL: import.meta.env.VITE_FIREBASE_DATABASE_URL || defaultFirebaseConfig.databaseURL,
};

const requiredKeys = [
  'apiKey',
  'authDomain',
  'projectId',
  'storageBucket',
  'messagingSenderId',
  'appId',
];

export const missingFirebaseKeys = requiredKeys.filter((key) => !firebaseConfig[key]);
export const isFirebaseConfigured = missingFirebaseKeys.length === 0;

let app;
let db = null;

if (isFirebaseConfigured) {
  app = getApps().length ? getApps()[0] : initializeApp(firebaseConfig);
  db = getFirestore(app);
}

export { db, firebaseConfig };
