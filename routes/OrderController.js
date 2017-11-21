var express = require('express');
var router = express();

router.get('/Order', (req, res, next)=>{
    res.render('./Products/products_order.ejs', {title: 'Products Page'});
});
router.get('/Vendor', (req, res, next)=>{
    res.render('./Order/vendor_list.ejs', {title: 'Vendor list Page'});
});

module.exports = router;