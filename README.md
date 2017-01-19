# Scaffold for a Barebones Web Application

The objective of this scaffold is to show a fullstack web application application with client code with a mixture of JS scripts, HTML, and also a Kitura application that can be deployed to Bluemix.

No code is produced that we can anticipate a user needing to delete when they actually start coding.

1. `src/client` contains the source files for the web client that will be processed and dropped in `public`.
2. Logging is implemented with HeliumLogger
2. SwiftConfiguration is used an configured to use environment variables (VCAP) first, then use `config/config.json`
3. StaticFileServer is configured to serve content in `public`
4. Controller is produced to encapsulate Router logic
