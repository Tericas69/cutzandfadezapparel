const { DynamoDBClient, GetItemCommand } = require("@aws-sdk/client-dynamodb");
 
const client = new DynamoDBClient({});
 
const PRODUCTS_TABLE_NAME = process.env.PRODUCTS_TABLE_NAME;
 
exports.handler = async (event) => {

  if (!PRODUCTS_TABLE_NAME) {

    console.error("Missing PRODUCTS_TABLE_NAME env var");

    return {

      statusCode: 500,

      body: JSON.stringify({ error: "Server misconfiguration" })

    };

  }
 
  const productId =

    event?.pathParameters?.id ||

    event?.queryStringParameters?.productId;
 
  if (!productId) {

    return {

      statusCode: 400,

      body: JSON.stringify({ error: "Missing productId" })

    };

  }
 
  try {

    const command = new GetItemCommand({

      TableName: PRODUCTS_TABLE_NAME,

      Key: {

        productId: { S: productId }

      }

    });
 
    const result = await client.send(command);
 
    if (!result.Item) {

      return {

        statusCode: 404,

        body: JSON.stringify({ error: "Product not found" })

      };

    }
 
    const product = {

      productId: result.Item.productId?.S,

      name: result.Item.name?.S,

      price: result.Item.price?.N,

      category: result.Item.category?.S

    };
 
    return {

      statusCode: 200,

      body: JSON.stringify({ product })

    };

  } catch (err) {

    console.error("Error getting product", err);

    return {

      statusCode: 500,

      body: JSON.stringify({ error: "Failed to load product" })

    };

  }

};

 