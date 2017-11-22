var express = require('express');
var router = express();

router.get('/',(req, res, next)=>{
    res.render('./Sales/sale_desktop.ejs',{title: ' Sale Desktop'})
});

router.get('/Header',(req, res, next)=>{
    res.render('./Sales/sale_header.ejs',{title: ' Sale Header Page'})
});
router.get('/Detail',(req, res, next)=>{
    res.render('./Sales/sale_detail.ejs',{title: ' Sale Detail Page'})
});
router.get('/Return',(req, res, next)=>{
    res.render('./Sales/sale_return.ejs',{title: ' Sale Return Page'})
});


module.exports = router;