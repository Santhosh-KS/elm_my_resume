package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
)

// TUT: https://www.youtube.com/watch?v=0sRjYzL_oYs
func (app *application) uplaod(w http.ResponseWriter, r *http.Request) {

	// 1. parse input, type multipart/form-data

	r.ParseMultipartForm(10 << 20)

	// 2. Retrieve file from posted form data
	file, handler, err := r.FormFile("myFile")
	if err != nil {
		fmt.Println("Error retriveiving file from form-data: err - ", err)
		return
	}
	defer file.Close()
	fmt.Println("form-data with myFile success")

	fmt.Printf("Upldated file: %+v\n", handler.Filename)
	fmt.Printf("file size: %+v\n", handler.Size)
	fmt.Printf("MIME Header: %+v\n", handler.Header)

	// 3. write temp file in the server
	tempfile, err := os.Create("/tmp/" + handler.Filename)

	if err != nil {
		fmt.Println("Temp file creation failed")
		fmt.Println(err)
		return
	}
	defer tempfile.Close()

	fileBytes, err := io.ReadAll(file)
	if err != nil {
		fmt.Println(" File read all failed")
		fmt.Println(err)
		return
	}

	n, err := tempfile.Write(fileBytes)
	if err != nil {
		fmt.Println(" File write failed")
		fmt.Println(err)
		return
	}
	fmt.Println("SUCCESS: File ", n)
	return
}
