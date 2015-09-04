var express = require('express');
var bodyParser = require('body-parser');
var app = express();
var cors = require('cors');


app.use(bodyParser.json({
    type: 'application/json'
}));

app.use(cors());

var postgres = require('./lib/postgres');

var userRouter = express.Router();
// A GET to the root of a resource returns a list of that resource
// userRouter.get('/', function(req, res) {});


userRouter.get("/", function(req, res) {
    var sql = 'SELECT * FROM users';
    postgres.client.query(sql, function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve user after create']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET

        // res.json(result.rows);
        // res.contentType('application/json');
        res.json({'Users': result.rows});
        res.end();
    });
});


// A POST to the root of a resource should create a new object
userRouter.post('/', function(req, res) {
    var sql = 'INSERT INTO users (name, username, password) VALUES ($1,$2,$3) RETURNING id';
    // Retrieve the data to insert from the POST body
    var data = [
        req.body.name,
        req.body.username,
        req.body.password
    ];
    postgres.client.query(sql, data, function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Failed to create photo']
            });
        }
        var newUserId = result.rows[0].id;
        var sql = 'SELECT * FROM users WHERE id = $1';
        postgres.client.query(sql, [newUserId], function(err, result) {
            if (err) {
                // We shield our clients from internal errors, but log them
                console.error(err);
                res.statusCode = 500;
                return res.json({
                    errors: ['Could not retrieve user']
                });
            }
            // The request created a new resource object
            res.statusCode = 201;
            // The result of CREATE should be the same as GET
            res.json(result.rows[0]);
        });
    });
});


// We specify a param in our path for the GET of a specific object
userRouter.get('/:id', function(req, res) {
	var thisId = req.params.id;
	var sql = 'SELECT * FROM users WHERE id = $1';
    postgres.client.query(sql, [ thisId ], function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve users']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json(result.rows[0]);
    });
});

// Similar to the GET on an object, to update it we can PATCH
userRouter.patch('/:id', function(req, res) {});

// Delete a specific object
userRouter.delete('/:id', function(req, res) {});

// Attach the routers for their respective paths
app.use('/users', userRouter);


var accountRouter = express.Router();
// A GET to the root of a resource returns a list of that resource
accountRouter.get('/', function(req, res) {
	 var sql = 'SELECT * FROM accounts ORDER BY id';
    postgres.client.query(sql, function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve accounts']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Accounts': result.rows});
        // res.json(result.rows);
    });
});

// A POST to the root of a resource should create a new object
accountRouter.post('/', function(req, res) {});

// We specify a param in our path for the GET of a specific object
accountRouter.get('/:id', function(req, res) {
	var thisId = req.params.id;
	var sql = 'SELECT * FROM accounts WHERE id = $1';
    postgres.client.query(sql, [ thisId ], function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve accounts']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Account': result.rows[0]});
    });
});

// Similar to the GET on an object, to update it we can PATCH
accountRouter.patch('/:id', function(req, res) {});

// Delete a specific object
accountRouter.delete('/:id', function(req, res) {});

// Attach the routers for their respective paths
app.use('/accounts', accountRouter);


var transactionRouter = express.Router();
// A GET to the root of a resource returns a list of that resource
transactionRouter.get('/', function(req, res) {
	 var sql = 'SELECT * FROM transactions ORDER BY created_at';
    postgres.client.query(sql, function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve transactions']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Transactions': result.rows});
        // res.json(result.rows);
    });
});

// A POST to the root of a resource should create a new object
transactionRouter.post('/', function(req, res) {});

// We specify a param in our path for the GET of a specific object
transactionRouter.get('/:id', function(req, res) {
	var thisId = req.params.id;
	var sql = 'SELECT * FROM transactions WHERE id = $1';
    postgres.client.query(sql, [ thisId ], function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve transactions']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Transaction': result.rows[0]});
    });
});

// Similar to the GET on an object, to update it we can PATCH
transactionRouter.patch('/:id', function(req, res) {});

// Delete a specific object
transactionRouter.delete('/:id', function(req, res) {});

// Attach the routers for their respective paths
app.use('/transactions', transactionRouter);


var billRouter = express.Router();
// A GET to the root of a resource returns a list of that resource
billRouter.get('/', function(req, res) {
	 var sql = 'SELECT * FROM bills ORDER BY pay_date';
    postgres.client.query(sql, function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve bills']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Bills': result.rows});
        // res.json(result.rows);
    });
});

// A POST to the root of a resource should create a new object
billRouter.post('/', function(req, res) {});

// We specify a param in our path for the GET of a specific object
billRouter.get('/:id', function(req, res) {
	var thisId = req.params.id;
	var sql = 'SELECT * FROM bills WHERE id = $1';
    postgres.client.query(sql, [ thisId ], function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve bills']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Bill': result.rows[0]});
    });
});

// Similar to the GET on an object, to update it we can PATCH
billRouter.patch('/:id', function(req, res) {});

// Delete a specific object
billRouter.delete('/:id', function(req, res) {});

// Attach the routers for their respective paths
app.use('/bills', billRouter);



