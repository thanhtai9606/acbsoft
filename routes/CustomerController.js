var express = require('express');
var router = express();

router.get('/Index', (req, res, next)=>{
    res.render('./Customer/Index.ejs', {title: 'Customer Page'});
});
router.get('/Contacts', (req, res, next)=>{
    res.render('./Customer/Contacts.ejs', {title: 'Contacts Page'});
});
router.get('/Contacts_v2', (req, res, next)=>{
    res.render('./Customer/Contacts_v2.ejs', {title: 'Contacts_v2 Page'});
});
router.get('/Contacts_List', (req, res, next)=>{
    res.render('./Customer/Contacts_List.ejs', {title: 'Contact List Page'});
});

router.get('/Profile', (req, res, next)=>{
    res.render('./Customer/Profile.ejs', {title: 'Profile Page'});
});

module.exports = router;