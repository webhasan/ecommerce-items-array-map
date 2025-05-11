___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Ecommerce Items Array Map",
  "description": "This template will help you map ecommerce items data as either a single-value array or an array of objects.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "CHECKBOX",
    "name": "isArrayOfObject",
    "checkboxText": "Array Of Object",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "itemsArray",
    "displayName": "Items Array",
    "simpleValueType": true,
    "valueHint": "{{items}}"
  },
  {
    "type": "TEXT",
    "name": "itemKey",
    "displayName": "Item Property Key",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "isArrayOfObject",
        "paramValue": true,
        "type": "NOT_EQUALS"
      }
    ],
    "valueHint": "item_id"
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "mapObject",
    "displayName": "Map Object",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "New Property Name (Target Key)",
        "name": "newPropertyKey",
        "type": "TEXT",
        "valueHint": "id"
      },
      {
        "defaultValue": "",
        "displayName": "Original Property Key or Static Value (e.g. \"retail\")",
        "name": "oldPropertyKey",
        "type": "TEXT",
        "valueHint": "item_id"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "isArrayOfObject",
        "paramValue": true,
        "type": "EQUALS"
      }
    ],
    "help": "For static values, you need to enclose the value in quotation marks. For example, if the static value is retail, you should write it as \"retail\""
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

var isArrayOfObject = data.isArrayOfObject;
var itemsArray = data.itemsArray;
var itemKey = data.itemKey;
var mapObject = data.mapObject;


if(!isArrayOfObject){
 var result = itemsArray.map(function(item) {
   return item[itemKey];
 });
}else {
  var result = itemsArray.map(function(item) {
   var updatedItem = {};
   
   mapObject.forEach(function(keyValue) {
      var newPropertyKey = keyValue.newPropertyKey;
      var oldPropertyKey = keyValue.oldPropertyKey;
      var propertyValue = item[oldPropertyKey];
     
      var firstChr = oldPropertyKey.slice(0,1);
      var lastChr = oldPropertyKey.slice(-1);
     
      if(firstChr === '"' && lastChr === '"' ) {
        updatedItem[newPropertyKey] = oldPropertyKey.slice(1,-1);
      }else if(firstChr === "'" && lastChr === "'" ) {
        updatedItem[newPropertyKey] = oldPropertyKey.slice(1,-1);
      }else {
        updatedItem[newPropertyKey] = propertyValue;
      }
   });
    
   return updatedItem;
 });
}

return result;


___TESTS___

scenarios:
- name: Single Item Array
  code: "const mockData = {\n  itemsArray: [\n    {\n      index: 0,\n      item_id:\
    \ \"shopify_US_7135044173956_41499881439364\",\n      product_id: \"7135044173956\"\
    ,\n      variant_id: \"41499881439364\",\n      item_name: \"Black Leather Bag\"\
    ,\n      quantity: 1,\n      price: 3800,\n      discount: 0,\n      item_brand:\
    \ \"partners-demo\",\n      google_business_vertical: 'retail'\n    },\n    {\n\
    \      index: 1,\n      item_id: \"shopify_US_7135045845124_41499884683396\",\n\
    \      product_id: \"7135045845124\",\n      variant_id: \"41499884683396\",\n\
    \      item_name: \"Anchor Bracelet Mens\",\n      quantity: 2,\n      price:\
    \ 8700,\n      discount: 0,\n      item_category: \"Bracelet\",\n      item_brand:\
    \ \"Company 123\",\n      item_variant: \"Gold\"\n    }\n  ],\n  mapObject: undefined,\
    \ \n  itemKey: 'item_id',\n  isArrayOfObject: undefined\n};\n\nlet variableResult\
    \ = runCode(mockData);\nassertThat(variableResult).isEqualTo([\"shopify_US_7135044173956_41499881439364\"\
    , \"shopify_US_7135045845124_41499884683396\"]);"
- name: Array Of Object
  code: "const mockData = {\n  itemsArray: [\n    {\n      index: 0,\n      item_id:\
    \ \"shopify_US_7135044173956_41499881439364\",\n      product_id: \"7135044173956\"\
    ,\n      variant_id: \"41499881439364\",\n      item_name: \"Black Leather Bag\"\
    ,\n      quantity: 1,\n      price: 3800,\n      discount: 0,\n      item_brand:\
    \ \"partners-demo\",\n    },\n    {\n      index: 1,\n      item_id: \"shopify_US_7135045845124_41499884683396\"\
    ,\n      product_id: \"7135045845124\",\n      variant_id: \"41499884683396\"\
    ,\n      item_name: \"Anchor Bracelet Mens\",\n      quantity: 2,\n      price:\
    \ 8700,\n      discount: 0,\n      item_category: \"Bracelet\",\n      item_brand:\
    \ \"Company 123\",\n      item_variant: \"Gold\"\n    }\n  ],\n  mapObject: [{newPropertyKey:\
    \ 'id', oldPropertyKey: 'item_id'}, {newPropertyKey: 'quantity', oldPropertyKey:\
    \ 'quantity'}], \n  itemKey: undefined,\n  isArrayOfObject: true\n};\n\nlet variableResult\
    \ = runCode(mockData);\nassertThat(variableResult).isEqualTo([{id: \"shopify_US_7135044173956_41499881439364\"\
    , quantity: 1},{id: \"shopify_US_7135045845124_41499884683396\", quantity: 2}]);"
- name: Array Of Object With Static Value
  code: "const mockData = {\n  itemsArray: [\n    {\n      index: 0,\n      item_id:\
    \ \"shopify_US_7135044173956_41499881439364\",\n      product_id: \"7135044173956\"\
    ,\n      variant_id: \"41499881439364\",\n      item_name: \"Black Leather Bag\"\
    ,\n      quantity: 1,\n      price: 3800,\n      discount: 0,\n      item_brand:\
    \ \"partners-demo\",\n    },\n    {\n      index: 1,\n      item_id: \"shopify_US_7135045845124_41499884683396\"\
    ,\n      product_id: \"7135045845124\",\n      variant_id: \"41499884683396\"\
    ,\n      item_name: \"Anchor Bracelet Mens\",\n      quantity: 2,\n      price:\
    \ 8700,\n      discount: 0,\n      item_category: \"Bracelet\",\n      item_brand:\
    \ \"Company 123\",\n      item_variant: \"Gold\"\n    }\n  ],\n  mapObject: [{newPropertyKey:\
    \ 'id', oldPropertyKey: 'item_id'}, {newPropertyKey: 'google_business_vertical',\
    \ oldPropertyKey: '\"retail\"'}], \n  itemKey: undefined,\n  isArrayOfObject:\
    \ true\n};\n\nlet variableResult = runCode(mockData);\nassertThat(variableResult).isEqualTo([{id:\
    \ \"shopify_US_7135044173956_41499881439364\", google_business_vertical: 'retail'},{id:\
    \ \"shopify_US_7135045845124_41499884683396\", google_business_vertical: 'retail'}]);"
setup: ''


___NOTES___

Created on 5/11/2025, 9:45:24 AM


