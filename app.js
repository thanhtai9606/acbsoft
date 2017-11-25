var http = require('http')
var express = require('express')
var path = require('path')

var favicon = require('serve-favicon')
var logger = require('morgan')
var methodOverride = require('method-override')
var session = require('express-session')
var bodyParser = require('body-parser')
var errorHandler = require('errorhandler')

var app = express()

// all environments
app.set('port', process.env.PORT || 1234)
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'ejs')
app.use(favicon(path.join(__dirname, '/public/favicon.ico')))
app.use(logger('dev'))
app.use(methodOverride())
app.use(session({ resave: true,
                  saveUninitialized: true,
                  secret: 'uwotm8' }))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(express.static(path.join(__dirname, 'public')))


// Load All Controller
var Dashboard = require('./routes/DashboardsController');
var Customer = require('./routes/CustomerController');
var Products = require('./routes/ProductsController');
var Sales = require('./routes/SalesController');
var Purchase = require('./routes/PurchaseController');
var System = require('./routes/SystemController');
var Invoice = require('./routes/InvoiceController');

app.use('/',Dashboard);
app.use('/Customer/', Customer);
app.use('/Products/', Products);
app.use('/Sales/',Sales);
app.use('/Purchase/',Purchase);
app.use('/System/',System);
app.use('/Invoice/',Invoice);;

// error handling middleware should be loaded after the loading the routes
if (app.get('env') === 'development') {
  app.use(errorHandler())
}

var server = http.createServer(app)
server.listen(app.get('port'), function () {
  console.log('Express server listening on port ' + app.get('port'))
})