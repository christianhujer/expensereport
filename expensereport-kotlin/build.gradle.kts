import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    id("io.spring.dependency-management") version "1.0.11.RELEASE"
    kotlin("jvm") version "1.6.10"
    kotlin("plugin.jpa") version "1.6.10"
    jacoco
    id("info.solidsoft.pitest") version "1.7.0"
}

group = "com.nelkinda.training"
version = "0.0.1-SNAPSHOT"
java.sourceCompatibility = JavaVersion.VERSION_11

configurations {
    compileOnly {
        extendsFrom(configurations.annotationProcessor.get())
    }
}

repositories {
    mavenCentral()
}

dependencyManagement {
    dependencies {
        dependencySet("io.cucumber:7.3.4") {
            entry("cucumber-java")
            entry("cucumber-junit-platform-engine")
        }
        dependencySet("org.junit.jupiter:5.8.2") {
            entry("junit-jupiter")
            entry("junit-jupiter-api")
            entry("junit-jupiter-engine")
            entry("junit-jupiter-params")
        }
        dependencySet("org.junit.platform:1.8.2") {
            entry("junit-platform-commons")
            entry("junit-platform-engine")
            entry("junit-platform-launcher")
            entry("junit-platform-suite-api")
            entry("junit-platform-suite-commons")
            entry("junit-platform-suite-engine")
        }
        dependency("org.pitest:pitest-junit5-plugin:0.15")
        dependency("org.pitest:pitest-command-line:1.8.0")
    }
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")

    testImplementation("io.cucumber:cucumber-java")
    testImplementation("io.cucumber:cucumber-junit-platform-engine")
    testImplementation("org.junit.jupiter:junit-jupiter")
    testImplementation("org.junit.jupiter:junit-jupiter-api")
    testImplementation("org.junit.jupiter:junit-jupiter-engine")
    testImplementation("org.junit.jupiter:junit-jupiter-params")
    testImplementation("org.junit.platform:junit-platform-commons")
    testImplementation("org.junit.platform:junit-platform-engine")
    testImplementation("org.junit.platform:junit-platform-launcher")
    testImplementation("org.junit.platform:junit-platform-suite-api")
    testImplementation("org.junit.platform:junit-platform-suite-commons")
    testImplementation("org.junit.platform:junit-platform-suite-engine")
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        freeCompilerArgs = listOf("-Xjsr305=strict")
        jvmTarget = "17"
    }
}

jacoco {
    toolVersion = "0.8.7"
}

tasks.test {
    finalizedBy(tasks.jacocoTestReport)
    configure<JacocoTaskExtension> {
        includes = listOf("com.soleilentertainment.*", "com.nelkinda.*")
    }
}

tasks.jacocoTestReport {
    dependsOn(tasks.test)
    reports {
        xml.required.set(true)
        csv.required.set(true)
        html.required.set(true)
    }
}

tasks.jacocoTestCoverageVerification {
    violationRules {
        rule {
            limit {
                minimum = "0.0".toBigDecimal()
            }
        }
    }
}

tasks.check {
    dependsOn(tasks.jacocoTestCoverageVerification)
}

configure<info.solidsoft.gradle.pitest.PitestPluginExtension> {
    avoidCallsTo.set(setOf("kotlin.jvm.internal"))
    targetClasses.set(setOf("com.nelkinda.training.*"))
    pitestVersion.set("1.8.0")
    timestampedReports.set(false)
    outputFormats.set(setOf("XML", "HTML"))
    mutators.set(setOf("DEFAULTS", "STRONGER", "CONSTRUCTOR_CALLS", "INLINE_CONSTS", "REMOVE_CONDITIONALS", "REMOVE_INCREMENTS"))
    mutationThreshold.set(100)
    coverageThreshold.set(100)
}

tasks.withType<Test> {
    useJUnitPlatform()
}

tasks.wrapper {
    gradleVersion = "7.4.2"
    distributionType = Wrapper.DistributionType.ALL
}
