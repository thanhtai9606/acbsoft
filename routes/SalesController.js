var express = require('express');
var router = express();

router.get('/',(req, res, next)=>{
    res.render('./Sales/sale_desktop.ejs',{title: ' Sale Desktop'})
});

module.exports = router;