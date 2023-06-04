const connection = require("../config/database");



class Product{
    
}

//Use category.category_id Or product.category_id to access category_id in SQL Query
/*
    filters = { page: Number/Sting, product_name: String, category_id: Number/String }
*/
Product.find = (columns=['*'], filters) => {
    return new Promise((resolve, reject)=> {
        const resultPerPage=10
        let page=1
        if(filters && filters.page && filters.page>0) page = Number(filters.page);
        let query = `SELECT ${columns.join(', ')} FROM product NATURAL JOIN category WHERE 1`
        if(filters && filters.product_name) query += ' && product_name LIKE ' + connection.escape('%' + filters.product_name + '%') ;
        if(filters && filters.category_id)  query += ' && category_id = ' + connection.escape(filters.category_id) ;
        if(filters && Array.isArray(filters.product_id)) query += ' && product_id IN (' + connection.escape(filters.product_id) + ')'
        query += ' LIMIT ' + ((connection.escape(page)-1)*resultPerPage) + ',' + resultPerPage;
        // console.log(query);
        connection.query(query, (err, result)=> {
            if(err) reject(err);
            resolve(result);
        })
    });
}

Product.findById = (id) =>{
    return new Promise((resolve, reject)=> {
        connection.query('select * from product where product_id = ?', id, function(err, result) {
            if(err) reject(err);
            resolve(result[0])
        });
        
    });
}

module.exports = Product;