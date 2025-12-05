const { DynamoDBClient, ScanCommand } = require("@aws-sdk/client-dynamodb");
 
const client = new DynamoDBClient({});
 
const PRODUCTS_TABLE_NAME = process.env.PRODUCTS_TABLE_NAME;
 
exports.handler = async () => {

  if (!PRODUCTS_TABLE_NAME) {

    console.error("Missing PRODUCTS_TABLE_NAME env var");

    return {

      statusCode: 500,

      body: JSON.stringify({ error: "Server misconfiguration" })

    };

  }
 
  try {

    const command = new ScanCommand({

      TableName: PRODUCTS_TABLE_NAME,

      Limit: 50

    });
 
    const result = await client.send(command);
 
    const items = (result.Items || []).map(item => ({

      productId: item.productId?.S,

      name: item.name?.S,

      price: item.price?.N,

      category: item.category?.S

    }));
 
    return {

      statusCode: 200,

      body: JSON.stringify({

        message: "Products fetched successfully",

        products: items

      })

    };

  } catch (err) {

    console.error("Error scanning products table", err);

    return {

      statusCode: 500,

      body: JSON.stringify({ error: "Failed to load products" })

    };

  }

};

 