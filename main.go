package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

// response struct
type Message struct {
	Message string `json:"message"`
}

func main() {

	// route: /
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello, World! My name is SMP-Context 🚀")
	})

	// route: /health
	http.HandleFunc("/_status/healthz", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		fmt.Fprintf(w, "OK")
	})

	// route: /api/message
	http.HandleFunc("/api/message", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")

		res := Message{
			Message: "Hello from Go API 🔥",
		}

		json.NewEncoder(w).Encode(res)
	})

	fmt.Println("Server running on :3000")
	http.ListenAndServe(":3000", nil)
}
