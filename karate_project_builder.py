# Karate Feature File Producer

import os
import shutil
import subprocess
# Define the project structure
import time

api_name = "Swagger_Petstore_Lite"
project_name = f"{api_name}_karate_test"
src_main_java_path = os.path.join(project_name, "src/main/java")
src_test_java_path = os.path.join(project_name, "src/test/java")
src_test_resources_path = os.path.join(project_name, "src/test/resources")
karate_runner_path = os.path.join(src_test_java_path, "karate")

# Create directories
os.makedirs(src_main_java_path, exist_ok=True)
os.makedirs(src_test_java_path, exist_ok=True)
os.makedirs(src_test_resources_path, exist_ok=True)
os.makedirs(karate_runner_path, exist_ok=True)

# Create a pom.xml file with the necessary dependencies
pom_content = f"""<project xmlns="http://maven.apache.org/POM/4.0.0"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.karatellmtests</groupId>
    <artifactId>{project_name}</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <parent>
        <groupId>com.intuit.karate</groupId>
        <artifactId>karate-parent</artifactId>
        <version>1.4.1</version>
    </parent>
    <dependencies>
        <dependency>
            <groupId>com.intuit.karate</groupId>
            <artifactId>karate-junit5</artifactId>
            <version>1.4.1</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <configuration>
                    <includes>
                        <include>**/*Test.java</include>
                        <include>**/*Runner.java</include>
                    </includes>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
"""

# Write the pom.xml file
with open(os.path.join(project_name, "pom.xml"), "w") as f:
    f.write(pom_content)

# Create the Karate test runner
runner_content = """
package karate;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

public class KarateTestRunner {
    @Test
    void testFeatureFile(){
        Results results = Runner.path("classpath:").backupReportDir(false)
                .outputJunitXml(true).outputHtmlReport(true).parallel(1);
        assert results.getFeaturesFailed() == 0;
    }
}
"""

# Write the test runner
with open(os.path.join(karate_runner_path, "KarateTestRunner.java"), "w") as f:
    f.write(runner_content)

# Move feature files to the resources path
base_path = os.getcwd()  # Gets the current working directory which is the project root
source_features_path = os.path.join(base_path, "output", api_name, "test_suite")
target_features_path = src_test_resources_path

# Copy all feature files from the source to the target directory
for filename in os.listdir(source_features_path):
    if filename.endswith(".feature"):  # Ensures only feature files are copied
        shutil.copy(os.path.join(source_features_path, filename), target_features_path)

print(f"All feature files have been copied to {target_features_path}.")
print(f"Maven project {project_name} has been set up with a Karate test runner.")
# Navigate to the project directory and run 'mvn test'
