# Introduction

The objective of this Java grep app is to mirror the Linux `Grep` command, a command that performs text searches for defined criteria of words or strings. The 
app performs this command and matches the results to an output file. To compare various methods, two implementations were used. The first method, 
`JavaGrepImp`, makes use of nested `for` loops to scan files for matching strings, while the second implementation, `JavaGrepLambdaImp`, utilizes streams. The project
was written in Java, managed with Maven, and deployed using Docker. 

# Quick Start
The app takes three arguments:
- `regex`: a special text string for describing a search pattern
- `rootpath`: root directory path
- `outFile`: output file name

Below are some quick-start commands to run the application using the Docker image on Docker Hub.

```
regex=".*Romeo.*Juliet.*"
rootPath="./data"
outfile="grep_out.txt"

#Pull the Docker Image from Docker Hub.
docker pull romansingh/grep

#Run the Docker Container.
docker run --rm -v `pwd`/data:/data -v `pwd`/log:/log romansingh/grep ${regex} ${src_dir} /log/${outfile}

#Inspect the outfile for the result.
```

# Implementation 
## Pseudocode
```
matchedLines = []
//Recursively list files in the specified directory.
for file in listFilesRecursively(rootDir)
  for line in readLines(file)
      if containsPattern(line)
        matchedLines.add(line)

//Write the matched lines to the specified output file.
writeToFile(matchedLines)
```

## Performance Issue
The default size of the heap is 5MB, which is an issue because if the file is greater than 5MB an `OutOfMemoryError` occurs. One possible solution is to increase 
the max heap size to ensure that it is greater than the test file size, using the `-Xms` command. However, a more feasible solution is to use stream APIs for the
reading/writing/listing files methods. Instead of storing lines in a list, which takes up memory, stream APIs write directly to the output file.

# Test 
 To perform manual testing a common regex file, William and Shakespeare, was used to test the grep application. To ensure accuracy, extra files and directories were added to /data.
 The `JavaGrepImp` and `JavaGrepLambdaImp` classes implemented `JUnit4` to perform unit testing. 

## Deployment
The Grep App was deployed with Docker for easy distribution. The Dockerfile is as follows:
```
FROM openjdk:8-alpine
COPY target/grep*.jar /usr/local/app/grep/lib/grep.jar
ENTRYPOINT ["java","-jar","/usr/local/app/grep/lib/grep.jar"]
```

## Improvements 
- Provide option to skip specified files and directories.
- Allow options for multiple regex patterns/outputs. 
- Add a GUI to the app to make it more user-friendly. 






















