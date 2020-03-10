package main

import (
	"os"
	"os/exec"
)

func main() {
	cmd := exec.Command(os.Args[1])
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		panic(err)
	}
}
