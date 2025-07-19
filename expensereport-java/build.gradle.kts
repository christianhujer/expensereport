plugins {
    java
    id("org.sonarqube") version "3.3"
    jacoco
    id("info.solidsoft.pitest") version "1.15.0"
    id("io.spring.dependency-management") version "1.0.11.RELEASE"
}

group = "com.nelkinda.training"
version = "0.0.1-SNAPSHOT"

java {
    sourceCompatibility = JavaVersion.VERSION_17
}

repositories {
    mavenCentral()
}

dependencyManagement {
    dependencies {
        dependencySet("io.cucumber:7.26.0") {
            entry("cucumber-java")
            entry("cucumber-junit-platform-engine")
        }
        dependencySet("org.junit.jupiter:5.13.3") {
            entry("junit-jupiter")
            entry("junit-jupiter-api")
            entry("junit-jupiter-engine")
            entry("junit-jupiter-params")
        }
        dependencySet("org.junit.platform:1.13.3") {
            entry("junit-platform-commons")
            entry("junit-platform-engine")
            entry("junit-platform-launcher")
            entry("junit-platform-suite-api")
            entry("junit-platform-suite-commons")
            entry("junit-platform-suite-engine")
        }
        dependencySet("org.mockito:4.5.1") {
            entry("mockito-core")
            entry("mockito-inline")
        }
        dependency("org.pitest:pitest-junit5-plugin:1.2.3")
        dependency("org.pitest:pitest-command-line:1.20.0")
        dependency("org.projectlombok:lombok:1.18.22")
    }
}

dependencies {
    annotationProcessor("org.projectlombok:lombok")
    compileOnly("org.projectlombok:lombok")

    testAnnotationProcessor("org.projectlombok:lombok")
    testCompileOnly("org.projectlombok:lombok")

    testImplementation("io.cucumber:cucumber-java")
    testImplementation("io.cucumber:cucumber-junit-platform-engine")
    testImplementation("org.junit.jupiter:junit-jupiter")
    testImplementation("org.junit.jupiter:junit-jupiter-api")
    testImplementation("org.junit.jupiter:junit-jupiter-engine")
    testImplementation("org.junit.jupiter:junit-jupiter-params")
    testImplementation("org.junit.platform:junit-platform-commons")
    testImplementation("org.junit.platform:junit-platform-engine")
    testImplementation("org.junit.platform:junit-platform-suite-api")
    testImplementation("org.junit.platform:junit-platform-suite-commons")
    testImplementation("org.junit.platform:junit-platform-suite-engine")
    testImplementation("org.mockito:mockito-core")
    testImplementation("org.mockito:mockito-inline")

    pitest("org.pitest:pitest-junit5-plugin")
    pitest("org.pitest:pitest-command-line")
}

jacoco {
    toolVersion = "0.8.12"
}

tasks.jacocoTestCoverageVerification {
    violationRules {
        rule {
            limit {
                minimum = 0.0.toBigDecimal()
            }
        }
    }
}

tasks.check {
    dependsOn(tasks.jacocoTestCoverageVerification)
}

tasks.jacocoTestReport {
    reports {
        xml.required.set(true)
        csv.required.set(true)
        html.required.set(true)
    }
}

tasks.test {
    finalizedBy(tasks.jacocoTestReport)
}

pitest {
    targetClasses.set(listOf("com.nelkinda.training.*"))
    pitestVersion.set("1.20.0")
    timestampedReports.set(false)
    testPlugin.set("junit5")
    outputFormats.set(listOf("XML", "HTML"))
    mutators.set(listOf("DEFAULTS", "STRONGER", "CONSTRUCTOR_CALLS", "INLINE_CONSTS", "REMOVE_CONDITIONALS", "REMOVE_INCREMENTS"))
    mutationThreshold.set(100)
    coverageThreshold.set(100)
}

tasks.test {
    useJUnitPlatform()
}
