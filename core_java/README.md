for dir in grep/
jdbc/
twitter/; do
touch /pom.xml;
touch /README.md;
mkdir -p /src/test/java/ca/jrvs/apps/
mkdir -p /src/main/java/ca/jrvs/apps/
done

tree -L 3


