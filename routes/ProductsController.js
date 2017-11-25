var express = require('express');
var multer = require('multer'); 
var router = express();
var path = require('path');
var storage = multer.diskStorage({
	destination: function(req,  file, callback) {
		callback(null, './public/Images/products')
	},
	filename: function(req, file, callback) {
        callback(null, file.originalname + path.extname(file.originalname));
	}
})



router.get('/', (req, res, next)=>{
    res.render('./Products/products_grid.ejs', {title: 'Products Page'});
});
router.get('/Products_List', (req, res, next)=>{
    res.render('./Products/products_list.ejs', {title: 'Products Lists Page'});
});
router.get('/Products_Grid', (req, res, next)=>{
    res.render('./Products/products_grid.ejs', {title: 'Products Lists Page'});
});
router.get('/Products_Edit', (req, res, next)=>{
    res.render('./Products/products_edit.ejs', {title: 'Products Edit Page'});
});
router.get('/Products_Detail', (req, res, next)=>{
    res.render('./Products/products_detail.ejs', {title: 'Products Detail Page'});
});
router.get('/Products_Cart', (req, res, next)=>{
    res.render('./Products/products_cart.ejs', {title: 'Shopping Cart Page'});
});

router.get('/Products_Order', (req, res, next)=>{
    res.render('./Products/products_order.ejs', {title: 'Products Order Page'});
});

router.get('/Products_Category', (req, res, next)=>{
    res.render('./Products/products_categories.ejs', {title: 'Products Order Page'});
});


router.post('/Products_Image',  (req, res, next)=>{
    var upload = multer({
		storage: storage,
		fileFilter: function(req, file, callback) {
			var ext = path.extname(file.originalname)
			if (ext !== '.png' && ext !== '.jpg' && ext !== '.gif' && ext !== '.jpeg') {
				return callback(res.end('Only images are allowed'), null)
			}
			callback(null, true)
		}
	}).any();
	upload(req, res, function(err) {
         if(err)
         {
            res.json({err: 'File đã tồn tại!\nVui lòng chọn file khác.'})
         }else{
            res.json({success: 'File đã được upload thành công'});
         }
	})
})


router.get('/Products_Image/:imagename', (req, res) => {
    
       
});
 

module.exports = router;