var express = require('express');
var router = express();

router.get('/',(req, res, next)=>{
    res.render('./layouts/demo.ejs', {title : 'Welcome to Dashboard Page'});
});

module.exports = router;