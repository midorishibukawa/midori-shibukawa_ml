open Batteries
module D = Dream
module T = Templates

let () = 
    D.run ~port:8080 ~interface:"0.0.0.0"
    @@ D.logger 
    @@ D.memory_sessions
    @@ D.router [
        D.get "/static/**" 
            @@ D.static 
            ~loader:(fun _root path _req -> 
                match Static.read path with 
                | None -> Dream.empty `Not_Found 
                | Some asset -> D.respond asset)
            "";
        D.get "/" (fun _ -> 
            let open Dream_html in
            let open HTML in
            Dream_html.respond 
            @@ T.page
            ~title:"midori shibukawa"
            @@ main [] 
                [ h1 [] 
                    [ strong [class_ "first"] [txt "%s" "MIDORI"]
                    ; strong [class_ "last"] [txt "%s" "SHIBUKAWA"] ]
                ; ul [] 
                        @@ List.map 
                        (fun i -> li [] [a [] [txt "%s" i]]) 
                        ["about"; "blog"; "projects"; "contact"; "resume"]
                ; section [id "background"] 
                    @@ List.map (fun i -> span [id  "%s" ("bg-color-" ^ string_of_int i)] []) (List.of_enum (0--4))
                ]
            )
    ]
