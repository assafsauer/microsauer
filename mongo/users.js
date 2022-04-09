//
// Products
//
db = db.getSiblingDB('users');
db.users.insertMany([
    {name: 'user', password: 'password', email: 'user@me.com'},
    {name: 'stan', password: 'bigbrain', email: 'stan@instana.com'},
    {name: 'partner-57', password: 'worktogether', email: 'howdy@partner.com'},
    {name: 'datadog', password: 'password', email: 'as.sauer@gmail.com.com'}
]);

// unique index on the name
db.users.createIndex(
    {name: 1},
    {unique: true}
);

