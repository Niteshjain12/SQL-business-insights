# Ecom Schema

## 1. Database Modules

| Module    | Tables                                                        |
| --------- | ------------------------------------------------------------- |
| Customers | Customers, Addresses, Customer Addresses                      |
| Products  | Products, Product Variants, Categories, Brands                |
| Orders    | Orders, Order Items, Order Status History                     |
| Payments  | Payment Methods, Payment Intents, Payment Transactions        |
| Returns   | Return Requests, Return Items, Refunds                        |
| Shipping  | Shipments, Shipping Carriers, Shipping Methods                |
| Sessions  | Sessions, Session Events, Session Channels                    |
| Marketing | Marketing Campaigns, Attribution Touches, Coupons, Promotions |
| Inventory | Inventory Items, Inventory Movements                          |
| Loyalty   | Loyalty Accounts, Loyalty Transactions                        |

## 2. Table Inventory

| Table | Business Purpose | Grain | Approx Rows |


| | Table                | Purpose                
| -------------------- | ------------------------ |
| Customers            | Customer master          |
| Orders               | Order header             |
| Order Items          | Items in each order      |
| Products             | Product catalog          |
| Product Variants     | Product SKUs             |
| Categories           | Product categories       |
| Payment Transactions | Payment attempts         |
| Payment Intents      | Payment requests         |
| Refunds              | Refund information       |
| Return Requests      | Customer return requests |
| Return Items         | Returned products        |
| Shipments            | Delivery information     |
| Sessions             | Website visits           |
| Session Events       | User actions             |
| Attribution Touches  | Marketing touchpoints    |
----- | ---------------- | ----- | ----------- |

## 3. Core Tables

Customers
Orders
Order Items
Products
Product Variants
Categories
Sessions
Session Events
Payment Transactions
Payment Intents
Refunds
Return Requests
Return Items
Shipments
Attribution Touches

## 4. Verified Foreign Key Relationships

1. ecom.customer_addresses.address_id → ecom.addresses.address_id
2. ecom.customer_addresses.customer_id → ecom.customers.customer_id
3. ecom.segment_memberships.customer_id → ecom.customers.customer_id
4. ecom.segment_memberships.segment_id → ecom.customer_segments.segment_id
5. ecom.consents.customer_id → ecom.customers.customer_id
6. ecom.sessions.customer_id → ecom.customers.customer_id
7. ecom.sessions.device_id → ecom.devices.device_id
8. ecom.attribution_touches.session_id → ecom.sessions.session_id
9. ecom.categories.parent_id → ecom.categories.category_id
10. ecom.products.brand_id → ecom.brands.brand_id
11. ecom.products.category_id → ecom.categories.category_id
12. ecom.product_variants.product_id → ecom.products.product_id
13. ecom.product_images.product_id → ecom.products.product_id
14. ecom.collection_products.collection_id → ecom.collections.collection_id
15. ecom.collection_products.product_id → ecom.products.product_id
16. ecom.prices.price_list_id → ecom.price_lists.price_list_id
17. ecom.prices.variant_id → ecom.product_variants.variant_id
18. ecom.promotion_rules.promo_id → ecom.promotions.promo_id
19. ecom.promotion_rules.category_id → ecom.categories.category_id
20. ecom.promotion_rules.product_id → ecom.products.product_id
21. ecom.inventory_items.variant_id → ecom.product_variants.variant_id
22. ecom.inventory_movements.variant_id → ecom.product_variants.variant_id
23. ecom.orders.price_list_id → ecom.price_lists.price_list_id
24. ecom.orders.session_id → ecom.sessions.session_id
25. ecom.orders.shipping_address_id → ecom.addresses.address_id
26. ecom.orders.billing_address_id → ecom.addresses.address_id
27. ecom.orders.applied_coupon_id → ecom.coupons.coupon_id
28. ecom.orders.applied_promo_id → ecom.promotions.promo_id
29. ecom.order_items.variant_id → ecom.product_variants.variant_id
30. ecom.order_items.order_id → ecom.orders.order_id
31. ecom.order_status_history.order_id → ecom.orders.order_id
32. ecom.payment_intents.order_id → ecom.orders.order_id
33. ecom.payment_intents.payment_method_id → ecom.payment_methods.payment_method_id
34. ecom.payment_transactions.payment_intent_id → ecom.payment_intents.payment_intent_id
35. ecom.refunds.order_id → ecom.orders.order_id
36. ecom.shipments.order_id → ecom.orders.order_id
37. ecom.shipments.carrier_id → ecom.shipping_carriers.carrier_id
38. ecom.shipments.shipping_method_id → ecom.shipping_methods.shipping_method_id
39. ecom.return_requests.customer_id → ecom.customers.customer_id
40. ecom.return_requests.order_id → ecom.orders.order_id
41. ecom.return_items.return_id → ecom.return_requests.return_id
42. ecom.return_items.variant_id → ecom.product_variants.variant_id
43. ecom.return_items.reason_id → ecom.return_reasons.reason_id
44. ecom.product_reviews.customer_id → ecom.customers.customer_id
45. ecom.product_reviews.product_id → ecom.products.product_id
46. ecom.product_reviews.order_id → ecom.orders.order_id
47. ecom.loyalty_accounts.customer_id → ecom.customers.customer_id
48. ecom.loyalty_transactions.customer_id → ecom.loyalty_accounts.customer_id
49. ecom.loyalty_transactions.order_id → ecom.orders.order_id
50. ecom.experiment_variants.experiment_id → ecom.experiments.experiment_id
51. ecom.experiment_assignments.session_id → ecom.sessions.session_id
52. ecom.experiment_assignments.experiment_id → ecom.experiments.experiment_id
53. ecom.experiment_assignments.exp_variant_id → ecom.experiment_variants.variant_id
54. ecom.notifications.customer_id → ecom.customers.customer_id
55. ecom.session_events.session_id → ecom.sessions.session_id

## 4. Empty Tables

Collections
Collection Products
Consents
