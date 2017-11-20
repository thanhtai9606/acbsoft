var express = require('express');
var router = express();

router.get('/Order', (req, res, next)=>{
    res.render('./Order/order_products.ejs', {title: 'Products Page'});
});


module.exports = router;