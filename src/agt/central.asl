/* Initial beliefs and rules */
alerts([green, yellow, red, orange]).
done([]).
/* Initial goals */
// !start(earthquake).

/* Plans */
+!start(Task)
   <- .print("Waiting participants for task ",Task,"...");
      .wait(5000);  // wait participants introduction
      .df_search(Task, L);
      .print("Participants offering ", Task, " are: ", L);
      .send(L,tell,service(Task));
      .

+!allocate : alerts(H)
  <- for ( .member(X,H) ) {
      !distribute(X);    // print all members of the list
     };
    .print("GETTING OTHER CASES...");
    !otherwise;
    .

+!distribute(Alert) : done(D)
  <- .findall(earthquake(Alert,Mag,Lat,Lon), earthquake(Alert,Mag,Lat,Lon),L);
     if (not .empty(L)){
       .print("LIST = ", L);
       .concat(D, L, NL);
       -+done(NL);
       .send(Alert,tell,L);
     }
     .

+!otherwise : done(D)
  <- .findall(earthquake(Alert,Mag,Lat,Lon), earthquake(Alert,Mag,Lat,Lon),T);
     .difference(T,D,R);
     .print("OTHER CASES = ", R);
     .send(other_cases,tell,R);
     .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
