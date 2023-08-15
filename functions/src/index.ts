/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {onRequest} from "firebase-functions/v2/https";
import {onValueCreated} from "firebase-functions/v2/database"
import * as logger from "firebase-functions/logger";

const admin = require("firebase-admin");
admin.initializeApp();

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

const onDateWritten = onValueCreated(
{
    ref: "users/{uid}/warranties/{warranty.id}",
    instance: "reminderDate"
},
(event) => {
    // …
  }
)

export const helloWorld = onRequest((request, response) => {
  logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});
