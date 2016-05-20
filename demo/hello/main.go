package main

import (
    "encoding/json"
    "fmt"
    "net/http"
    "os"
)

type Message struct {
    Message string `json:"message"`
    From    string `json:"from"`
}

var application = "devcon1"

func response(rw http.ResponseWriter, request *http.Request) {
    message := Message{Message: "Hello Devcon", From: application}

    rw.Header().Set("Content-Type", "application/json")
    rw.WriteHeader(http.StatusOK)
    if err := json.NewEncoder(rw).Encode(message); err != nil {
        panic(err)
    }
}

func main() {
    env_from := os.Getenv("FROM")
    if env_from != "" {
        application = env_from
    }

    fmt.Println(application + " Listening on port 8000")

    http.HandleFunc("/", response)
    http.ListenAndServe(":8000", nil)
}
