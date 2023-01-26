const catchAsyncError = require("../middleware/catchAsyncError");
const dbInsertQuery = require("../utils/dbInsertQuery");
const dbQuery = require("../utils/dbQuery");




exports.getproducts = catchAsyncError( async (req, res, next) =>{
    const dbName = 'client' + req.user.id;
    const products = await dbQuery(`select * from product`, dbName);
    res.status(500).json({
        success: true,
        products
    });
});

exports.createProduct = catchAsyncError( async (req, res, next) => {
    const dbName = 'client' + req.user.id;
    const {name, price, description, stock} = req.body;
    if(!name || !price || !stock){
        return res.send(206).json({
            success: false,
            message: "Please give Full Details"
        });
    }
    const product = {
        name, price, description, stock
    }
    await dbInsertQuery(`INSERT INTO product SET ? `, product , dbName);
    res.status(200).json({
        success: true,
        message: "Product Created successfully!"
    });
});

exports.deleteProduct = catchAsyncError( async(req, res, next)=>{
    const { product_id } = req.body;
    const dbName = 'client' + req.user.id;
    await dbQuery(`delete from product where product_id = ${product_id}`, dbName);
    res.status(200).json({
        success: true,
        message: "Product Deleted successfully!"
    });
});