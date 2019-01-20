package api

import (
	"log"
	"net/http"
	"text/template"

	"github.com/gorilla/mux"
)

func Start(port string) {
	r := mux.NewRouter()
	r.HandleFunc("/install/{target}", InstallHandler)
	http.Handle("/", r)
	log.Println("Starting api")
	log.Fatal(http.ListenAndServe(port, r))
}

func InstallHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	//dir, _ := os.Getwd()
	tmpl, err := template.ParseFiles("templates/install/" + vars["target"])
	if err != nil {
		log.Println(err)
		w.WriteHeader(http.StatusNotFound)
		return
	}
	w.WriteHeader(http.StatusOK)

	tmpl.Execute(w, nil)

}
