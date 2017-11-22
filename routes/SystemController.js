var express = require('express');
var router = express();

router.get('/Index', (req, res, next)=>{
    res.render('./System/Index.ejs', {title: 'Customer Page'});
});

module.exports = router;