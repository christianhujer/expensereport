package interceptor

import (
	"bytes"
	"io"
	"log"
	"os"
)

func InterceptStdout(code func()) string {
	originalStdout := os.Stdout
	read, write, err := os.Pipe()
	if err != nil {
		log.Fatal(err)
	}
	os.Stdout = write

	outC := make(chan string)
	go func() {
		var buf bytes.Buffer
		_, _ = io.Copy(&buf, read)
		outC <- buf.String()
	}()

	code()

	_ = write.Close()

	os.Stdout = originalStdout
	out := <-outC
	_ = read.Close()
	return out
}
