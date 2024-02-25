package com.nelkinda.training;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

public class Interceptor {
    public static String interceptStdout(final Runnable code) {
        final PrintStream originalStdout = System.out;
        final ByteArrayOutputStream interceptedStdout = new ByteArrayOutputStream();
        System.setOut(new PrintStream(interceptedStdout));
        try {
            code.run();
        } finally {
            System.setOut(originalStdout);
        }
        return interceptedStdout.toString();
    }
}
