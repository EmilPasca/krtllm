# Karate Feature File Producer

import os
import shutil
import subprocess
# Define the project structure
import time

api_name = "petstore"
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
        <dependency>
            <groupId>net.masterthought</groupId>
            <artifactId>cucumber-reporting</artifactId>
            <version>5.7.4</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-core</artifactId>
            <version>2.13.0</version> <!-- Make sure to use a version compatible with your project -->
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>2.13.0</version> <!-- Same as above -->
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
        Results results = Runner.path("classpath:")
                .reportDir("target/karate-reports") // Specify the report directory
                .backupReportDir(false)
                .outputJunitXml(true)
                .outputCucumberJson(true)
                .parallel(1);
        assert results.getFeaturesFailed() == 0;
    }
}
"""

# Write the test runner
with open(os.path.join(karate_runner_path, "KarateTestRunner.java"), "w") as f:
    f.write(runner_content)

# Create the Cucumber Reprot generator
cucumber_report_content = """
package karate;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import net.masterthought.cucumber.json.support.Status;


import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class CucumberReportGenerator {

    public static void main(String[] args) {
        File reportOutputDirectory = new File("target/karate-reports");
        List<String> jsonFiles = new ArrayList<>();
        jsonFiles.add("target/karate-reports"); // path to the Karate JSON output

        String buildNumber = "1";
        String projectName = "Vampi"; //TODO Make dynamic project name

        Configuration configuration = new Configuration(reportOutputDirectory, projectName);
        configuration.setBuildNumber(buildNumber);
        configuration.addClassifications("Platform", System.getProperty("os.name"));
        configuration.addClassifications("Branch", "release/1.0");
//        configuration.setPresentationModes(PresentationMode.RUN_WITH_JENKINS);
//        configuration.setQualifierStatus("someQualifier", Status.PASSED);

        ReportBuilder reportBuilder = new ReportBuilder(jsonFiles, configuration);
        reportBuilder.generateReports();
    }
}
"""

# Write the cucumber report generator
with open(os.path.join(karate_runner_path, "CucumberReportGenerator.java"), "w") as f:
    f.write(cucumber_report_content)    

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
