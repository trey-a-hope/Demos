const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

//At every minute.
exports.myScheduledCloudFunction = functions.pubsub.schedule('* * * * *').timeZone('America/New_York').onRun(async (context) => {
    //https://crontab.guru/

    // Get reference to document.
    const cfDataDoc = await admin.firestore().collection('cf-data').doc('YAi6rlV6FkYG1fFRqCE7').get();

    // Conver doc to json.
    const data = cfDataDoc.data();

    // Add 5 coins to the user.
    cfDataDoc.ref.update({ 'coins': admin.firestore.FieldValue.increment(5) });

    // TODO: Update to a random name.

    return null;
});