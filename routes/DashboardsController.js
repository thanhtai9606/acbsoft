var express = require('express');
var router = express();

router.get('/',(req, res, next) => {
    res.render('./Dashboards/dashboard_1.ejs', {title : 'Welcome to Dashboard Page'});
});

module.exports = router;