package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	mux := http.NewServeMux()

	mux.HandleFunc("/", root)
	log.Println("booting on 8080")
	log.Fatal(http.ListenAndServe(":8080", mux))
}

func root(w http.ResponseWriter, r *http.Request) {
	hostname, err := os.Hostname()
	if err != nil {
		log.Printf("error : %s", err.Error())

		w.WriteHeader(http.StatusInternalServerError)
		_, _ = w.Write([]byte(err.Error()))
	}

	log.Printf("hostname : %s", hostname)

	w.WriteHeader(http.StatusOK)
	_, _ = w.Write([]byte(hostname))
}
