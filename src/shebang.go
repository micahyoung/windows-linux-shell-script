package main

import (
	"fmt"
	ps "github.com/mitchellh/go-ps"
	"os"
)

func main() {
	ppid := os.Getppid()
	p, err := ps.FindProcess(ppid)
	if err != nil {
		panic(err)
	}

	fmt.Println("Parent Process ID : ", p.Pid())
	fmt.Println("Grandarent Process ID : ", p.PPid())
	fmt.Println("Process ID binary name : ", p.Executable())
}
