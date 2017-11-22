var express = require('express');
var router = express();

router.get('/',(req, res, next) => {
    res.render('./Dashboards/dashboard_1.ejs', {title : 'Dashboard v1'});
});

router.get('/Dashboard_2',(req, res, next) => {
    res.render('./Dashboards/dashboard_2.ejs', {title : 'Dashboard v2'});
});

router.get('/Dashboard_3',(req, res, next) => {
    res.render('./Dashboards/dashboard_3.ejs', {title : 'Dashboard v3'});
});
router.get('/Dashboard_4',(req, res, next) => {
    res.render('./Dashboards/dashboard_4.ejs', {title : 'Dashboard v4'});
});
router.get('/Dashboard_5',(req, res, next) => {
    res.render('./Dashboards/dashboard_5.ejs', {title : 'Dashboard v5'});
});

module.exports = router;