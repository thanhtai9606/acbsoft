var express = require('express');
var router = express();

router.get('/', (req, res, next)=>{
    res.render('./Products/products_grid.ejs', {title: 'Products Page'});
});
router.get('/Products_List', (req, res, next)=>{
    res.render('./Products/products_list.ejs', {title: 'Products Lists Page'});
});
router.get('/Products_Grid', (req, res, next)=>{
    res.render('./Products/products_grid.ejs', {title: 'Products Lists Page'});
});
router.get('/Products_Edit', (req, res, next)=>{
    res.render('./Products/products_edit.ejs', {title: 'Products Edit Page'});
});
router.get('/Products_Detail', (req, res, next)=>{
    res.render('./Products/products_detail.ejs', {title: 'Contact Detail Page'});
});


module.exports = router;