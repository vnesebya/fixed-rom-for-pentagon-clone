package main

import (
	"bufio"
	"bytes"
	"fmt"
	"log/slog"
	"os"
        // "strconv"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: ./hexdiff-ascii rom1.bin rom2.bin")
		return
	}

	file1, err := os.Open(os.Args[1])
	if err != nil {
		slog.Default().Error("Can't open first file:", slog.String("error", err.Error()),
			slog.String("path", os.Args[1]))
		return
	}
	defer file1.Close()

	file2, err := os.Open(os.Args[2])
	if err != nil {
		slog.Default().Error("Can't open second file:", slog.String("error", err.Error()),
			slog.String("path", os.Args[1]))
		return
	}
	defer file2.Close()


	reader1 := bufio.NewReader(file1)
	reader2 := bufio.NewReader(file2)

	fmt.Println("\nCompare Results:")
	fmt.Println("|--------|-----------|--------|")
	fmt.Println("| Offset | values    | ascii  |")
	fmt.Println("|--------|-----------|--------|")

	var offset int64 = 0
	var hexlen int64 = 1
	var emptySmbl string = "."

	for {
		b1 := make([]byte, hexlen)
		b2 := make([]byte, hexlen)

		n1, _ := reader1.Read(b1)
		n2, _ := reader2.Read(b2)

		if n1 == 0 && n2 == 0 {
			break
		}
		if !bytes.Equal(b1, b2) {
			// Новая строка
			fmt.Printf("| #%05x | ", offset)

			// Данные файла 1
			 for i := 0; i < n1; i++ {
				fmt.Printf("%02x ", b1[i])
			}
			fmt.Printf ("-> ")

			// Данные файла 2
			for i := 0; i < n2; i++ {
				fmt.Printf("%02x ", b2[i])
			}
			fmt.Printf (" | ")

			// ASCII Файла 1
			for i :=0; i < n2; i++ {
			    if b1[i] >= 0x20  {
		  		fmt.Printf("%1s", string(b1[i]))
			    }else{
			        fmt.Printf("%s", string(emptySmbl))
			    }
			}
			fmt.Printf (" -> ")

			// ASCII файла 2
			for i :=0; i < n2; i++ {
			    if  b2[i] >= 0x20 {
		  		fmt.Printf("%1s", string(b2[i]))
			    }else{
			        fmt.Printf("%s", string(emptySmbl))
			    }
			}
			
			fmt.Print(" |\n")
		}
		offset += hexlen
	}
}
