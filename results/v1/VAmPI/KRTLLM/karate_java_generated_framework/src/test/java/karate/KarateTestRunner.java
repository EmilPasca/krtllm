
package karate;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

public class KarateTestRunner {
    @Test
    void testFeatureFile() {
        Results results = Runner.path("classpath:")
                .reportDir("target/karate-reports") // Specify the report directory
                .backupReportDir(false)
                .outputJunitXml(true)
                .outputCucumberJson(true)
                .parallel(1);
        assert results.getFeaturesFailed() == 0;
    }
}
