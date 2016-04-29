var util = require('util');
var http = require('http');
var port = process.env.PORT || process.env.port || process.env.OPENSHIFT_NODEJS_PORT || 3000;
var ip = process.env.OPENSHIFT_NODEJS_IP || '0.0.0.0';

var PropertiesReader = require('properties-reader');
var properties = PropertiesReader('/etc/node-app/node-app.config');

var server = http.createServer(function (req, res) {

   req.on('data', function (data) {});
   req.on('end', function () {
      console.log("Invoked");
      res.writeHead(200, {'Content-Type': 'text/html'});
      res.write('<html><head><title></title></head>');
      res.write('<body bgcolor="' + properties.get('color') + '">');
//      res.write('<body bgcolor="blue">');
      res.write('<h1>This application is running in: ' + process.env.ENVIRONMENT + '</h1>');
      res.write('</body>');
      res.end('\n');
   });

});
console.log('Initializing Server on ' + ip + ':' + port);
server.listen(port,ip, function(){
   var address = server.address();
   console.log('Server running on ' + address.address + ':' + address.port);
});