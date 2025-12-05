const getProducts = require("./handlers/getProducts");
const getProductById = require("./handlers/getProductById");
const createOrder = require("./handlers/createOrder");
 
exports.handler = async (event) => {
  const path = event.path || "/";
  const method = event.httpMethod || "GET";
 
  // Basic routing based on path and method
  if (path === "/v1/products" && method === "GET") {
    return getProducts.handler(event);
  }
 
  if (path.startsWith("/v1/products/") && method === "GET") {
    // Example: /v1/products/123
    const id = path.split("/").pop();
    event.pathParameters = { id };
    return getProductById.handler(event);
  }
 
  if (path === "/v1/orders" && method === "POST") {
    return createOrder.handler(event);
  }
 
  return {
    statusCode: 404,
    body: JSON.stringify({
      error: "Route not found",
      path,
      method
    })
  };
};