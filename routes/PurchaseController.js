var express = require('express');
var router = express();

router.get('/Order', (req, res, next)=>{
    res.render('./Purchase/purchase_order.ejs', {title: 'Products Page'});
});
router.get('/Vendor', (req, res, next)=>{
    res.render('./Purchase/vendor_list.ejs', {title: 'Vendor list Page'});
});

module.exports = router;