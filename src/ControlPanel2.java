package earthquake_env;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jason.asSyntax.Atom;
import cartago.*;

public class ControlPanel extends Artifact {

    int i = 0;
    String alert = "";
    String mag = "";
    String lat = "";
    String lon = "";
    String path = "C:\\Users\\AgBr\\Documents\\otavio\\projects\\mas-earthquake\\files\\";

    public void init()  {
        // observable properties
        // defineObsProperty("earthquakes", new ArrayList<String>());
        // defineObsProperty("totalAlert", new HashMap<String,Integer>());
    }

    // @OPERATION public void publish(String alert, String mag, String lat, String lon, String ts)  {
    //     Map<String, String> earthquake = new HashMap<String,String>();
    @OPERATION public void publish(String alert, Object mag, Object lat, Object lon, Object ts)  {
        Map<String, Object> earthquake = new HashMap<String,Object>();
        earthquake.put("alert", alert);
        earthquake.put("magnitude", mag);
        earthquake.put("latitude", lat);
        earthquake.put("longitude", lon);
        earthquake.put("timestamp", ts);

        String fileName = path + ts + ".txt";
        File file = new File(fileName);
        BufferedWriter bf = null;;
        try{
            //create new BufferedWriter for the output file
            bf = new BufferedWriter( new FileWriter(file) );
            //iterate map entries
            for(Map.Entry<String, Object> entry : earthquake.entrySet()){
                //put key and value separated by a colon
                bf.write( entry.getKey() + ":" + entry.getValue() );
                //new line
                bf.newLine();
            }
            bf.flush();
        }catch(IOException e){
            e.printStackTrace();
        }finally{
            try{
                //always close the writer
                bf.close();
            }catch(Exception e){}
        }


        // writing JSON to file:"JSONExample.json" in cwd
        // PrintWriter pw = new PrintWriter("earthquake.json");
        // pw.write(earthquake.toJSONString());
        // pw.flush();
        // pw.close();
    }

    // @OPERATION public void stop()  {
    //     if (! getObsProperty("running").booleanValue())
    //         failed("The protocol is not running, why to stop it?!");
    //
    //     getObsProperty("running").updateValue(false);
    //     getObsProperty("winner").updateValue(new Atom(currentWinner));
    // }
    //
    // @OPERATION public void bid(double bidValue) {
    //     if (! getObsProperty("running").booleanValue())
    //         failed("You can not bid for this auction, it is not running!");
    //
    //     ObsProperty opCurrentValue  = getObsProperty("best_bid");
    //     if (bidValue < opCurrentValue.doubleValue()) {  // the bid is better than the previous
    //         opCurrentValue.updateValue(bidValue);
    //         currentWinner = getCurrentOpAgentId().getAgentName(); // the name of the agent doing this operation
    //     }
    //     System.out.println("Received bid "+bidValue+" from "+getCurrentOpAgentId().getAgentName()+" for "+getObsProperty("task").stringValue());
    // }
}
