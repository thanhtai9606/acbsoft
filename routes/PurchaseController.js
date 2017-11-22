var express = require('express');
var router = express();

router.get('/', (req, res, next)=>{
    res.render('./Purchase/purchase_desktop.ejs', {title: 'Purchase Desk Page'});
});

router.get('/Header', (req, res, next)=>{
    res.render('./Purchase/purchase_header.ejs', {title: 'Purchase Header Page'});
});

router.get('/Detail', (req, res, next)=>{
    res.render('./Purchase/purchase_detail.ejs', {title: 'Purchase Detail Page'});
});
router.get('/Return', (req, res, next)=>{
    res.render('./Purchase/purchase_return.ejs', {title: 'Purchase Return Page'});
});
router.get('/Inventory', (req, res, next)=>{
    res.render('./Purchase/purchase_inventory.ejs', {title: 'Purchase Inventory Page'});
});
router.get('/Vendor', (req, res, next)=>{
    res.render('./Purchase/vendor_list.ejs', {title: 'Vendor list Page'});
});

module.exports = router;