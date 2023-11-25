module D = Dream
module T = Templates

let () = 
    D.run ~tls:true
    @@ D.logger 
    @@ D.memory_sessions
    @@ D.router [

        D.get "/static/**" @@ D.static "./static";

        D.get "/" (fun _ -> D.html @@ T.page ~title:"hello, world" ~body:"hello, world");
    ]
