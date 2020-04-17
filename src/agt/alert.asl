/* Initial beliefs and rules */
// alerts([green, yellow, red, orange]).
//earthquake(green,"3.94","40.779","-112.053").
/* Initial goals */
!start.

/* Plans */
+!start : .my_name(Me) //& earthquake(Alert,Mag,Lat,Lon)
  <- //focus("controlPanel");
     .print("Agent ", Me, " started.");
     //publish(Alert,Mag,Lat,Lon);
     .

+earthquake(Alert,Mag,Lat,Lon,Ts)[source(S)] : Mag > 5 & .df_search(publish_mqtt, L)
  <- .print("ALERT!!!");
     .print("Asking ", L, " to publish the alert on MQTT");
     // publish(Alert,Mag,Lat,Lon,Ts);
     .send(L, achieve, publish_mqtt(Alert,Mag,Lat,Lon,Ts));
     // -earthquake(Alert,Mag,Lat,Lon,Ts)[source(S)];
     .

+earthquake(Alert,Mag,Lat,Lon,Ts)[source(S)]
  <- .print("It's ok.");
     // publish(Alert,Mag,Lat,Lon,Ts);
     // -earthquake(Alert,Mag,Lat,Lon,Ts)[source(S)];
     .


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
