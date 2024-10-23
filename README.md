# app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
<p>
<img src="https://user-images.githubusercontent.com/120082785/220397599-f5b30425-689b-459b-a885-142f62cde580.png" height="50%" width="30%">
<img src="https://user-images.githubusercontent.com/120082785/220398046-f935dcc0-6bfe-453e-8990-c8b968a9abf0.png" height="100%" width="30%">
</p>

{
	"info": {
		"_postman_id": "a4388808-f521-4168-80dc-374ee5413509",
		"name": "TRAVELLERY APP",
		"schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
		"_exporter_id": "30248595"
	},
	"item": [
		{
			"name": "USER",
			"item": [
				{
					"name": "SIGN UP",
					"request": {
						"method": "POST",
						"header": [
							{
								"key": "",
								"value": "",
								"type": "text",
								"disabled": true
							}
						],
						"body": {
							"mode": "formdata",
							"formdata": [
								{
									"key": "profileImage",
									"type": "file",
									"src": "/C:/Users/Brainbinary Infotech/Downloads/default-profile-picture-avatar-photo-placeholder-vector-32286669.png"
								},
								{
									"key": "name",
									"value": "Jhon Doe",
									"type": "text"
								},
								{
									"key": "mobile",
									"value": "9574859658",
									"type": "text"
								},
								{
									"key": "email",
									"value": "jhondoe@gmail.com",
									"type": "text"
								},
								{
									"key": "password",
									"value": "jhondoe",
									"type": "text"
								},
								{
									"key": "confirm_password",
									"value": "jhondoe",
									"type": "text"
								},
								{
									"key": "deviceToken",
									"value": "DeviceToken4",
									"type": "text"
								}
							]
						},
						"url": {
							"raw": "{{base_url}}/user/signup",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"user",
								"signup"
							]
						}
					},
					"response": []
				},
				{
					"name": "LOG IN",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"email\": \"jhondoe@gmail.com\",\r\n    \"password\":\"jhondoe\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/user/login",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"user",
								"login"
							]
						}
					},
					"response": []
				},
				{
					"name": "FORGOT PWD OTP SENT",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"email\":\"jhondoe@gmail.com\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/user/forgot-password",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"user",
								"forgot-password"
							]
						}
					},
					"response": []
				},
				{
					"name": "VERIFY OTP",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"email\": \"jhondoe@gmail.com\",\r\n    \"otp\": 758763\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/user/verfify-otp",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"user",
								"verfify-otp"
							]
						}
					},
					"response": []
				},
				{
					"name": "RESET PASSWORD",
					"request": {
						"method": "PUT",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"email\": \"jhondoe@gmail.com\",\r\n    \"new_password\": \"jhondoee\",\r\n    \"confirm_password\": \"jhondoee\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/user/reset-password",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"user",
								"reset-password"
							]
						}
					},
					"response": []
				},
				{
					"name": "FETCH ALL",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "{{base_url}}/user/",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"user",
								""
							]
						}
					},
					"response": []
				},
				{
					"name": "SINGLE FETCH",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "{{base_url}}/user/671775d87fb924f8aaa26f3b",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"user",
								"671775d87fb924f8aaa26f3b"
							]
						}
					},
					"response": []
				},
				{
					"name": "TOKEN USER FIND",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "{{base_url}}/user/tokenSingleUser?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NzE3NzczMjdmYjkyNGY4YWFhMjZmNzIiLCJpYXQiOjE3Mjk2NTQ5MTZ9.9IZ3ym0iTwdfwKsq_2C1DEp0u2cEAyYZ4tdPc0SwwNA",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"user",
								"tokenSingleUser"
							],
							"query": [
								{
									"key": "token",
									"value": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NzE3NzczMjdmYjkyNGY4YWFhMjZmNzIiLCJpYXQiOjE3Mjk2NTQ5MTZ9.9IZ3ym0iTwdfwKsq_2C1DEp0u2cEAyYZ4tdPc0SwwNA"
								}
							]
						}
					},
					"response": []
				},
				{
					"name": "DELETE",
					"request": {
						"method": "DELETE",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": []
						},
						"url": {
							"raw": "{{base_url}}/user/671775d87fb924f8aaa26f3b",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"user",
								"671775d87fb924f8aaa26f3b"
							]
						}
					},
					"response": []
				},
				{
					"name": "UPDATE",
					"request": {
						"method": "PUT",
						"header": [
							{
								"key": "",
								"value": "",
								"type": "text",
								"disabled": true
							}
						],
						"body": {
							"mode": "formdata",
							"formdata": [
								{
									"key": "profileImage",
									"type": "file",
									"src": "/C:/Users/Brainbinary Infotech/Downloads/developer.jpg"
								},
								{
									"key": "name",
									"value": "Developer",
									"type": "text"
								},
								{
									"key": "mobile",
									"value": "0000000000",
									"type": "text"
								},
								{
									"key": "email",
									"value": "Developer@gmail.com",
									"type": "text"
								}
							]
						},
						"url": {
							"raw": "{{base_url}}/user/671775d87fb924f8aaa26f3b",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"user",
								"671775d87fb924f8aaa26f3b"
							]
						}
					},
					"response": []
				},
				{
					"name": "CHANGE PASSWORD",
					"request": {
						"method": "PUT",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"current_password\": \"jhondoee\",\r\n    \"new_password\": \"jhondoe\",\r\n    \"confirm_password\": \"jhondoe\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/user/change-password/671775d87fb924f8aaa26f3b",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"user",
								"change-password",
								"671775d87fb924f8aaa26f3b"
							]
						}
					},
					"response": []
				}
			]
		},
		{
			"name": "HOME STAY",
			"item": [
				{
					"name": "CREATE",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": [
								{
									"key": "title",
									"value": "Homestay 5",
									"type": "text"
								},
								{
									"key": "homestayType",
									"value": "Luxury",
									"type": "text"
								},
								{
									"key": "accommodationDetails",
									"value": "{\n                \"entirePlace\": false,\n                \"privateRoom\": true,\n                \"maxGuests\": 4,\n                \"bedrooms\": 2,\n                \"singleBed\": 2,\n                \"doubleBed\": 1,\n                \"extraFloorMattress\": 0,\n                \"bathrooms\": 1,\n                \"kitchenAvailable\": false\n}",
									"type": "text"
								},
								{
									"key": "amenities",
									"value": "[\n                {\n                    \"name\": \"Wi-Fi\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n},\n                {\n                    \"name\": \"Fire alaram\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n                },\n                {\n                    \"name\": \"Home Theater\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": true\n                }\n            ]",
									"type": "text"
								},
								{
									"key": "houseRules",
									"value": "[\n                {\n                    \"name\": \"No Smoking\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n                },\n                {\n                    \"name\": \"No Pets\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n                },\n                {\n                    \"name\": \"Damage to Propety\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": true\n                }\n            ]",
									"type": "text"
								},
								{
									"key": "checkInTime",
									"value": "06 : 00 PM",
									"type": "text"
								},
								{
									"key": "checkOutTime",
									"value": "06 : 00 AM",
									"type": "text"
								},
								{
									"key": "flexibleCheckIn",
									"value": "false",
									"type": "text"
								},
								{
									"key": "flexibleCheckOut",
									"value": "false",
									"type": "text"
								},
								{
									"key": "longitude",
									"value": "72.88692069643963",
									"type": "text"
								},
								{
									"key": "latitude",
									"value": "21.245049600735083",
									"type": "text"
								},
								{
									"key": "address",
									"value": "C.401",
									"type": "text"
								},
								{
									"key": "street",
									"value": "Priyank Palace",
									"type": "text"
								},
								{
									"key": "landmark",
									"value": "Sudama Chowk",
									"type": "text"
								},
								{
									"key": "city",
									"value": "Surat",
									"type": "text"
								},
								{
									"key": "pinCode",
									"value": "394101",
									"type": "text"
								},
								{
									"key": "state",
									"value": "Gujrat",
									"type": "text"
								},
								{
									"key": "showSpecificLocation",
									"value": "false",
									"type": "text"
								},
								{
									"key": "coverPhoto",
									"type": "file",
									"src": "/C:/Users/Brainbinary Infotech/Downloads/Filterscreen.png"
								},
								{
									"key": "homestayPhotos",
									"type": "file",
									"src": [
										"/C:/Users/Brainbinary Infotech/Downloads/Filterscreen.png",
										"/C:/Users/Brainbinary Infotech/Downloads/Screenshot 2024-09-30 094214.png"
									]
								},
								{
									"key": "description",
									"value": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
									"type": "text"
								},
								{
									"key": "basePrice",
									"value": "4000",
									"type": "text"
								},
								{
									"key": "weekendPrice",
									"value": "6000",
									"type": "text"
								},
								{
									"key": "ownerContactNo",
									"value": "9876545645",
									"type": "text"
								},
								{
									"key": "ownerEmailId",
									"value": "Owner@gmail.com",
									"type": "text"
								},
								{
									"key": "homestayContactNo",
									"value": "[\n                {\n                    \"contactNo\": \"1415-123-4567\"\n                },\n                {\n                    \"contactNo\": \"2415-123-4567\"\n                },\n                {\n                    \"contactNo\": \"3415-123-4567\"\n                }\n            ]",
									"type": "text"
								},
								{
									"key": "homestayEmailId",
									"value": "[\n                {\n                    \"EmailId\": \"Testing@example.com\"\n                },\n                {\n                    \"EmailId\": \"Testing@example.com\"\n                },\n                {\n                    \"EmailId\": \"sdsd@example.com\"\n                }\n            ]",
									"type": "text"
								},
								{
									"key": "createdBy",
									"value": "671777327fb924f8aaa26f72",
									"type": "text"
								}
							]
						},
						"url": {
							"raw": "{{base_url}}/homestay/create",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay",
								"create"
							]
						}
					},
					"response": []
				},
				{
					"name": "CREATE Copy",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": [
								{
									"key": "title",
									"value": "Testing !!",
									"type": "text"
								},
								{
									"key": "homestayType",
									"value": "Luxury",
									"type": "text"
								},
								{
									"key": "accommodationDetails",
									"value": "{\n                \"entirePlace\": false,\n                \"privateRoom\": true,\n                \"maxGuests\": 4,\n                \"bedrooms\": 2,\n                \"singleBed\": 2,\n                \"doubleBed\": 1,\n                \"extraFloorMattress\": 0,\n                \"bathrooms\": 1,\n                \"kitchenAvailable\": false\n}",
									"type": "text",
									"disabled": true
								},
								{
									"key": "amenities",
									"value": "[\n                {\n                    \"name\": \"Wi-Fi\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n},\n                {\n                    \"name\": \"Fire alaram\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n                },\n                {\n                    \"name\": \"Home Theater\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": true\n                }\n            ]",
									"type": "text",
									"disabled": true
								},
								{
									"key": "houseRules",
									"value": "[\n                {\n                    \"name\": \"No Smoking\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n                },\n                {\n                    \"name\": \"No Pets\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n                },\n                {\n                    \"name\": \"Damage to Propety\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": true\n                }\n            ]",
									"type": "text",
									"disabled": true
								},
								{
									"key": "checkInTime",
									"value": "06:00 AM",
									"type": "text",
									"disabled": true
								},
								{
									"key": "checkOutTime",
									"value": "06:00 PM",
									"type": "text",
									"disabled": true
								},
								{
									"key": "flexibleCheckIn",
									"value": "false",
									"type": "text",
									"disabled": true
								},
								{
									"key": "flexibleCheckOut",
									"value": "false",
									"type": "text",
									"disabled": true
								},
								{
									"key": "longitude",
									"value": "72.95787528361579",
									"type": "text",
									"disabled": true
								},
								{
									"key": "latitude",
									"value": "21.269560301981965",
									"type": "text",
									"disabled": true
								},
								{
									"key": "address",
									"value": "C.401",
									"type": "text",
									"disabled": true
								},
								{
									"key": "street",
									"value": "Priyank Palace",
									"type": "text",
									"disabled": true
								},
								{
									"key": "landmark",
									"value": "Sudama Chowk",
									"type": "text",
									"disabled": true
								},
								{
									"key": "city",
									"value": "Surat",
									"type": "text",
									"disabled": true
								},
								{
									"key": "pinCode",
									"value": "394101",
									"type": "text",
									"disabled": true
								},
								{
									"key": "state",
									"value": "Gujrat",
									"type": "text",
									"disabled": true
								},
								{
									"key": "showSpecificLocation",
									"value": "false",
									"type": "text",
									"disabled": true
								},
								{
									"key": "coverPhoto",
									"type": "file",
									"src": "/C:/Users/Brainbinary Infotech/Downloads/Screenshot 2024-10-22 175601.png"
								},
								{
									"key": "homestayPhotos",
									"type": "file",
									"src": [
										"/C:/Users/Brainbinary Infotech/Downloads/Screenshot 2024-09-20 153106.png",
										"/C:/Users/Brainbinary Infotech/Downloads/Screenshot 2024-09-20 152744.png",
										"/C:/Users/Brainbinary Infotech/Downloads/Screenshot 2024-09-20 152303.png",
										"/C:/Users/Brainbinary Infotech/Downloads/Screenshot 2024-09-20 144714.png",
										"/C:/Users/Brainbinary Infotech/Downloads/Screenshot 2024-09-20 144525.png",
										"/C:/Users/Brainbinary Infotech/Downloads/Screenshot 2024-09-20 144305.png"
									]
								},
								{
									"key": "description",
									"value": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
									"type": "text",
									"disabled": true
								},
								{
									"key": "basePrice",
									"value": "100",
									"type": "text",
									"disabled": true
								},
								{
									"key": "weekendPrice",
									"value": "200",
									"type": "text",
									"disabled": true
								},
								{
									"key": "ownerContactNo",
									"value": "9876545645",
									"type": "text",
									"disabled": true
								},
								{
									"key": "ownerEmailId",
									"value": "Owner@gmail.com",
									"type": "text",
									"disabled": true
								},
								{
									"key": "homestayContactNo",
									"value": "[\n                {\n                    \"contactNo\": \"1415-123-4567\"\n                },\n                {\n                    \"contactNo\": \"2415-123-4567\"\n                },\n                {\n                    \"contactNo\": \"3415-123-4567\"\n                }\n            ]",
									"type": "text",
									"disabled": true
								},
								{
									"key": "homestayEmailId",
									"value": "[\n                {\n                    \"EmailId\": \"Testing@example.com\"\n                },\n                {\n                    \"EmailId\": \"Testing@example.com\"\n                },\n                {\n                    \"EmailId\": \"sdsd@example.com\"\n                }\n            ]",
									"type": "text",
									"disabled": true
								},
								{
									"key": "createdBy",
									"value": "671777327fb924f8aaa26f72",
									"type": "text"
								}
							]
						},
						"url": {
							"raw": "{{base_url}}/homestay/create",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay",
								"create"
							]
						}
					},
					"response": []
				},
				{
					"name": "UPDATE HOMESTAY",
					"request": {
						"method": "PUT",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": [
								{
									"key": "title",
									"value": "Homestay 5",
									"type": "text"
								},
								{
									"key": "homestayType",
									"value": "Eco-Friendly",
									"type": "text"
								},
								{
									"key": "accommodationDetails",
									"value": "{\n                \"entirePlace\": false,\n                \"privateRoom\": true,\n                \"maxGuests\": 4,\n                \"bedrooms\": 2,\n                \"singleBed\": 2,\n                \"doubleBed\": 1,\n                \"extraFloorMattress\": 0,\n                \"bathrooms\": 1,\n                \"kitchenAvailable\": false\n}",
									"type": "text"
								},
								{
									"key": "amenities",
									"value": "[\n                {\n                    \"name\": \"Wi-Fi\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n},\n                {\n                    \"name\": \"Fire alaram\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n                },\n                {\n                    \"name\": \"Home Theater\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": true\n                }\n            ]",
									"type": "text"
								},
								{
									"key": "houseRules",
									"value": "[\n                {\n                    \"name\": \"No Smoking\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n                },\n                {\n                    \"name\": \"No Pets\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n                },\n                {\n                    \"name\": \"Damage to Propety\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": true\n                }\n            ]",
									"type": "text"
								},
								{
									"key": "checkInTime",
									"value": "12:00 PM",
									"type": "text"
								},
								{
									"key": "checkOutTime",
									"value": "12:00 AM",
									"type": "text"
								},
								{
									"key": "flexibleCheckIn",
									"value": "false",
									"type": "text"
								},
								{
									"key": "flexibleCheckOut",
									"value": "false",
									"type": "text"
								},
								{
									"key": "longitude",
									"value": "72.91457067532707",
									"type": "text"
								},
								{
									"key": "latitude",
									"value": "21.241461789531407",
									"type": "text"
								},
								{
									"key": "address",
									"value": "A.502",
									"type": "text"
								},
								{
									"key": "street",
									"value": "Priyank Palace",
									"type": "text"
								},
								{
									"key": "landmark",
									"value": "Sudama Chowk",
									"type": "text"
								},
								{
									"key": "city",
									"value": "Surat",
									"type": "text"
								},
								{
									"key": "pinCode",
									"value": "394101",
									"type": "text"
								},
								{
									"key": "state",
									"value": "Gujrat",
									"type": "text"
								},
								{
									"key": "showSpecificLocation",
									"value": "false",
									"type": "text"
								},
								{
									"key": "coverPhoto",
									"type": "file",
									"src": "/C:/Users/Brainbinary Infotech/Downloads/george-account-page.webp"
								},
								{
									"key": "homestayPhotos",
									"type": "file",
									"src": [
										"/C:/Users/Brainbinary Infotech/Downloads/Phone.png",
										"/C:/Users/Brainbinary Infotech/Downloads/Line.png"
									]
								},
								{
									"key": "description",
									"value": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
									"type": "text"
								},
								{
									"key": "startPrice",
									"value": "100",
									"type": "text"
								},
								{
									"key": "endPrice",
									"value": "200",
									"type": "text"
								},
								{
									"key": "ownerContactNo",
									"value": "9876545645",
									"type": "text"
								},
								{
									"key": "ownerEmailId",
									"value": "Owner@gmail.com",
									"type": "text"
								},
								{
									"key": "homestayContactNo",
									"value": "[\n                {\n                    \"contactNo\": \"0415-123-4567\"\n                },\n                {\n                    \"contactNo\": \"0415-123-4567\"\n                },\n                {\n                    \"contactNo\": \"0415-123-4567\"\n                }\n            ]",
									"type": "text"
								},
								{
									"key": "homestayEmailId",
									"value": "[\n                {\n                    \"EmailId\": \"0Testing@example.com\"\n                },\n                {\n                    \"EmailId\": \"0Testing@example.com\"\n                },\n                {\n                    \"EmailId\": \"0Testing@example.com\"\n                }\n            ]",
									"type": "text"
								},
								{
									"key": "createdBy",
									"value": "6708a92dafec72bf5fa081d8",
									"type": "text"
								},
								{
									"key": "status",
									"value": "Pending Approval",
									"type": "text"
								}
							]
						},
						"url": {
							"raw": "{{base_url}}/homestay/UpdateHomestay/6715db08104e3b9356fd9518",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay",
								"UpdateHomestay",
								"6715db08104e3b9356fd9518"
							]
						}
					},
					"response": []
				},
				{
					"name": "UPDATE HOMESTAY Copy",
					"request": {
						"method": "PUT",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": [
								{
									"key": "title",
									"value": "Homestay 0",
									"type": "text",
									"disabled": true
								},
								{
									"key": "homestyType",
									"value": "Eco-Friendly",
									"type": "text",
									"disabled": true
								},
								{
									"key": "accommodationDetails",
									"value": "{\n                \"entirePlace\": false,\n                \"privateRoom\": true,\n                \"maxGuests\": 4,\n                \"bedrooms\": 2,\n                \"singleBed\": 2,\n                \"doubleBed\": 1,\n                \"extraFloorMattress\": 0,\n                \"bathrooms\": 1,\n                \"kitchenAvailable\": false\n}",
									"type": "text",
									"disabled": true
								},
								{
									"key": "amenities",
									"value": "[\n                {\n                    \"name\": \"Wi-Fi\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n},\n                {\n                    \"name\": \"Fire alaram\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n                },\n                {\n                    \"name\": \"Home Theater\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": true\n                }\n            ]",
									"type": "text",
									"disabled": true
								},
								{
									"key": "houseRules",
									"value": "[\n                {\n                    \"name\": \"No Smoking\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n                },\n                {\n                    \"name\": \"No Pets\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": false\n                },\n                {\n                    \"name\": \"Damage to Propety\",\n                    \"isChecked\": true,\n                    \"isNewAdded\": true\n                }\n            ]",
									"type": "text",
									"disabled": true
								},
								{
									"key": "checkInTime",
									"value": "2021-12-31T00:00:00.000Z",
									"type": "text",
									"disabled": true
								},
								{
									"key": "checkOutTime",
									"value": "2021-12-31T00:00:00.000Z",
									"type": "text",
									"disabled": true
								},
								{
									"key": "flexibleCheckIn",
									"value": "false",
									"type": "text",
									"disabled": true
								},
								{
									"key": "flexibleCheckOut",
									"value": "false",
									"type": "text",
									"disabled": true
								},
								{
									"key": "longitude",
									"value": "72.91457067532707",
									"type": "text",
									"disabled": true
								},
								{
									"key": "latitude",
									"value": "21.241461789531407",
									"type": "text",
									"disabled": true
								},
								{
									"key": "address",
									"value": "A.502",
									"type": "text",
									"disabled": true
								},
								{
									"key": "street",
									"value": "Priyank Palace",
									"type": "text",
									"disabled": true
								},
								{
									"key": "landmark",
									"value": "Sudama Chowk",
									"type": "text",
									"disabled": true
								},
								{
									"key": "city",
									"value": "Surat",
									"type": "text",
									"disabled": true
								},
								{
									"key": "pinCode",
									"value": "394101",
									"type": "text",
									"disabled": true
								},
								{
									"key": "state",
									"value": "Gujrat",
									"type": "text",
									"disabled": true
								},
								{
									"key": "showSpecificLocation",
									"value": "false",
									"type": "text",
									"disabled": true
								},
								{
									"key": "coverPhoto",
									"type": "file",
									"src": "/C:/Users/Brainbinary Infotech/Downloads/softify it 512x512.png"
								},
								{
									"key": "homestayPhotos",
									"type": "file",
									"src": [
										"/C:/Users/Brainbinary Infotech/Downloads/Phone.png",
										"/C:/Users/Brainbinary Infotech/Downloads/Line.png"
									]
								},
								{
									"key": "description",
									"value": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
									"type": "text",
									"disabled": true
								},
								{
									"key": "basePrice",
									"value": "4000",
									"type": "text",
									"disabled": true
								},
								{
									"key": "weekendPrice",
									"value": "8000",
									"type": "text",
									"disabled": true
								},
								{
									"key": "ownerContactNo",
									"value": "9876545645",
									"type": "text",
									"disabled": true
								},
								{
									"key": "ownerEmailId",
									"value": "Owner@gmail.com",
									"type": "text",
									"disabled": true
								},
								{
									"key": "homestayContactNo",
									"value": "[\n                {\n                    \"contactNo\": \"0415-123-4567\"\n                },\n                {\n                    \"contactNo\": \"0415-123-4567\"\n                },\n                {\n                    \"contactNo\": \"0415-123-4567\"\n                }\n            ]",
									"type": "text",
									"disabled": true
								},
								{
									"key": "homestayEmailId",
									"value": "[\n                {\n                    \"EmailId\": \"0Testing@example.com\"\n                },\n                {\n                    \"EmailId\": \"0Testing@example.com\"\n                },\n                {\n                    \"EmailId\": \"0Testing@example.com\"\n                }\n            ]",
									"type": "text",
									"disabled": true
								},
								{
									"key": "createdBy",
									"value": "6708a92dafec72bf5fa081d8",
									"type": "text",
									"disabled": true
								},
								{
									"key": "status",
									"value": "Pending Approval",
									"type": "text"
								}
							]
						},
						"url": {
							"raw": "{{base_url}}/homestay/UpdateHomestay/67178cba7fb924f8aaa274f6",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay",
								"UpdateHomestay",
								"67178cba7fb924f8aaa274f6"
							]
						}
					},
					"response": []
				},
				{
					"name": "FETCH",
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"auth": {
							"type": "noauth"
						},
						"method": "GET",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": []
						},
						"url": {
							"raw": "{{base_url}}/homestay/?limit=0&skip=0",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay",
								""
							],
							"query": [
								{
									"key": "limit",
									"value": "0"
								},
								{
									"key": "skip",
									"value": "0"
								}
							]
						}
					},
					"response": []
				},
				{
					"name": "FETCH SINGLE",
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"auth": {
							"type": "noauth"
						},
						"method": "GET",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": []
						},
						"url": {
							"raw": "{{base_url}}/homestay/6718845bcca4b317e9d2074b",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay",
								"6718845bcca4b317e9d2074b"
							]
						}
					},
					"response": []
				},
				{
					"name": "FETCH BY RADIUS",
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"method": "GET",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": []
						},
						"url": {
							"raw": "{{base_url}}/homestay?radius=20&longitude=72.84367951222454&latitude=21.19464848155703",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay"
							],
							"query": [
								{
									"key": "radius",
									"value": "20"
								},
								{
									"key": "longitude",
									"value": "72.84367951222454"
								},
								{
									"key": "latitude",
									"value": "21.19464848155703"
								}
							]
						}
					},
					"response": []
				},
				{
					"name": "FETCH BY FILTER",
					"event": [
						{
							"listen": "test",
							"script": {
								"exec": [
									""
								],
								"type": "text/javascript",
								"packages": {}
							}
						}
					],
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"method": "GET",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": []
						},
						"url": {
							"raw": "{{base_url}}/homestay",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay"
							],
							"query": [
								{
									"key": "minPrice",
									"value": "4000",
									"disabled": true
								},
								{
									"key": "maxPrice",
									"value": "6000",
									"disabled": true
								},
								{
									"key": "sortByPrice",
									"value": "Lowest to Highest",
									"disabled": true
								},
								{
									"key": "homestayType",
									"value": "Eco-Friendly",
									"disabled": true
								},
								{
									"key": "entirePlace",
									"value": "false",
									"disabled": true
								},
								{
									"key": "privateRoom",
									"value": "true",
									"disabled": true
								},
								{
									"key": "maxGuests",
									"value": "1",
									"disabled": true
								},
								{
									"key": "bedrooms",
									"value": "2",
									"disabled": true
								},
								{
									"key": "singleBed",
									"value": "2",
									"disabled": true
								},
								{
									"key": "doubleBed",
									"value": "1",
									"disabled": true
								},
								{
									"key": "extraFloorMattress",
									"value": "1",
									"disabled": true
								},
								{
									"key": "bathrooms",
									"value": "1",
									"disabled": true
								},
								{
									"key": "kitchenAvailable",
									"value": "false",
									"disabled": true
								},
								{
									"key": "amenities",
									"value": "Wi-Fi,Fire alaram,Home Theater",
									"disabled": true
								},
								{
									"key": "houseRules",
									"value": "No Pets,No Smoking,Damage to Propety",
									"disabled": true
								},
								{
									"key": "status",
									"value": "Pending Approval",
									"disabled": true
								},
								{
									"key": "city",
									"value": "mumbai",
									"disabled": true
								}
							]
						}
					},
					"response": []
				},
				{
					"name": "USER'S ALL HOMESTAY",
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"method": "GET",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": []
						},
						"url": {
							"raw": "{{base_url}}/homestay/UserHomestay/6708a92dafec72bf5fa081d8",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay",
								"UserHomestay",
								"6708a92dafec72bf5fa081d8"
							]
						}
					},
					"response": []
				},
				{
					"name": "DELETE",
					"request": {
						"method": "DELETE",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/homestay/DeleteHomestay/6718845bcca4b317e9d2074b",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay",
								"DeleteHomestay",
								"6718845bcca4b317e9d2074b"
							]
						}
					},
					"response": []
				},
				{
					"name": "HOMESTAY PHOTES ADD",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": [
								{
									"key": "homestayPhotos",
									"type": "file",
									"src": "/C:/Users/Brainbinary Infotech/Downloads/Phone.png"
								}
							]
						},
						"url": {
							"raw": "{{base_url}}/homestay/addHomestayPhotos/?homestayId=67188910b2f54a883ef8a578",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay",
								"addHomestayPhotos",
								""
							],
							"query": [
								{
									"key": "homestayId",
									"value": "67188910b2f54a883ef8a578"
								}
							]
						}
					},
					"response": []
				},
				{
					"name": "HOMESTAY PHOTES UPDATE",
					"request": {
						"method": "PUT",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": [
								{
									"key": "homestayPhotos",
									"type": "file",
									"src": [
										"/C:/Users/Brainbinary Infotech/Downloads/fooddelivery.d78a84df33b25c45fbb1.png",
										"/C:/Users/Brainbinary Infotech/Downloads/socialmedia.b8b6eda425d46871eab2.png",
										"/C:/Users/Brainbinary Infotech/Downloads/one.jpg",
										"/C:/Users/Brainbinary Infotech/Downloads/two.jpg",
										"/C:/Users/Brainbinary Infotech/Downloads/three.jpg",
										"/C:/Users/Brainbinary Infotech/Downloads/four.jpg"
									]
								}
							]
						},
						"url": {
							"raw": "{{base_url}}/homestay/UpdateHomestayPhotos/?photoIds=671882c7cca4b317e9d206ec,671882c7cca4b317e9d206ed,671882c7cca4b317e9d206ee,671882c7cca4b317e9d206ef,671882c7cca4b317e9d206f0,671882c7cca4b317e9d206f1",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay",
								"UpdateHomestayPhotos",
								""
							],
							"query": [
								{
									"key": "photoIds",
									"value": "671882c7cca4b317e9d206ec,671882c7cca4b317e9d206ed,671882c7cca4b317e9d206ee,671882c7cca4b317e9d206ef,671882c7cca4b317e9d206f0,671882c7cca4b317e9d206f1"
								}
							]
						}
					},
					"response": []
				},
				{
					"name": "HOMESTAY PHOTES DELETE",
					"request": {
						"method": "DELETE",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": []
						},
						"url": {
							"raw": "{{base_url}}/homestay/DeleteHomestayPhotos/?photoIds=67188910b2f54a883ef8a579,67188910b2f54a883ef8a57a,67188910b2f54a883ef8a57b,67188910b2f54a883ef8a57c,67188910b2f54a883ef8a57d,67188910b2f54a883ef8a57e",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay",
								"DeleteHomestayPhotos",
								""
							],
							"query": [
								{
									"key": "photoIds",
									"value": "67188910b2f54a883ef8a579,67188910b2f54a883ef8a57a,67188910b2f54a883ef8a57b,67188910b2f54a883ef8a57c,67188910b2f54a883ef8a57d,67188910b2f54a883ef8a57e"
								}
							]
						}
					},
					"response": []
				},
				{
					"name": "HOMESTAY STATUS CHANGE",
					"request": {
						"method": "PUT",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"action\":\"approve\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/homestay/UpdateHomestayStatus/670e2eeab76cf96336d8dab6",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"homestay",
								"UpdateHomestayStatus",
								"670e2eeab76cf96336d8dab6"
							]
						}
					},
					"response": []
				}
			]
		},
		{
			"name": "CALENDER  SET",
			"item": [
				{
					"name": "CREATE CUSTOM PRICE",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "// Date Format Will Be in YYYY/MM/DD.\r\n{\r\n    \"dates\": [\"2024-10-26\",\"2024-10-27\",\"2024-10-28\",\"2024-10-29\",\"2024-10-30\",\"2024-10-31\"],\r\n    \"customPrice\":8000,\r\n    \"homestayId\": \"670cf5a0e05946f9b36966c7\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/pricedatesetting/",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"pricedatesetting",
								""
							]
						}
					},
					"response": []
				},
				{
					"name": "CREATE NOT AVILABLE",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "// Date Format Will Be in YYYY/MM/DD.\r\n{\r\n    \"dates\": [\"2024-10-27\",\"2024-10-28\",\"2024-10-29\",\"2024-10-30\",\"2024-10-31\"],\r\n    \"notAvailable\":true,\r\n    \"homestayId\": \"670cf5a0e05946f9b36966c7\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/pricedatesetting/",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"pricedatesetting",
								""
							]
						}
					},
					"response": []
				},
				{
					"name": "ALL",
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"method": "GET",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": []
						},
						"url": {
							"raw": "{{base_url}}/pricedatesetting/",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"pricedatesetting",
								""
							]
						}
					},
					"response": []
				},
				{
					"name": "NOT AVAILABLE DATES",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "{{base_url}}/pricedatesetting/notavilabledate/",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"pricedatesetting",
								"notavilabledate",
								""
							]
						}
					},
					"response": []
				},
				{
					"name": "CUSTOM DATES",
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"method": "GET",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": []
						},
						"url": {
							"raw": "{{base_url}}/pricedatesetting/custompricedate/",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"pricedatesetting",
								"custompricedate",
								""
							]
						}
					},
					"response": []
				},
				{
					"name": "DELETE",
					"request": {
						"method": "DELETE",
						"header": [],
						"url": {
							"raw": "{{base_url}}/pricedatesetting/671780ae7fb924f8aaa270db",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"pricedatesetting",
								"671780ae7fb924f8aaa270db"
							]
						}
					},
					"response": []
				}
			]
		},
		{
			"name": "CONTACT US",
			"item": [
				{
					"name": "SENT",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"name\" : \"Jhon Doe\",\r\n    \"email\" : \"jhondoe@gmail.com\",\r\n    \"message\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\",\r\n    \"user_details\":\"671777327fb924f8aaa26f72\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/contactus",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"contactus"
							]
						}
					},
					"response": []
				},
				{
					"name": "GET ALL",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "{{base_url}}/contactus",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"contactus"
							]
						}
					},
					"response": []
				},
				{
					"name": "GET SINGLE",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "{{base_url}}/contactus/671777ba7fb924f8aaa26f75",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"contactus",
								"671777ba7fb924f8aaa26f75"
							]
						}
					},
					"response": []
				},
				{
					"name": "GET USER CONTACT US",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "{{base_url}}/contactus/usercontactus/671777327fb924f8aaa26f72",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"contactus",
								"usercontactus",
								"671777327fb924f8aaa26f72"
							]
						}
					},
					"response": []
				},
				{
					"name": "DELETE",
					"request": {
						"method": "DELETE",
						"header": [],
						"url": {
							"raw": "{{base_url}}/contactus/6711e25c6039beb565e2bf68",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"contactus",
								"6711e25c6039beb565e2bf68"
							]
						}
					},
					"response": []
				}
			]
		},
		{
			"name": "FEEDBACK",
			"item": [
				{
					"name": "ADD",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"feedback_message\": \"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\",\r\n    \"user_details\": \"671777327fb924f8aaa26f72\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/feedback",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"feedback"
							]
						}
					},
					"response": []
				},
				{
					"name": "FETCH ALL",
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"method": "GET",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/feedback",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"feedback"
							]
						}
					},
					"response": []
				},
				{
					"name": "FETCH SINGLE",
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"method": "GET",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/feedback/67177ca37fb924f8aaa26fc4",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"feedback",
								"67177ca37fb924f8aaa26fc4"
							]
						}
					},
					"response": []
				},
				{
					"name": "GET USER FEDDBACK",
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"method": "GET",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/feedback/userfeedback/671777327fb924f8aaa26f72",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"feedback",
								"userfeedback",
								"671777327fb924f8aaa26f72"
							]
						}
					},
					"response": []
				},
				{
					"name": "DELETE",
					"request": {
						"method": "DELETE",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/feedback/6711e2426039beb565e2bf5f",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"feedback",
								"6711e2426039beb565e2bf5f"
							]
						}
					},
					"response": []
				}
			]
		},
		{
			"name": "BOOKING",
			"item": [
				{
					"name": "CREATE",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"userDetail\": \"671777327fb924f8aaa26f72\",\r\n    \"homestayDetail\": \"670e2eeab76cf96336d8dab6\",\r\n    \"checkInDate\": \"2024-10-26\",\r\n    \"checkOutDate\": \"2024-10-31\",\r\n    \"adults\": 10,\r\n    \"children\": 5,\r\n    \"infants\": 2,\r\n    \"totalDaysOrNightsPrice\": 7000,\r\n    \"taxes\": 20,\r\n    \"serviceFee\": 200,\r\n    \"totalAmount\": 5220,\r\n    \"paymentMethod\": \"Phone Pay\",\r\n    \"paymentStatus\": \"Pending\",\r\n    \"reservationConfirmed\": \"false\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/booking/create",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"booking",
								"create"
							]
						}
					},
					"response": []
				},
				{
					"name": "UPDATE",
					"request": {
						"method": "PUT",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"userDetail\": \"671777327fb924f8aaa26f72\",\r\n    \"homestayDetail\": \"670e2eeab76cf96336d8dab6\",\r\n    \"checkInDate\": \"2024-10-26\",\r\n    \"checkOutDate\": \"2024-10-31\",\r\n    \"adults\": 10,\r\n    \"children\": 5,\r\n    \"infants\": 2,\r\n    \"totalDaysOrNightsPrice\": 7000,\r\n    \"taxes\": 20,\r\n    \"serviceFee\": 200,\r\n    \"totalAmount\": 7220,\r\n    \"paymentMethod\": \"Phone Pay\",\r\n    \"paymentStatus\": \"Confirmed\",\r\n    \"reservationConfirmed\": \"true\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/booking/671781b57fb924f8aaa271e9",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"booking",
								"671781b57fb924f8aaa271e9"
							]
						}
					},
					"response": []
				},
				{
					"name": "FETCH ALL",
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"method": "GET",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/booking",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"booking"
							]
						}
					},
					"response": []
				},
				{
					"name": "FETCH SINGLE BOOKING",
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"method": "GET",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/booking/671781b57fb924f8aaa271e9",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"booking",
								"671781b57fb924f8aaa271e9"
							]
						}
					},
					"response": []
				},
				{
					"name": "FETCH USER'S BOOKING",
					"protocolProfileBehavior": {
						"disableBodyPruning": true
					},
					"request": {
						"method": "GET",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/booking/UserBookings/671777327fb924f8aaa26f72",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"booking",
								"UserBookings",
								"671777327fb924f8aaa26f72"
							]
						}
					},
					"response": []
				},
				{
					"name": "DELETE BOOKING",
					"request": {
						"method": "DELETE",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{base_url}}/booking/67178a367fb924f8aaa274cc",
							"host": [
								"{{base_url}}"
							],
							"path": [
								"booking",
								"67178a367fb924f8aaa274cc"
							]
						}
					},
					"response": []
				}
			]
		}
	],
	"auth": {
		"type": "bearer",
		"bearer": [
			{
				"key": "token",
				"value": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NzA4YTkyZGFmZWM3MmJmNWZhMDgxZDgiLCJpYXQiOjE3Mjk1MDI2MzJ9.uu8YsNlUWNSuJfal6M0d4_IOyJTyHxxfQCsBqBgnN0A",
				"type": "string"
			}
		]
	},
	"event": [
		{
			"listen": "prerequest",
			"script": {
				"type": "text/javascript",
				"packages": {},
				"exec": [
					""
				]
			}
		},
		{
			"listen": "test",
			"script": {
				"type": "text/javascript",
				"packages": {},
				"exec": [
					""
				]
			}
		}
	],
	"variable": [
		{
			"key": "base_url",
			"value": "http://localhost:5000",
			"type": "string"
		},
		{
			"key": "local_url",
			"value": "https://travellery-backend.onrender.com",
			"type": "string"
		}
	]
}