var billerRouter = express.Router();
// A GET to the root of a resource returns a list of that resource
billerRouter.get('/', function(req, res) {
	 var sql = 'SELECT * FROM billers ORDER BY id';
    postgres.client.query(sql, function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve billers']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Billers': result.rows});
        // res.json(result.rows);
    });
});

// A POST to the root of a resource should create a new object
billerRouter.post('/', function(req, res) {});

// We specify a param in our path for the GET of a specific object
billerRouter.get('/:id', function(req, res) {
	var thisId = req.params.id;
	var sql = 'SELECT * FROM billers WHERE id = $1';
    postgres.client.query(sql, [ thisId ], function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve billers']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Biller': result.rows[0]});
    });
});

// Similar to the GET on an object, to update it we can PATCH
billerRouter.patch('/:id', function(req, res) {});

// Delete a specific object
billerRouter.delete('/:id', function(req, res) {});

// Attach the routers for their respective paths
app.use('/billers', billerRouter);





var accounttypeRouter = express.Router();
// A GET to the root of a resource returns a list of that resource
accounttypeRouter.get('/', function(req, res) {
	var sql = 'SELECT * FROM accounttypes ORDER BY id';
    postgres.client.query(sql, function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve accounttypes']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Accounttypes': result.rows});
        // res.json(result.rows);
    });
});

// A POST to the root of a resource should create a new object
accounttypeRouter.post('/', function(req, res) {});

// We specify a param in our path for the GET of a specific object
accounttypeRouter.get('/:id', function(req, res) {
	var thisId = req.params.id;
	var sql = 'SELECT * FROM accounttypes WHERE id = $1';
    postgres.client.query(sql, [ thisId ], function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve accounttypes']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Accounttype': result.rows[0]});
    });
});

// Similar to the GET on an object, to update it we can PATCH
accounttypeRouter.patch('/:id', function(req, res) {});

// Delete a specific object
accounttypeRouter.delete('/:id', function(req, res) {});

// Attach the routers for their respective paths
app.use('/accounttypes', accounttypeRouter);




var depositRouter = express.Router();
// A GET to the root of a resource returns a list of that resource
depositRouter.get('/', function(req, res) {
	 var sql = 'SELECT * FROM deposits ORDER BY id';
    postgres.client.query(sql, function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve deposits']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Deposits': result.rows});
        // res.json(result.rows);
    });
});

// A POST to the root of a resource should create a new object
depositRouter.post('/', function(req, res) {});

// We specify a param in our path for the GET of a specific object
depositRouter.get('/:id', function(req, res) {
	var thisId = req.params.id;
	var sql = 'SELECT * FROM deposits WHERE id = $1';
    postgres.client.query(sql, [ thisId ], function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve deposits']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Deposit': result.rows[0]});
    });
});

// Similar to the GET on an object, to update it we can PATCH
depositRouter.patch('/:id', function(req, res) {});

// Delete a specific object
depositRouter.delete('/:id', function(req, res) {});

// Attach the routers for their respective paths
app.use('/deposits', depositRouter);




var recipientRouter = express.Router();
// A GET to the root of a resource returns a list of that resource
recipientRouter.get('/', function(req, res) {
	 var sql = 'SELECT * FROM recipients';
    postgres.client.query(sql, function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve recipients']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Recipients': result.rows});
        // res.json(result.rows);
    });
});

// A POST to the root of a resource should create a new object
recipientRouter.post('/', function(req, res) {});

// We specify a param in our path for the GET of a specific object
recipientRouter.get('/:id', function(req, res) {
	var thisId = req.params.id;
	var sql = 'SELECT * FROM recipients WHERE id = $1';
    postgres.client.query(sql, [ thisId ], function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve recipients']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Recipient': result.rows[0]});
    });
});

// Similar to the GET on an object, to update it we can PATCH
recipientRouter.patch('/:id', function(req, res) {});

// Delete a specific object
recipientRouter.delete('/:id', function(req, res) {});

// Attach the routers for their respective paths
app.use('/recipients', recipientRouter);





var transferRouter = express.Router();
// A GET to the root of a resource returns a list of that resource
transferRouter.get('/', function(req, res) {
	 var sql = 'SELECT * FROM transfers';
    postgres.client.query(sql, function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve transfers']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Transfers': result.rows});
        // res.json(result.rows);
    });
});

// A POST to the root of a resource should create a new object
transferRouter.post('/', function(req, res) {});

// We specify a param in our path for the GET of a specific object
transferRouter.get('/:id', function(req, res) {
	var thisId = req.params.id;
	var sql = 'SELECT * FROM transfers WHERE id = $1';
    postgres.client.query(sql, [ thisId ], function(err, result) {
        if (err) {
            // We shield our clients from internal errors, but log them
            console.error(err);
            res.statusCode = 500;
            return res.json({
                errors: ['Could not retrieve transfers']
            });
        }
        // The request created a new resource object
        res.statusCode = 201;
        // The result of CREATE should be the same as GET
        res.json({'Transfer': result.rows[0]});
    });
});

// Similar to the GET on an object, to update it we can PATCH
transferRouter.patch('/:id', function(req, res) {});

// Delete a specific object
transferRouter.delete('/:id', function(req, res) {});

// Attach the routers for their respective paths
app.use('/transfers', transferRouter);


module.exports = app;
