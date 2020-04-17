/* Initial beliefs and rules */
alerts([green, yellow, red, orange]).

/* Initial goals */

/* Plans */
+!start(Task)
   <- .print("Looking for service about ", Task, "...");
      .wait(1000);
      .df_search(Task, L);
      .print("Participants are: ", L);
      // add some rule to decide which service to contract
      .send(L,achieve,Task);
      .

+earthquake(Alert,Mag,Lat,Lon,Ts) : alerts(L) & .member(Alert,L)
  <- .send(Alert, tell, earthquake(Alert,Mag,Lat,Lon,Ts));
     .

+earthquake(Alert,Mag,Lat,Lon,Ts)
  <- .send(other_cases, tell, earthquake(Alert,Mag,Lat,Lon,Ts));
     .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
