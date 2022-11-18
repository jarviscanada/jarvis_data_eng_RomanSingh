# Introduction 
The purpose of this application was to explore the Twitter REST API, in order to allow users to post, show, or delete tweets. Twitter REST API end points were called using Java. HTTP requested were executed using a HTTP client, which were signed using the user-provided consumer key/ secret, access token, and token secret. Jackson is used to for the serialization and deserialization of JSON. The spring framework was used to manage the app dependencies, while Maven was used to build and manage the project and its dependencies. JUnit4 and Mockito was used to perform both integration and unit testing, and the app was dockerized for simple distribution. 

# Quick Start
Below are some commands to run the application using the Docker image from Docker Hub.
```
# Post a Tweet
docker run --rm \
-e consumerKey=${consumerKey} \
-e consumerSecret=${consumerSecret} \
-e accessToken=${accessToken} \
-e tokenSecret=${tokenSecret} \
romansingh/twitter_app post "Hello World" "41:75" #coordinates are latitude:longitude

# Finding a tweet by ID (replace last line in docker run command)

romansingh/twitter_app show 1234567891243


# Deleting a tweets by ID (replace last line in docker run command)
romansingh/twitter_app delete "1234567891243"
```
<b>Note</b>: Secrets/Tokens are required for authentication in order to perform these operations which can be set using environment variables.

# Design
## UML Diagram
![UML Diagram](/core_java/twitter/assets/UML.png) 

## Components 
* `TwitterDAO`
  * Builds URIs needed to make HTTP requests using the Twitter API
  * Executes the HTTP requests using the `HttpHelper` class
* `TwitterService` 
  * The service layer handles the business logic, calls the DAO layer to interact with the Twitter REST API, and returns the result
* `Controller` 
  * The controller parses user input from command line arguments, calls the service layer based on the user input, and returns the results
* `App`
  * `Main` method is the entry point for the application
  * Sets up the components and calls the controller to handle user request and returns the response
* `TwitterCLISpringBoot`
  * Utilizes SpringBoot to automatically handle dependencies
  * Calls `run` method in `App`
 
# Models
The Tweet object consists of 10 fields: `created_at`, `id`, `id_str`, `text`, `entities`, `coordinates`, `retweet_count`, `favorite_count`, `favorited`, and `retweeted`.

The Entities object consists of 2 fields: `hashtags` and `user_mentions`.

The Coordinates object consists of 2 fields:  `coordinates` and `type`.

# Spring
The Spring framework and SpringBoot were used for managing dependencies. Annotations are placed in the various classes indicating if they are a component, service, repository or controller. In the `TwitterCLISpringBoot` program, the directory in which to look for the components is specified as an argument to the `@SpringBootApplication` annotation. As well, the `AutoWired` annotation is used to inject the dependencies through the constructor of the `TwitterCLISpringBoot` class.

# Test 
Integration tests using JUnit4 was performed to test each method of the classes along with their dependencies. Tests were performed in lexicographic order using `@FixMethodOrder(MethodSorters.NAME_ASCENDING)` to first create tweets, read said tweets, and finally, delete them. Created tweets were verified to be created on the Twitter platform. Mockito was also used to perform unit testing on classes without their dependencies.

# Deployment
A Dockerfile was used to specify how to create the Docker image. Once the image was built, it was pushed into a DockerHub repository - `romansingh/twitter`.

# Improvements 

Some possible improvements for the project:
* Implement a GUI for better user experience
* Add optional confirmation of tweet text before deleting tweets to ensure that tweets are not deleted by mistake
* Adding features such as the ability to search for tweets 

