Prerequisites for building and running backend application:
- java 11+
- maven
- mysql database

Building application is done using following command from a project root directory: 
mvn clean install

For running the application mysql database named "whois" should be created and a user "whois" (identified with the password "whois01!") with full access granted.
Backend application should be started using command:
java -jar target/trosica-whois-1.0.0.jar