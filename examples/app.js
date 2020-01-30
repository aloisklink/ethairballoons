var http = require('http');
var path = require('path');
var hostname = '127.0.0.1';
var port = 3000;
var ethAirBalloons = require('../lib');
var server = http.createServer(function (req, res) {
	res.statusCode = 200;
	res.setHeader('Content-Type', 'text/plain');
	res.end('Hello World');
});

server.listen(port, hostname, function () {
	console.log('Server running at http://' + hostname + ':' + port);
	var savePath = path.resolve(__dirname + '/contracts');
	var ethAirBalloonsProvider = ethAirBalloons('http://localhost:8545', savePath);
	var CarSchema = ethAirBalloonsProvider.createSchema({
		name: "Car",
		contractName: "carsContract",
		properties: [
			{ name: "engine",
				type: "bytes32",
				primaryKey: true
			},
			{ name: "wheels",
				type: "uint"
			}
		]
	});
	CarSchema.deploy(function (CarModel, err) {
		if (err) {
			console.log(err);
		} else {
			var newCarObject = {engine: "V8", wheels: 4};
			var newCarObject2 = {engine: "V9", wheels: 4};
			CarSchema.save(newCarObject, function (res, err) {
				if (err){
					console.log(err);
				}
				CarSchema.save(newCarObject2, function (res, err) {
					if (!err) {
						console.log(res);
					} else {
						console.log(err);
					}
					CarSchema.find(function (res, err) {
						if (!err) {
							console.log(res);
						}
					});
					CarSchema.findById("V9", function (res, err) {
						if (!err) {
							console.log(res);
						}
					});
				});
			});
		}
	});
});