import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../screen/auth_flow/signup_page/model/model.dart';
import 'api_uri.dart';

class ApiHelper {
  static final ApiHelper apiHelper = ApiHelper._();
  ApiHelper._();

  Future<void> registerUser(RegistrationModel model) async {
    String url = "${ApiUri.apiUri.baseUrl}${ApiUri.apiUri.signupUrl}";

      FormData formData = FormData.fromMap({
        'name': model.name,
        'mobile': model.mobile,
        'email': model.email,
        'password': model.password,
        'confirm_password': model.confirmPassword,
        'deviceToken': 'deviceToken',
        'profileImage': model.profileImage != null
            ? await MultipartFile.fromFile(model.profileImage!)
            : null,
      });

      final response = await Dio().post(url, data: formData);

      if (response.statusCode == 201) {
        debugPrint('User registered successfully: ${response.data}');
      } else {
        debugPrint('Error: ${response.data}');
        throw Exception('Failed to register user: ${response.data}');
      }

  }
}
class ApiUri{

  static final ApiUri apiUri = ApiUri._();
  ApiUri._();

  String baseUrl = "https://travellery-backend.onrender.com";
  String signupUrl = "/user/signup";
}


  var name = ''.obs;
  var email = ''.obs;
  var mobile = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  RxBool isChecked = false.obs;
  RxBool isLoginPasswordVisible = true.obs;
  RxBool isSignUpPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  RxBool isResetPasswordVisible = true.obs;
  RxBool isResetConfirmPasswordVisible = true.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Rx<CroppedFile?> imageFile = Rx<CroppedFile?>(null);
  final ImagePicker imagePicker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
      final pickedFile = await imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppColors.buttonColor,
              toolbarWidgetColor: Colors.white,
              aspectRatioPresets: [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPresetCustom(),
              ],
            ),
          ],
        );

        if (croppedFile != null) {
          print("Cropped file path: ${croppedFile.path}");
          imageFile.value = croppedFile;
        } else {
          print("No cropped file returned.");
        }
      }
    }

  void signup() {

    RegistrationModel model = RegistrationModel(
      profileImage: imageFile.value?.path,
      name: name.value,
      mobile: mobile.value,
      email: email.value,
      password: password.value,
      confirmPassword: confirmPassword.value,
      deviceToken: 'deviceToken',
    );

    if (name.isNotEmpty && email.isNotEmpty && mobile.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty && imageFile.value!.path.isNotEmpty) {

      ApiHelper.apiHelper.registerUser(model).then((_) {
        Get.snackbar('successfully', 'User registered successfully');
        Get.toNamed(Routes.login);
      });
    }
  }
