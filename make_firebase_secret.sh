#!/bin/bash

if [[ -f src/config/firebase.js ]] ; then rm src/config/firebase.js ; fi

## then build the file one line at a time:

echo "const firebaseConfig = {" >> src/config/firebase.js
echo "  apiKey: \"${apiKey}\"," >> src/config/firebase.js
echo "  authDomain: \"${authDomain}\"," >> src/config/firebase.js
echo "  databaseURL: \"${databaseURL}\"," >> src/config/firebase.js
echo "  projectId: \"${projectId}\"," >> src/config/firebase.js
echo "  storageBucket: \"${storageBucket}\"," >> src/config/firebase.js
echo "  messagingSenderId: \"${messagingSenderId}\"," >> src/config/firebase.js
echo "  appId: \"${appId}\"," >> src/config/firebase.js
echo "};" >> src/config/firebase.js
echo "export default firebaseConfig" >> src/config/firebase.js