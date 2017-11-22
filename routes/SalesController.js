var express = require('express');
var router = express();

router.get('/',(req, res, next)=>{
    res.render('./Sales/sale_desktop.ejs',{title: ' Sale Desktop'})
});
router.get('/Sale_List',(req, res, next)=>{
    res.render('./Sales/sale_list.ejs',{title: ' Sale List'})
});
router.get('/Sale_Header',(req, res, next)=>{
    res.render('./Sales/sale_header.ejs',{title: ' Sale Order Header'})
});
router.get('/Sale_Detail',(req, res, next)=>{
    res.render('./Sales/sale_detail.ejs',{title: ' Sale Detail'})
});


module.exports = router;