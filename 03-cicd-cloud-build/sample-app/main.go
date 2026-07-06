// A tiny HTTP server that reports its version, used to prove the CI/CD pipeline
// delivers a change end to end. Bump `version`, push, and watch Cloud Build redeploy.
package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

const version = "1.0.0"

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello, World! Version: %s\n", version)
	})

	// Kubernetes readiness/liveness probe target.
	http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		fmt.Fprintln(w, "ok")
	})

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Printf("sample-app v%s listening on :%s", version, port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
