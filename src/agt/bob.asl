/* Initial beliefs and rules */
alerts([green, yellow, red, orange]).

/* Initial goals */

/* Plans */
+!start(Task)
   <- .print("Waiting participants for task ",Task,"...");
      .wait(1000);
      .df_search(Task, L);
      .print("Participants offering ", Task, " are: ", L);
      .send(L,tell,service(Task));
      .

+earthquake(Alert,Mag,Lat,Lon) : alerts(L) & .member(Alert,L)
  <- .send(Alert, tell, earthquake(Alert,Mag,Lat,Lon));
     .

+earthquake(Alert,Mag,Lat,Lon)
  <- .send(other_cases, tell, earthquake(Alert,Mag,Lat,Lon));
     .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
