const { DynamoDBClient, PutItemCommand } = require("@aws-sdk/client-dynamodb");

const crypto = require("crypto");
 
const client = new DynamoDBClient({});
 
const ORDERS_TABLE_NAME = process.env.ORDERS_TABLE_NAME;
 
exports.handler = async (event) => {

  if (!ORDERS_TABLE_NAME) {

    console.error("Missing ORDERS_TABLE_NAME env var");

    return {

      statusCode: 500,

      body: JSON.stringify({ error: "Server misconfiguration" })

    };

  }
 
  let payload;

  try {

    payload = event.body ? JSON.parse(event.body) : {};

  } catch (err) {

    return {

      statusCode: 400,

      body: JSON.stringify({ error: "Invalid JSON body" })

    };

  }
 
  const orderId = crypto.randomUUID();

  const customerId = payload.customerId || "anonymous";

  const items = payload.items || [];

  const total = payload.total || 0;
 
  const now = new Date().toISOString();
 
  try {

    const command = new PutItemCommand({

      TableName: ORDERS_TABLE_NAME,

      Item: {

        orderId: { S: orderId },

        customerId: { S: customerId },

        createdAt: { S: now },

        total: { N: String(total) },

        status: { S: "PENDING" }

        // You could serialize "items" as JSON if needed

      }

    });
 
    await client.send(command);
 
    return {

      statusCode: 201,

      body: JSON.stringify({

        message: "Order created",

        orderId,

        status: "PENDING"

      })

    };

  } catch (err) {

    console.error("Error creating order", err);

    return {

      statusCode: 500,

      body: JSON.stringify({ error: "Failed to create order" })

    };

  }

};

 
