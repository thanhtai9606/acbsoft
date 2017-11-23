var express = require('express');
var router = express();

router.get('/Index', (req, res, next)=>{
    res.render('./Invoice/Index.ejs', {title: 'Customer Page'});
});
router.get('/Sale', (req, res, next)=>{
    res.render('./Invoice/sale_invoice.ejs', {title: 'Contacts Page'});
});
router.get('/Purchase', (req, res, next)=>{
    res.render('./Invoice/purchase_invoice.ejs', {title: 'Contacts_v2 Page'});
});
router.get('/Order', (req, res, next)=>{
    res.render('./Invoice/order_invoice.ejs', {title: 'Contact List Page'});
});

router.get('/Inventory', (req, res, next)=>{
    res.render('./Invoice/inventory_invoice.ejs', {title: 'Profile Page'});
});

module.exports = router;