class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}

class RegistrationModel {
  String? profileImage;
  String name;
  String mobile;
  String email;
  String password;
  String confirmPassword;
  String deviceToken;

  RegistrationModel({
    this.profileImage,
    required this.name,
    required this.mobile,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.deviceToken,
  });
}

import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:travellery_mobile/generated/assets.dart';
import 'package:travellery_mobile/travellery_mobile/screen/auth_flow/controller/auth_controller.dart';
import 'package:travellery_mobile/travellery_mobile/utils/app_radius.dart';
import '../../../../common_widgets/common_button.dart';
import '../../../../routes_app/all_routes_app.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/font_manager.dart';
import '../../../../utils/textFormField.dart';
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 11.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Image.asset(Assets.imagesSplash),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          Strings.createAccount,
                          style: FontManager.semiBold(28),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 6.5.h),
                        Obx(() {
                          return controller.imageFile.value != null
                              ? Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(100)),
                              border: Border.all(
                                  color: AppColors.buttonColor),
                              image: DecorationImage(
                                  image: FileImage(
                                    File(
                                        controller.imageFile.value!.path),
                                  ),
                                  fit: BoxFit.fill),
                            ),
                          )
                              : Image.asset(
                            Assets.imagesProfile,
                            height: 13.1.h,
                            width: 30.w,
                          );
                        }),
                        SizedBox(height: 2.h),
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Select Image Source"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                      controller.pickImage(ImageSource.camera);
                                    },
                                    child: Text("Camera"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                      controller.pickImage(ImageSource.gallery);
                                    },
                                    child: Text("Gallery"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            height: 5.2.h,
                            width: 141,
                            decoration: const BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius:
                              BorderRadius.all(AppRadius.radius10),
                            ),
                            child: Center(
                              child: Text(
                                Strings.addProfileImage,
                                style: FontManager.medium(15.sp,
                                    color: AppColors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(Strings.nameLabel, style: FontManager.regular(14)),
                SizedBox(height: 0.5.h),
                CustomTextField(
                  controller: controller.nameController,
                  hintText: Strings.nameHint,
                  prefixIconImage: Image.asset(Assets.imagesSignupProfile,
                      width: 20, height: 20),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Strings.nameError;
                    }
                    return null;
                  },
                  onSaved: (value) => controller.name.value = value!,
                ),
                SizedBox(height: 3.h),
                Text(Strings.mobileNumberLabel, style: FontManager.regular(14)),
                SizedBox(height: 0.5.h),
                CustomTextField(
                  controller: controller.mobileController,
                  keyboardType: TextInputType.number,
                  hintText: Strings.mobileNumberHint,
                  prefixIconImage:
                  Image.asset(Assets.imagesPhone, width: 20, height: 20),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Strings.mobileNumberError;
                    } else if (value.length < 10) {
                      return Strings.mobileNumberLengthError;
                    }
                    return null;
                  },
                  onSaved: (value) => controller.mobile.value = value!,
                ),
                SizedBox(height: 3.h),
                Text(
                  Strings.emailLabel,
                  style: FontManager.regular(14, color: Colors.black),
                ),
                SizedBox(height: 0.5.h),
                CustomTextField(
                  controller: controller.emailController,
                  hintText: Strings.emailHint,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Strings.emailEmpty;
                    } else if (!GetUtils.isEmail(value)) {
                      return Strings.invalidEmail;
                    }
                    return null;
                  },
                  onChanged: (value) => controller.email.value = value,
                  prefixIconImage: Image.asset(
                    Assets.imagesEmail,
                    height: 20,
                    width: 20,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(Strings.passwordLabel, style: FontManager.regular(14)),
                SizedBox(height: 0.5.h),
                Obx(() => CustomTextField(
                  controller: controller.passwordController,
                  hintText: Strings.passwordHint,
                  prefixIconImage: Image.asset(
                    Assets.imagesPassword,
                    height: 20,
                    width: 20,
                  ),
                  obscureText: !controller.isSignUpPasswordVisible.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Strings.passwordError;
                    } else if (value.length < 6) {
                      return Strings.passwordLengthError;
                    }
                    return null;
                  },
                  onSaved: (value) => controller.password.value = value!,
                  showSuffixIcon: true,
                  onSuffixIconPressed: () {
                    controller.isSignUpPasswordVisible.value =
                    !controller.isSignUpPasswordVisible.value;
                  },
                )),
                SizedBox(height: 3.h),
                Text(Strings.confirmPasswordLabel,
                    style: FontManager.regular(14)),
                SizedBox(height: 0.5.h),
                Obx(() => CustomTextField(
                  controller: controller.confirmPasswordController,
                  hintText: Strings.confirmPasswordHint,
                  prefixIconImage: Image.asset(
                    Assets.imagesPassword,
                    height: 20,
                    width: 20,
                  ),
                  onSaved:(value) => controller.confirmPassword.value = value!,
                  obscureText: !controller.isConfirmPasswordVisible.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Strings.confirmPasswordError;
                    } else if ( controller.confirmPassword.value != controller.password.value) {
                      return Strings.passwordMatchError;
                    }
                    return null;
                  },
                  showSuffixIcon: true,
                  onSuffixIconPressed: () {
                    controller.isConfirmPasswordVisible.value =
                    !controller.isConfirmPasswordVisible.value;
                  },
                )),
                SizedBox(height: 11.9.h),
                CommonButton(
                  title: Strings.signUp,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      debugPrint('qqqqqqqqqqqqqqqqq');
                      controller.signup();
                    }
                  },
                ),
                SizedBox(height: 5.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: Strings.alreadyHaveAccount,
                            style: FontManager.regular(14),
                          ),
                          TextSpan(
                            text: ' ${Strings.login}',
                            style: FontManager.semiBold(14,
                                color: AppColors.buttonColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(Routes.login);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

