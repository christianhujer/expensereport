@file:JvmName("Interceptor")

package com.nelkinda.training

import java.io.ByteArrayOutputStream
import java.io.PrintStream

fun interceptStdout(code: () -> Unit): String {
    val originalStdout = System.out
    val interceptedStdout = ByteArrayOutputStream()
    System.setOut(PrintStream(interceptedStdout))
    try {
        code()
    } finally {
        System.setOut(originalStdout)
    }
    return interceptedStdout.toString()
}
